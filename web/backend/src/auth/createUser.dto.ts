import { IsEmail, MinLength } from "class-validator";
import { ApiModelProperty } from "@nestjs/swagger";

export class CreateUserDto {
  @IsEmail()
  @ApiModelProperty({ example: 'ddd@smrootmail.dd' })
  readonly email: string;

  @MinLength(6)
  @ApiModelProperty({ minLength: 6, example: 'filiper123' })
  readonly password: string;

  @MinLength(3)
  @ApiModelProperty({ minLength: 3, example: 'Filip' })
  readonly displayName: string;
}