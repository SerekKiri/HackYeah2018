import { ApiModelProperty } from '@nestjs/swagger';

export class FormattedCaloriesDto {
  @ApiModelProperty({ example: 87 })
  activityCode: number;

  @ApiModelProperty({ example: 'Tennis' })
  activityName: string;

  @ApiModelProperty({ example: 137.5 })
  calories: number;

  @ApiModelProperty({ example: 1542538768065 })
  startTimeMilis: number;

  @ApiModelProperty({ example: 1542538768065 })
  endTimeMilis: number;

  @ApiModelProperty()
  originDataSourceId: string;

  @ApiModelProperty({ example: 'for deugging only' })
  _niceTime: string;

  @ApiModelProperty({ example: '15425387680651542538768065' })
  conversionHash: string;

  @ApiModelProperty({ example: 33 })
  points: number;

  @ApiModelProperty({ example: false })
  alreadyConverted: boolean;
}
