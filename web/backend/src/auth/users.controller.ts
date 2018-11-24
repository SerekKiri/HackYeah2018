import {
  Get,
  Controller,
  Post,
  UsePipes,
  ValidationPipe,
  Body,
  UseFilters,
  UseInterceptors,
  ClassSerializerInterceptor,
  HttpStatus,
  Param,
  ParseIntPipe,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from './user.entity';
import { Repository } from 'typeorm';
import { EntityNotFoundExceptionFilter } from 'src/core/EntityNotFoundExeptionFilter';
import { CreateUserDto } from './createUser.dto';
import { plainToClass } from 'class-transformer';
import { PasswordHashingService } from './passwordHashing.service';
import { ApiResponse } from '@nestjs/swagger';

@Controller('/auth/users')
@UsePipes(ValidationPipe)
@UseInterceptors(ClassSerializerInterceptor)
export class UsersController {
  constructor(
    @InjectRepository(User) private readonly userRepository: Repository<User>,
    private readonly passwordHashingService: PasswordHashingService,
  ) {}

  @Post('/')
  async postUser(@Body() userData: CreateUserDto) {
    const user = plainToClass(User, userData);
    user.password = await this.passwordHashingService.hash(userData.password);
    await this.userRepository.save(user);
    return user;
  }

  @Get('/')
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Lists all users.',
    type: User,
    isArray: true,
  })
  async getUsers() {
    return await this.userRepository.find({});
  }

  @Get('/:id')
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Returns the requested user.',
    type: User,
  })
  @ApiResponse({
    status: HttpStatus.NOT_FOUND,
    description: 'User not found.'
  })
  @ApiResponse({
    status: HttpStatus.BAD_REQUEST,
    description: 'Invalid request parameter format.'
  })
  @UseFilters(new EntityNotFoundExceptionFilter("User not found."))
  async getUser(@Param('id', ParseIntPipe) id: number) {
    return await this.userRepository.findOneOrFail(id);
  }
}
