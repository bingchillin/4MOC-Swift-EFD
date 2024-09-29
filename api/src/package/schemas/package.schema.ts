import { ObjectType, Field, Float, ID } from '@nestjs/graphql';
import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

export type PackageDocument = Package & Document;

@Schema()
@ObjectType() // Decorateur => c'est un type GraphQL
export class Package {
  @Field(() => ID) //  `id` pour GraphQL
  id: string; // comme à `_id` dans MongoDB

  @Field()
  @Prop()
  name: string;

  @Field()
  @Prop()
  status: string;

  @Field()
  @Prop()
  proof: string;

  @Field(() => Float)
  @Prop()
  latitude: number;

  @Field(() => Float)
  @Prop()
  longitude: number;

  @Field()
  @Prop()
  idUserClient: string;

  @Field()
  @Prop()
  idUserDelivery: string;

  @Field()
  @Prop()
  isAffected: boolean;
}

export const PackageSchema = SchemaFactory.createForClass(Package);
