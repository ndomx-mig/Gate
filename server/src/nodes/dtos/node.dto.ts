import { Expose, Type } from 'class-transformer';
import {
  IsDefined,
  IsMongoId,
  IsNotEmpty,
  IsString,
  Matches,
  ValidateNested,
} from 'class-validator';
import { NodeInfoDto } from './node-info.dto';

export class NodeDto {
  @IsMongoId()
  @IsDefined()
  @Expose({ name: 'node_id' })
  nodeId: string;

  @IsMongoId()
  @IsDefined()
  @Expose({ name: 'root_id' })
  rootId: string;

  @IsMongoId()
  @IsDefined()
  parent: string;

  @IsString()
  @IsNotEmpty()
  @Matches(/^[a-zA-Z0-9-_]+$/)
  name: string;

  @IsString()
  @IsNotEmpty()
  @Expose({ name: 'display_name' })
  displayName: string;

  @Type(() => NodeInfoDto)
  @ValidateNested()
  @IsDefined() 
  @Expose({ name: 'node_info' })
  nodeInfo: NodeInfoDto;
}
