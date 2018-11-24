import {
  PrimaryGeneratedColumn,
  Entity,
  Column,
  CreateDateColumn,
  UpdateDateColumn,
  ManyToOne,
} from 'typeorm';
import { Exclude } from 'class-transformer';
import { IsEmail, IsNotEmpty } from 'class-validator';
import { User } from './user.entity';
import { ApiModelProperty } from '@nestjs/swagger';

@Entity()
export class Session {
  @PrimaryGeneratedColumn()
  @Exclude({ toClassOnly: true })
  @ApiModelProperty({ example: 1 })
  id: number;

  @Column()
  @IsNotEmpty()
  @ApiModelProperty({ example: 'Afu/rW7ZN4eu18h+F1T1e7WMTcrfLhrOIIeGTwz799s=' })
  token: string;

  @ManyToOne(type => User)
  @ApiModelProperty()
  user: User;

  @Column()
  @ApiModelProperty({ example: true })
  active: boolean;

  @CreateDateColumn()
  @ApiModelProperty({ format: 'date-time', type: 'string' })
  createdAt: Date;

  @UpdateDateColumn()
  @ApiModelProperty({ format: 'date-time', type: 'string' })
  updatedAt: Date;
}
