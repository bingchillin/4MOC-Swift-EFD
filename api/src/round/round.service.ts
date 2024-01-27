import { Injectable } from '@nestjs/common';
import { CreateRoundDto } from './dto/create-round.dto';
import { UpdateRoundDto } from './dto/update-round.dto';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Round, RoundDocument } from './schemas/round.schema';

@Injectable()
export class RoundService {
  constructor(@InjectModel(Round.name) private roundDocumentModel: Model<RoundDocument>) {}
  create(createRoundDto: CreateRoundDto) {
    return new this.roundDocumentModel(createRoundDto).save();
  }

  async findAll() {
    return await this.roundDocumentModel.find().exec();
  }

  async findOne(id: string) {
    return await this.roundDocumentModel.findById(id).exec();
  }

  async update(id: string, updateRoundDto: UpdateRoundDto) {
    const existingRound = await this.roundDocumentModel
    .findOneAndUpdate({ _id: id }, updateRoundDto, { new: true })
    .exec();

    return existingRound;
  }

  async remove(id: string) {
    const result = await this.roundDocumentModel.deleteOne({ _id: id }).exec();

    if (result.deletedCount === 0) {
      throw new Error('Round not found');
    }

    return `Round with id ${id} has been deleted`;
  }
}
