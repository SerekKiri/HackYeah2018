import {
  Body,
  ClassSerializerInterceptor,
  Controller,
  Post,
  UnauthorizedException,
  UseInterceptors,
  UsePipes,
  ValidationPipe,
  HttpStatus,
  HttpCode,
} from '@nestjs/common';
import { ApiResponse } from '@nestjs/swagger';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { LoginDto } from './login.dto';
import { PasswordHashingService } from './passwordHashing.service';
import { User } from './user.entity';
import { Session } from './session.entity';
import { randomBytes } from 'crypto';
@Controller('/auth')
@UsePipes(ValidationPipe)
@UseInterceptors(ClassSerializerInterceptor)
export class AuthController {
  constructor(
    @InjectRepository(User) private readonly userRepository: Repository<User>,
    @InjectRepository(Session)
    private readonly sessionRepository: Repository<Session>,
    private readonly passwordHashingService: PasswordHashingService,
  ) {}

  @Post('/login')
  @ApiResponse({
    status: HttpStatus.UNAUTHORIZED,
    description: 'Invalid email or password.',
  })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Login ok, session data in response',
    type: Session,
  })
  @HttpCode(HttpStatus.OK)
  async login(@Body() loginData: LoginDto) {
    const user = await this.userRepository.findOne({
      where: { email: loginData.email },
    });
    if (!user) {
      throw new UnauthorizedException('Invalid email or password.');
    }
    if (
      !(await this.passwordHashingService.compare(
        loginData.password,
        user.password,
      ))
    ) {
      throw new UnauthorizedException('Invalid email or password.');
    }
    const session = new Session();

    session.user = user;
    session.active = true;
    session.token = await new Promise<string>((res, rej) => {
      randomBytes(32, (err, buf) => {
        if (err) {
          return rej(err);
        }
        res(buf.toString('base64'));
      });
    });
    await this.sessionRepository.save(session);
    return session;
  }
}
