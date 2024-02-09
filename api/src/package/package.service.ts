import { Injectable } from '@nestjs/common';
import { CreatePackageDto } from './dto/create-package.dto';
import { UpdatePackageDto } from './dto/update-package.dto';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Package, PackageDocument } from './schemas/package.schema';

@Injectable()
export class PackageService {
  constructor(@InjectModel(Package.name) private packageDocumentModel: Model<PackageDocument>) {}
  create(createPackageDto: CreatePackageDto) {
    return new this.packageDocumentModel(createPackageDto).save();
  }

  async findAll() {
    return await this.packageDocumentModel.find().exec();
  }

  // find all by round id
  async findAllByRoundId(roundId: string) {
    return await this.packageDocumentModel.find({ roundId: roundId }).exec();
  }

  async findOne(id: string) {
    return await this.packageDocumentModel.findById(id).exec();
  }

  async update(id: string, updatePackageDto: UpdatePackageDto) {
    const existingPackage = await this.packageDocumentModel
    .findByIdAndUpdate({ _id: id }, updatePackageDto, { new: true })
    .exec();

    return existingPackage;
  }

  async findPackageByUser(idUserClient: string) {
    return await this.packageDocumentModel.find({ idUserClient: idUserClient }).exec();
  }

  async findPackageByDelivery(idUserDelivery: string) {
    return await this.packageDocumentModel.find({ idUserDelivery: idUserDelivery }).exec();
  }

  async findPackageByDeliveryProcess(idUserDelivery: string) {
    return await this.packageDocumentModel.find({ idUserDelivery: idUserDelivery, status: "loading" }).exec();
  }

  async findPackageByProcess() {
    return await this.packageDocumentModel.find({status: "create" }).exec();
  }

  async remove(id: string) {
    const result = await this.packageDocumentModel.deleteOne({ _id: id }).exec();

    if (result.deletedCount === 0) {
      throw new Error('Package not found');
    }

    return `Package with id ${id} has been deleted`;
  }
}
