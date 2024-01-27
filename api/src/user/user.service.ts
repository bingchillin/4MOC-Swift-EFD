import { Injectable } from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { User, UserDocument } from './schemas/user.schema';

@Injectable()
export class UserService {
  constructor(@InjectModel(User.name) private userDocumentModel: Model<UserDocument>) {}
  create(createUserDto: CreateUserDto) {
    return new this.userDocumentModel(createUserDto).save();
  }

  async findAll() {
    return await this.userDocumentModel.find().exec();
  }

  async findAllLivreur() {
    return await this.userDocumentModel.find({role: 'livreur'}).exec();
  }

  async findOne(id: string) {
    return await this.userDocumentModel.findById(id).exec();
  }

  // find one livreur by id
  async findOneLivreur(id: string) {
    const livreur = await this.userDocumentModel.findOne({_id: id, role: 'livreur'}).exec();
    
    if (!livreur) {
      return 'Livreur not found';
    }
    
    return livreur;
  }

  async update(id: string, updateUserDto: UpdateUserDto) {
    const existingUser = await this.userDocumentModel
    .findOneAndUpdate({ _id: id }, updateUserDto, { new: true })
    .exec();

    return existingUser;
  }

  async remove(id: string) {
    const result = await this.userDocumentModel.deleteOne({ _id: id }).exec();

    if (result.deletedCount === 0) {
      throw new Error('User not found');
    }

    return `User with id ${id} has been deleted`;
  }
}
