import { Module } from '@nestjs/common';
import { RoundService } from './round.service';
import { RoundController } from './round.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { Round, RoundSchema } from './schemas/round.schema';

@Module({
  imports: [
    MongooseModule.forFeature([{
      name: Round.name,
      schema: RoundSchema
    }]),
  ],
  controllers: [RoundController],
  providers: [RoundService],
})
export class RoundModule {}
