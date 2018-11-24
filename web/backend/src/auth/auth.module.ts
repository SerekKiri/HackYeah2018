import { Module } from '@nestjs/common';
import { AuthController } from './auth.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from './user.entity';
import { Session } from './session.entity';
import { UsersController } from './users.controller';
import { PasswordHashingService } from './passwordHashing.service';
import { AuthService } from './auth.service';
import { HttpStrategy } from './http.strategy';
import { PassportModule } from '@nestjs/passport';

@Module({
  imports: [
    TypeOrmModule.forFeature([User, Session]),
    PassportModule.register({ defaultStrategy: 'bearer' }),
  ],
  providers: [PasswordHashingService, AuthService, HttpStrategy],
  controllers: [AuthController, UsersController],
  exports: [AuthService, HttpStrategy],
})
export class AuthModule {}
