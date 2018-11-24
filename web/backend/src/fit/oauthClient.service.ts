import { Injectable } from '@nestjs/common';
import * as cfg from '../../keys.json';
import { google } from 'googleapis';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from '../auth/user.entity';
import { Repository } from 'typeorm';

@Injectable()
export class OauthClientService {
  constructor(
    @InjectRepository(User) private readonly userRepository: Repository<User>,
  ) {}
  createOauthClient(customUrl?: string) {
    const oauth2Client = new google.auth.OAuth2(
      cfg.CLIENT_ID,
      cfg.CLIENT_SECRET,
      customUrl || 'http://localhost/api/fit/google/redirect-from-google',
    );
    return oauth2Client;
  }

  createOauthClientWithUser(user: User) {
    const oauth2Client = this.createOauthClient();

    if (!user.googleTokens) {
      throw new Error('Token data empty');
    }
    oauth2Client.setCredentials(JSON.parse(user.googleTokens));
    oauth2Client.on('tokens', async tokens => {
      if (tokens.refresh_token) {
        console.log('RECEIVED NEW GOOGLE TOKENS');
        user.googleTokens = JSON.stringify(tokens);
        await this.userRepository.save(user);
      }
    });
    return oauth2Client;
  }
}
