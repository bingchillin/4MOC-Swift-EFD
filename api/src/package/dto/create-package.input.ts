import { InputType, Field, Float } from '@nestjs/graphql';

@InputType()
export class CreatePackageInput {
  @Field()
  name: string;

  @Field()
  status: string;

  @Field()
  proof: string;

  @Field(() => Float)
  latitude: number;

  @Field(() => Float)
  longitude: number;

  @Field()
  idUserClient: string;

  @Field()
  idUserDelivery: string;

  @Field()
  isAffected: boolean;
}
