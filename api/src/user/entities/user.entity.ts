import { ObjectType, Field, Int, Float, ID } from '@nestjs/graphql';

@ObjectType() // définir l'entité comme GraphQL
export class User {
    @Field(() => ID)
    id: string;

    @Field(() => String) 
    name: string;

    @Field(() => String)
    email: string;

    @Field(() => String)
    password: string;

    @Field(() => String)
    role: string;

    @Field(() => Float, { nullable: true })
    latitude: number;

    @Field(() => Float, { nullable: true })
    longitude: number;

    
}
