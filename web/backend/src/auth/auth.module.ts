import { Module } from '@nestjs/common';
import { AuthController } from './auth.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from './user.entity';
import { Session } from './session.entity';
import { UsersController } from './users.controller';
import { PasswordHashingService } from './passwordHashing.service';

@Module({
  imports: [TypeOrmModule.forFeature([User, Session])],
  providers: [PasswordHashingService],
  controllers: [AuthController, UsersController],
})
export class AuthModule {}
