import { ApiModelProperty } from '@nestjs/swagger';

export class GoogleRedirectDto {
  @ApiModelProperty({ example: 'http://google.com' })
  redirectUrl: string;
}
