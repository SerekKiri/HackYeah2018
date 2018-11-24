import { ApiModelProperty } from "@nestjs/swagger";

export class RedeemDto {
    @ApiModelProperty({example: 3})
    minutes: number;
}