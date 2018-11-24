import { ApiModelProperty } from "@nestjs/swagger";
import { IsNotEmpty, IsIn } from "class-validator";

export class AllowanceEventDto {
    @ApiModelProperty({ example: 'androidApp', enum: ['androidApp'] })
    @IsIn(['androidApp'])
    appType: string;
  
    @ApiModelProperty({ example: 'com.facebook.katana' })
    @IsNotEmpty()
    appIdentifier: string;
}