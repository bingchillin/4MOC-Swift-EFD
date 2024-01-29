import { Injectable } from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { User, UserDocument } from './schemas/user.schema';
import * as bcrypt from 'bcrypt';

@Injectable()
export class UserService {
  constructor(@InjectModel(User.name) private userDocumentModel: Model<UserDocument>) { }
  async create(createUserDto: CreateUserDto) {
    const existingUser = await this.userDocumentModel.findOne({ email: createUserDto.email }).exec();

    if(existingUser) {
      return 'User already exists';
    }

    const hashedPassword = await bcrypt.hash(createUserDto.password, 10);
    const newUser = new this.userDocumentModel({
      ...createUserDto,
      password: hashedPassword
    });

    return newUser.save();
  }

  async findAll() {
    return await this.userDocumentModel.find().exec();
  }

  async findAllLivreur() {
    return await this.userDocumentModel.find({ role: 'livreur' }).exec();
  }

  async findOne(id: string) {
    return await this.userDocumentModel.findById(id).exec();
  }

  // find one livreur by id
  async findOneLivreur(id: string) {
    const livreur = await this.userDocumentModel.findOne({ _id: id, role: 'livreur' }).exec();

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

  async login(email: string, password: string) {
    const user = await this.userDocumentModel.findOne({ email }).exec();

    if (!user) {
      return 'User not found';
    }

    const isPasswordCorrect = await bcrypt.compare(password, user.password);

    if (!isPasswordCorrect) {
      return 'Password is incorrect';
    }

    return 'Login success';
  }
}