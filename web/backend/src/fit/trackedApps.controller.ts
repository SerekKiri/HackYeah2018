import {
  Controller,
  Post,
  Body,
  UseGuards,
  Req,
  UsePipes,
  UseInterceptors,
  ValidationPipe,
  ClassSerializerInterceptor,
  Get,
  HttpCode,
  HttpStatus,
  UseFilters,
  Param,
  ParseIntPipe,
  ConflictException,
} from '@nestjs/common';
import { CreateTrackedAppDto } from './createTrackedApp.dto';
import { ApiBearerAuth, ApiResponse } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { TrackedApp } from './trackedApp.entity';
import { User } from 'src/auth/user.entity';
import { Request } from 'express';
import { plainToClass } from 'class-transformer';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { EntityNotFoundExceptionFilter } from 'src/core/EntityNotFoundExeptionFilter';
import { Allowance } from './allowance.entity';
import { RedeemDto } from './redeem.dto';

@Controller('/fit/tracked-apps')
@UsePipes(ValidationPipe)
@UseInterceptors(ClassSerializerInterceptor)
export class TrackedAppsController {
  constructor(
    @InjectRepository(TrackedApp)
    private readonly trackedAppRepository: Repository<TrackedApp>,
    @InjectRepository(Allowance)
    private readonly allowanceRepository: Repository<Allowance>,
  ) {}

  @Post('/')
  @ApiBearerAuth()
  @UseGuards(AuthGuard())
  @ApiResponse({
    status: HttpStatus.OK,
    isArray: false,
    type: TrackedApp,
  })
  async postTrackedApp(@Body() data: CreateTrackedAppDto, @Req() req: Request) {
    const user: User = (req as any).user.user;
    if (
      await this.trackedAppRepository.findOne({
        where: {
          appIdentifier: data.appIdentifier,
          appType: data.appType,
          user: { id: user.id },
        },
      })
    ) {
      throw new ConflictException(
        'An app with this app identifier for this user exists',
      );
    }
    const trackedApp = plainToClass(TrackedApp, data);

    trackedApp.user = user;
    await this.trackedAppRepository.save(trackedApp);
    return trackedApp;
  }

  @Get('/')
  @ApiBearerAuth()
  @UseGuards(AuthGuard())
  @ApiResponse({
    status: HttpStatus.OK,
    isArray: false,
    type: TrackedApp,
    description: 'Returns tracked apps for user',
  })
  async getTrackedApps(@Req() req: Request) {
    const user: User = (req as any).user.user;
    const trackedApps = await this.trackedAppRepository.find({
      user: {
        id: user.id,
      },
    });
    return trackedApps;
  }

  @Post('/:id/redeem')
  @UseFilters(new EntityNotFoundExceptionFilter('Tracked app not found.'))
  @ApiBearerAuth()
  @UseGuards(AuthGuard())
  async postRedeem(
    @Param('id', ParseIntPipe) id: number,
    @Body() data: RedeemDto,
  ) {
    const trackedApp = await this.trackedAppRepository.findOneOrFail(id);

    let allowance = await this.allowanceRepository.findOne({
      where: {
        app: {
          id: trackedApp.id,
        },
      },
    });

    if (!allowance) {
      allowance = new Allowance();
      allowance.app = trackedApp;
      allowance.minutesLeft = 0;
    }
    allowance.lastSubtracted = new Date();
    allowance.minutesLeft += data.minutes * trackedApp.costPerMinute;
    await this.allowanceRepository.save(allowance);
    return allowance;
  }
}
