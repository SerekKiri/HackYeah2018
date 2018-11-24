import {
  PrimaryGeneratedColumn,
  Entity,
  Column,
  CreateDateColumn,
  UpdateDateColumn,
  Unique,
} from 'typeorm';
import { Exclude } from 'class-transformer';
import { IsEmail, IsNotEmpty } from 'class-validator';
import { ApiModelProperty } from '@nestjs/swagger';

@Entity()
export class User {
  @PrimaryGeneratedColumn()
  @Exclude({ toClassOnly: true })
  @ApiModelProperty({ example: 1 })
  id: number;

  @Column()
  @IsNotEmpty()
  @ApiModelProperty({ example: 'Filip' })
  displayName: string;

  @Column({ unique: true })
  @IsEmail()
  @ApiModelProperty({ example: 'ddd@smrootmail.dd' })
  email: string;

  @Exclude()
  @Column()
  password: string;

  @CreateDateColumn()
  @Exclude({ toClassOnly: true })
  @ApiModelProperty({ format: 'date-time', type: 'string' })
  createdAt: Date;

  @UpdateDateColumn()
  @Exclude({ toClassOnly: true })
  @ApiModelProperty({ format: 'date-time', type: 'string' })
  updatedAt: Date;

  @Exclude()
  @Column({ type: 'text', default: '' })
  googleTokens: string;
}
