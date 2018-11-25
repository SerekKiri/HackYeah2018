import { ApiModelProperty } from '@nestjs/swagger';
import { User } from 'src/auth/user.entity';
import { Allowance } from './allowance.entity';

export class GetTrackedAppsDto {
  @ApiModelProperty({ example: 1 })
  id: number;

  @ApiModelProperty()
  user: User;

  @ApiModelProperty({ example: 'androidApp', enum: ['androidApp'] })
  appType: string;

  @ApiModelProperty({ example: 'com.facebook.katana' })
  appIdentifier: string;

  @ApiModelProperty({ example: 5 })
  costPerMinute: number;

  @ApiModelProperty({ example: 'Facebook' })
  friendlyName: string;

  @ApiModelProperty()
  allowance: Allowance;
}
