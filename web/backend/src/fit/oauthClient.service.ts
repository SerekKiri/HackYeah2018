import { Injectable } from '@nestjs/common';
import * as cfg from '../../keys.json';
import { google } from 'googleapis';

@Injectable()
export class OauthClientService {
  createOauthClient(customUrl?: string) {
    const oauth2Client = new google.auth.OAuth2(
      cfg.CLIENT_ID,
      cfg.CLIENT_SECRET,
      customUrl || 'http://localhost/api/fit/google/redirect-from-google',
    );
    return oauth2Client;
  }

  createOauthClientWithTokens(tokenData: string) {
    const oauth2Client = this.createOauthClient();
    if (!tokenData) {
      throw new Error('Token data empty');
    }
    oauth2Client.setCredentials(JSON.parse(tokenData));
    return oauth2Client;
  }
}
