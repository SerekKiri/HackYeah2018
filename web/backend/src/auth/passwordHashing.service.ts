import { Injectable } from '@nestjs/common';
import { genSalt, compare, hash } from 'bcryptjs';

@Injectable()
export class PasswordHashingService {
  async hash(password: string) {
    return await hash(password, 10);
  }

  compare(password: string, hashed: string) {
    return compare(password, hashed);
  }
}
