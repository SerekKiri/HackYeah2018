import {
  Entity,
  PrimaryGeneratedColumn,
  ManyToOne,
  Column,
  CreateDateColumn,
} from 'typeorm';
import { Exclude } from 'class-transformer';
import { ApiModelProperty } from '@nestjs/swagger';
import { User } from 'src/auth/user.entity';

@Entity()
export class ConvertedActivity {
  @PrimaryGeneratedColumn()
  @Exclude({ toClassOnly: true })
  @ApiModelProperty({ example: 1 })
  id: number;

  @ManyToOne(type => User, { eager: true })
  @ApiModelProperty()
  user: User;

  @Column()
  @ApiModelProperty()
  conversionHash: string;

  @CreateDateColumn()
  @Exclude({ toClassOnly: true })
  @ApiModelProperty({ format: 'date-time', type: 'string' })
  createdAt: Date;

  @Column()
  @ApiModelProperty({ example: 33 })
  points: number;
}
