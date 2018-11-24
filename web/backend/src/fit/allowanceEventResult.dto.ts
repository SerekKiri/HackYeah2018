import { ApiModelProperty } from '@nestjs/swagger';

export class AllowanceEventResultDto {
  @ApiModelProperty({
    description: 'Should you allow the app to run or immediately block it',
    example: true,
  })
  allow: boolean;

  @ApiModelProperty({
    description: 'Should you send more usage reports of this app',
    example: true,
  })
  track: boolean;

  @ApiModelProperty({
    description: 'Minutes left for this app to run',
    example: 3.5,
  })
  minutesLeft: number;
}
