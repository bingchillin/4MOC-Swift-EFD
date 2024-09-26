import { ObjectType, Field, Int, Float } from '@nestjs/graphql';

@ObjectType() // Décorateur pour définir l'entité comme un type GraphQL
export class User {
    @Field(() => String)
    id: string; // Ajout du champ id pour GraphQL

    @Field(() => String) // Décorateur pour exposer un champ dans GraphQL
    name: string;

    @Field(() => String)
    email: string;

    @Field(() => String)
    password: string;

    @Field(() => String)
    role: string;

    @Field(() => Float, { nullable: true }) // Utilisation de Float pour les coordonnées
    latitude: number;

    @Field(() => Float, { nullable: true })
    longitude: number;

    
}
