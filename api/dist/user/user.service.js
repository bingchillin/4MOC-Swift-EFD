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
exports.UserService = void 0;
const common_1 = require("@nestjs/common");
const mongoose_1 = require("@nestjs/mongoose");
const mongoose_2 = require("mongoose");
const user_schema_1 = require("./schemas/user.schema");
const bcrypt = require("bcrypt");
let UserService = class UserService {
    constructor(userDocumentModel) {
        this.userDocumentModel = userDocumentModel;
    }
    async create(createUserInput) {
        const existingUser = await this.userDocumentModel.findOne({ email: createUserInput.email }).exec();
        if (existingUser) {
            throw new common_1.ConflictException('User already exists');
        }
        const hashedPassword = await bcrypt.hash(createUserInput.password, 10);
        const newUser = new this.userDocumentModel({
            ...createUserInput,
            password: hashedPassword
        });
        return newUser.save();
    }
    async findAll() {
        return this.userDocumentModel.find().exec();
    }
    async findOne(id) {
        return this.userDocumentModel.findById(id).exec();
    }
    async findAllLivreur() {
        return this.userDocumentModel.find({ role: 'livreur' }).exec();
    }
    async findOneLivreur(id) {
        return this.userDocumentModel.findOne({ _id: id, role: 'livreur' }).exec();
    }
    async update(id, updateUserInput) {
        if (updateUserInput.password) {
            const hashedPassword = await bcrypt.hash(updateUserInput.password, 10);
            updateUserInput.password = hashedPassword;
        }
        return this.userDocumentModel.findByIdAndUpdate(id, updateUserInput, { new: true }).exec();
    }
    async remove(id) {
        const result = await this.userDocumentModel.deleteOne({ _id: id }).exec();
        if (result.deletedCount === 0) {
            throw new Error('User not found');
        }
        return `User with id ${id} has been deleted`;
    }
    async login(email, password) {
        const user = await this.userDocumentModel.findOne({ email }).exec();
        if (!user) {
            return 'User not found';
        }
        const isPasswordCorrect = await bcrypt.compare(password, user.password);
        if (!isPasswordCorrect) {
            return 'Password is incorrect';
        }
        return user;
    }
};
exports.UserService = UserService;
exports.UserService = UserService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, mongoose_1.InjectModel)(user_schema_1.User.name)),
    __metadata("design:paramtypes", [mongoose_2.Model])
], UserService);
//# sourceMappingURL=user.service.js.map