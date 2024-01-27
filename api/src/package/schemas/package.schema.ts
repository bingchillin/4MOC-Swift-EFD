import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument } from 'mongoose';

export type PackageDocument = HydratedDocument<Package>;

@Schema()
export class Package {
    @Prop()
    name: string;

    @Prop()
    status: string;

    @Prop()
    proof: string;
}

export const PackageSchema = SchemaFactory.createForClass(Package);