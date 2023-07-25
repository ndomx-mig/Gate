import { Exclude, Transform } from 'class-transformer';
import { IsMongoId, IsNotEmpty, IsOptional, IsString } from 'class-validator';
import { Role } from 'src/common/enum/role.enum';

export class UserDto {
  @IsMongoId()
  userId: string;

  @IsMongoId()
  rootId: string;

  @IsString()
  @IsNotEmpty()
  @Transform(({ value }) => value.toLowerCase(), { toClassOnly: true })
  name: string;

  @IsString()
  @IsNotEmpty()
  @Transform(({ value }) => value.toLowerCase(), { toClassOnly: true })
  last: string;

  @IsString()
  @IsNotEmpty()
  @Transform(({ value }) => value.toLowerCase(), { toClassOnly: true })
  username: string;

  @IsString()
  @IsNotEmpty()
  @Exclude({ toPlainOnly: true })
  password: string;

  access: string[];

  @IsOptional()
  roles?: Role[];
}
