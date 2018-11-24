import {
  Controller,
  Post,
  UsePipes,
  UseInterceptors,
  ValidationPipe,
  ClassSerializerInterceptor,
  Body,
  UseGuards,
  UseFilters,
  HttpStatus,
} from '@nestjs/common';
import { Repository } from 'typeorm';
import { TrackedApp } from './trackedApp.entity';
import { Allowance } from './allowance.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { AllowanceEventDto } from './allowanceEvent.dto';
import { ApiBearerAuth, ApiResponse } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { EntityNotFoundExceptionFilter } from 'src/core/EntityNotFoundExeptionFilter';
import { AllowanceEventResultDto } from './allowanceEventResult.dto';

@Controller('/fit/allowance')
@UsePipes(ValidationPipe)
@UseInterceptors(ClassSerializerInterceptor)
export class AllowanceController {
  constructor(
    @InjectRepository(TrackedApp)
    private readonly trackedAppRepository: Repository<TrackedApp>,
    @InjectRepository(Allowance)
    private readonly allowanceRepository: Repository<Allowance>,
  ) {}

  @Post('/start')
  @ApiBearerAuth()
  @UseGuards(AuthGuard())
  @UseFilters(new EntityNotFoundExceptionFilter('Tracked app not found.'))
  @ApiResponse({
    status: HttpStatus.OK,
    isArray: false,
    type: AllowanceEventResultDto,
    description: 'Returns further instructions with what to do with the app',
  })
  async allowanceStart(@Body() allowanceEvent: AllowanceEventDto) {
    const trackedApp = await this.trackedAppRepository.findOne({
      where: {
        ...allowanceEvent,
      },
    });
    if (!trackedApp) {
      return {
        allow: true,
        track: false,
        minutesLeft: -1,
      };
    }
    const allowance = await this.allowanceRepository.findOne({
      where: {
        app: {
          id: trackedApp.id,
        },
      },
    });
    if (!allowance) {
      return {
        allow: false,
        track: false,
        minutesLeft: 0,
      };
    }
    allowance.lastSubtracted = new Date();
    return {
      allow: true,
      track: true,
      minutesLeft: allowance.minutesLeft,
    };
  }

  @Post('/ping')
  @ApiBearerAuth()
  @UseGuards(AuthGuard())
  @UseFilters(new EntityNotFoundExceptionFilter('Tracked app not found.'))
  @ApiResponse({
    status: HttpStatus.OK,
    isArray: false,
    type: AllowanceEventResultDto,
    description: 'Returns further instructions with what to do with the app',
  })
  async allowancePing(@Body() allowanceEvent: AllowanceEventDto) {
    const trackedApp = await this.trackedAppRepository.findOne({
      where: {
        ...allowanceEvent,
      },
    });
    if (!trackedApp) {
      return {
        allow: true,
        track: false,
        minutesLeft: -1,
      };
    }
    const allowance = await this.allowanceRepository.findOne({
      where: {
        app: {
          id: trackedApp.id,
        },
      },
    });
    if (!allowance) {
      return {
        allow: false,
        track: false,
        minutesLeft: 0,
      };
    }
    allowance.minutesLeft -=
      (new Date().getTime() - allowance.lastSubtracted.getTime()) / (1000 * 60);
    allowance.lastSubtracted = new Date();
    if (allowance.minutesLeft <= 0) {
      allowance.minutesLeft = 0;
    }
    await this.allowanceRepository.save(allowance);
    return {
      allow: !(allowance.minutesLeft <= 0),
      track: true,
      minutesLeft: allowance.minutesLeft,
    };
  }
}
