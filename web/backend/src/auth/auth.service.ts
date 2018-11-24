import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Session } from './session.entity';
import { User } from './user.entity';
import { Repository } from 'typeorm';

@Injectable()
export class AuthService {
  constructor(
    @InjectRepository(User) private readonly userRepository: Repository<User>,
    @InjectRepository(Session)
    private readonly sessionRepository: Repository<Session>,
  ) {}

  async validateSession(token: string): Promise<Session> {
    // Validate if token passed along with HTTP request
    // is associated with any registered account in the database
    let session = await this.sessionRepository.findOne({
      where: {
        token: token,
      },
    });

    return session;
  }
}
