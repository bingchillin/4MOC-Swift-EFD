"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.PackageService = void 0;
const common_1 = require("@nestjs/common");
const mongoose_1 = require("@nestjs/mongoose");
const mongoose_2 = require("mongoose");
const package_schema_1 = require("./schemas/package.schema");
let PackageService = class PackageService {
    constructor(packageDocumentModel) {
        this.packageDocumentModel = packageDocumentModel;
    }
    create(createPackageDto) {
        return new this.packageDocumentModel(createPackageDto).save();
    }
    async findAll() {
        return await this.packageDocumentModel.find().exec();
    }
    async findAllByRoundId(roundId) {
        return await this.packageDocumentModel.find({ roundId: roundId }).exec();
    }
    async findOne(id) {
        return await this.packageDocumentModel.findById(id).exec();
    }
    async update(id, updatePackageDto) {
        const existingPackage = await this.packageDocumentModel
            .findByIdAndUpdate({ _id: id }, updatePackageDto, { new: true })
            .exec();
        return existingPackage;
    }
    async findPackageByUser(idUserClient) {
        return await this.packageDocumentModel.find({ idUserClient: idUserClient }).exec();
    }
    async findPackageByDelivery(idUserDelivery) {
        return await this.packageDocumentModel.find({ idUserDelivery: idUserDelivery }).exec();
    }
    async findPackageByDeliveryProcess(idUserDelivery) {
        return await this.packageDocumentModel.find({ idUserDelivery: idUserDelivery, status: "loading" }).exec();
    }
    async findPackageByProcess() {
        return await this.packageDocumentModel.find({ status: "create" }).exec();
    }
    async remove(id) {
        const result = await this.packageDocumentModel.deleteOne({ _id: id }).exec();
        if (result.deletedCount === 0) {
            throw new Error('Package not found');
        }
        return `Package with id ${id} has been deleted`;
    }
};
exports.PackageService = PackageService;
exports.PackageService = PackageService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, mongoose_1.InjectModel)(package_schema_1.Package.name)),
    __metadata("design:paramtypes", [mongoose_2.Model])
], PackageService);
//# sourceMappingURL=package.service.js.map