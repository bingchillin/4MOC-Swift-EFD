import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument } from 'mongoose';

export type RoundDocument = HydratedDocument<Round>;

@Schema()
export class Round {
    @Prop()
    title: string;

    @Prop()
    status: string;

    @Prop({ type: String, ref: 'Package' })
    packageId: string;

    @Prop({ type: String, ref: 'User' })
    userId: string;
}

export const RoundSchema = SchemaFactory.createForClass(Round);