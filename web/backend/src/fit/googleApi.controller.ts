import {
  Controller,
  Post,
  Get,
  Res,
  Param,
  Query,
  Req,
  UseGuards,
  HttpStatus,
} from '@nestjs/common';
import { fitness_v1, google } from 'googleapis';

import { Response, Request } from 'express';
import { OauthClientService } from './oauthClient.service';
import { User } from 'src/auth/user.entity';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { ApiBearerAuth, ApiResponse } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { Session } from 'src/auth/session.entity';
import { GoogleRedirectDto } from './googleRedirect.dto';
import { fitness } from 'googleapis/build/src/apis/fitness';
import { ConnectedToGoogleDto } from './connectedToGoogle.dto';
import { activityCodeToName } from './activityCodes';
import { FormattedCaloriesDto } from './formattedCalories.dto';
import { GoogleFitService } from './googleFit.service';

const scopes = [
  'https://www.googleapis.com/auth/fitness.activity.read',
  'https://www.googleapis.com/auth/fitness.location.read',
  'https://www.googleapis.com/auth/fitness.body.read',
  'https://www.googleapis.com/auth/fitness.nutrition.read',
  'https://www.googleapis.com/auth/fitness.oxygen_saturation.read',
];

@Controller('/fit/google')
export default class GoogleApiController {
  constructor(
    private oauthClientService: OauthClientService,
    private googleFitService: GoogleFitService,
    @InjectRepository(User) private readonly userRepository: Repository<User>,
  ) {}
  @Get('/connect')
  @ApiBearerAuth()
  @UseGuards(AuthGuard())
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Redirect url to google apis',
    type: GoogleRedirectDto,
  })
  async postConnect(@Req() req: Request): Promise<GoogleRedirectDto> {
    const user: User = (req as any).user.user;
    const oauth2Client = this.oauthClientService.createOauthClient();
    const url = oauth2Client.generateAuthUrl({
      state: 'userid=' + user.id,
      // 'online' (default) or 'offline' (gets refresh_token)
      access_type: 'offline',

      // If you only need one scope you can pass it as a string
      scope: scopes,
    });
    return {
      redirectUrl: url,
    };
  }

  @Get('/redirect-from-google')
  async redirectFromGoogle(
    @Query('code') code: string,
    @Req() req,
    @Query('code') state: string,
  ) {
    const oauth2Client = this.oauthClientService.createOauthClient();

    const { tokens } = await oauth2Client.getToken(code);
    oauth2Client.setCredentials(tokens);
    const ds = new fitness_v1.Resource$Users$Datasources(
      new fitness_v1.Fitness({
        auth: oauth2Client,
      }),
    );
    const user: User = await this.userRepository.findOne(state.split('=')[1]);
    user.googleTokens = JSON.stringify(tokens);
    await this.userRepository.save(user);
    return '<h1>Everything is okay!</h1>';
  }

  @ApiBearerAuth()
  @UseGuards(AuthGuard())
  @Get('/connected-to-google')
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Checks if is connected to google',
    type: ConnectedToGoogleDto,
  })
  async connectedToGoogle(@Req() req) {
    const user: User = (req as any).user.user;
    return {
      connected: !!user.googleTokens,
    };
  }

  @ApiBearerAuth()
  @UseGuards(AuthGuard())
  @Get('/convertable-calories')
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Returns calories which the user can convert to points',
    type: FormattedCaloriesDto,
    isArray: true,
  })
  async convertableCalories(@Req() req) {
    const user: User = (req as any).user.user;
    return this.googleFitService.getActivitiesForUser(user);
  }

  @ApiBearerAuth()
  @UseGuards(AuthGuard())
  @Get('/ddd')
  async testStuff(@Req() req) {
    const user: User = (req as any).user.user;
    const oauth2Client = this.oauthClientService.createOauthClientWithUser(
      user,
    );
    const ds = new fitness_v1.Resource$Users$Dataset(
      new fitness_v1.Fitness({
        auth: oauth2Client,
      }),
    );

    try {
      const resp = await ds.aggregate({
        userId: 'me',
        requestBody: {
          aggregateBy: [
            { dataTypeName: 'com.google.activity.summary' },
            { dataTypeName: 'com.google.activity.segment' },
          ],
          startTimeMillis: new Date().getTime() - 1000 * 60 * 60 * 24 * 7,
          endTimeMillis: new Date().getTime(),
          bucketByTime: {
              durationMillis: 0,
            period: 1,
            type: 'day',
          },
        },
      } as any);

      return resp.data;
    } catch (e) {
      console.log(e.response.data);
    }
    return null;
  }
}
