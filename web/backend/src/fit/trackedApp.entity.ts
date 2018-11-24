import { PrimaryGeneratedColumn, Entity, ManyToOne, Column } from 'typeorm';
import { Exclude } from 'class-transformer';
import { ApiModelProperty } from '@nestjs/swagger';
import { User } from 'src/auth/user.entity';

@Entity()
export class TrackedApp {
  @PrimaryGeneratedColumn()
  @Exclude({ toClassOnly: true })
  @ApiModelProperty({ example: 1 })
  id: number;

  @ManyToOne(type => User, { eager: true })
  @ApiModelProperty()
  user: User;

  @ApiModelProperty({ example: 'androidApp', enum: ['androidApp'] })
  @Column({ type: 'enum', enum: ['androidApp'] })
  appType: string;

  @Column()
  @ApiModelProperty({ example: 'com.facebook.katana' })
  appIdentifier: string;

  @Column({ type: 'int' })
  @ApiModelProperty({ example: 5 })
  costPerMinute: number;

  @Column()
  @ApiModelProperty({ example: 'Facebook' })
  friendlyName: string;
}
