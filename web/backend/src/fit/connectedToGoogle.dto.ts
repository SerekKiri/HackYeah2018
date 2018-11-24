import { ApiModelProperty } from '@nestjs/swagger';

export class ConnectedToGoogleDto {
  @ApiModelProperty({ example: false })
  connected: boolean;
}
