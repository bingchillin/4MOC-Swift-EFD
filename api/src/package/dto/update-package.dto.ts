import { InputType, Field } from '@nestjs/graphql';

@InputType()  
export class UpdatePackageDto {
    @Field({ nullable: true }) 
    status?: string;

    @Field({ nullable: true })
    idUserClient?: string;

    @Field({ nullable: true })
    idUserDelivery?: string;

 
}