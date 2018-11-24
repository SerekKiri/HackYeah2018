import { ApiModelProperty } from '@nestjs/swagger';
import {
  IsPositive,
  IsNumber,
  IsNotEmpty,
  IsEnum,
  IsIn,
} from 'class-validator';
import { Exclude } from 'class-transformer';

export class CreateTrackedAppDto {
  @ApiModelProperty({ example: 'androidApp', enum: ['androidApp'] })
  @IsIn(['androidApp'])
  appType: string;

  @ApiModelProperty({ example: 'com.facebook.katana' })
  @IsNotEmpty()
  appIdentifier: string;

  @ApiModelProperty({ example: 5 })
  @IsPositive()
  @IsNumber()
  costPerMinute: number;

  @ApiModelProperty({ example: 'Facebook' })
  @IsNotEmpty()
  friendlyName: string;
}
