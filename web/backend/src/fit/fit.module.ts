import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PassportModule } from '@nestjs/passport';
import { User } from 'src/auth/user.entity';
import { Session } from 'src/auth/session.entity';
import { AuthService } from 'src/auth/auth.service';
import { HttpStrategy } from 'src/auth/http.strategy';
import GoogleApiController from './googleApi.controller';
import { OauthClientService } from './oauthClient.service';
import { TrackedApp } from './trackedApp.entity';
import { TrackedAppsController } from './trackedApps.controller';
import { Allowance } from './allowance.entity';
import { AllowanceController } from './allowance.controller';
import { GoogleFitService } from './googleFit.service';

@Module({
  imports: [
    TypeOrmModule.forFeature([User, Session, TrackedApp, Allowance]),
    PassportModule.register({ defaultStrategy: 'bearer' }),
  ],
  providers: [OauthClientService, GoogleFitService],
  controllers: [
    GoogleApiController,
    TrackedAppsController,
    AllowanceController,
  ],
})
export class FitModule {}
