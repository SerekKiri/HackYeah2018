import { PrimaryGeneratedColumn, Entity, ManyToOne, Column, OneToOne, JoinColumn } from 'typeorm';
import { Exclude } from 'class-transformer';
import { ApiModelProperty } from '@nestjs/swagger';
import { User } from 'src/auth/user.entity';
import { TrackedApp } from './trackedApp.entity';

@Entity()
export class Allowance {
  @PrimaryGeneratedColumn()
  @Exclude({ toClassOnly: true })
  @ApiModelProperty({ example: 1 })
  id: number;

  @OneToOne(type => TrackedApp, { eager: true })
  @ApiModelProperty()
  @JoinColumn()
  app: TrackedApp;

  @Column({ type: 'float' })
  minutesLeft: number;

  @Column({ type: 'datetime' })
  lastSubtracted: Date;
}
