import { Injectable, ConflictException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { User as UserSchema, UserDocument } from './schemas/user.schema'; // Type Mongoose
import { CreateUserInput } from './dto/create-user.input';
import { UpdateUserInput } from './dto/update-user.input';
import * as bcrypt from 'bcrypt';

@Injectable()
export class UserService {
  constructor(@InjectModel(UserSchema.name) private userDocumentModel: Model<UserDocument>) { }

  async create(createUserInput: CreateUserInput): Promise<UserSchema> {
    const existingUser = await this.userDocumentModel.findOne({ email: createUserInput.email }).exec();

    if (existingUser) {
      throw new ConflictException('User already exists');
    }

    const hashedPassword = await bcrypt.hash(createUserInput.password, 10);
    const newUser = new this.userDocumentModel({
      ...createUserInput,
      password: hashedPassword
    });

    return newUser.save();
  }

  async findAll(): Promise<UserSchema[]> {
    return this.userDocumentModel.find().exec();
  }

  async findOne(id: string): Promise<UserSchema | null> {
    return this.userDocumentModel.findById(id).exec();
  }

  async findAllLivreur(): Promise<UserSchema[]> {
    return this.userDocumentModel.find({ role: 'livreur' }).exec();
  }

  async findOneLivreur(id: string): Promise<UserSchema | null> {
    return this.userDocumentModel.findOne({ _id: id, role: 'livreur' }).exec();
  }

  async update(id: string, updateUserInput: UpdateUserInput): Promise<UserSchema | null> {
    if (updateUserInput.password) {
      const hashedPassword = await bcrypt.hash(updateUserInput.password, 10);
      updateUserInput.password = hashedPassword;
    }
    return this.userDocumentModel.findByIdAndUpdate(id, updateUserInput, { new: true }).exec();
  }

  async remove(id: string): Promise<string> {
    const result = await this.userDocumentModel.deleteOne({ _id: id }).exec();

    if (result.deletedCount === 0) {
      throw new Error('User not found');
    }

    return `User with id ${id} has been deleted`;
  }

  
  async login(email: string, password: string): Promise<UserDocument | string> {
    // Recherche l'utilisateur par email
    const user = await this.userDocumentModel.findOne({ email });
  
    if (!user) {
      throw new Error('User not found');
    }
  
    // Vérifie que le mot de passe est correct (tu peux utiliser bcrypt pour comparer les hashs)
    const isPasswordValid = await bcrypt.compare(password, user.password);
  
    if (!isPasswordValid) {
      throw new Error('Invalid password');
    }
  
    // Si tout est valide, retourne l'utilisateur
    return user;
  }

  async validateUser(email: string, password: string): Promise<UserDocument | null> {
    const user = await this.userDocumentModel.findOne({ email }).exec();

    if (!user) {
      return null; // L'utilisateur n'existe pas
    }

    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
      return null; // Le mot de passe est incorrect
    }

    return user; // Retourner l'utilisateur si tout est correct
  }

}
