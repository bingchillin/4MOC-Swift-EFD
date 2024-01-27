import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument } from 'mongoose';

export type RoundDocument = HydratedDocument<Round>;

@Schema()
export class Round {
    @Prop()
    status: string;

    // clé étrangère vers Package
    @Prop({ type: String, ref: 'Package' })
    packages: string[];
}

export const RoundSchema = SchemaFactory.createForClass(Round);