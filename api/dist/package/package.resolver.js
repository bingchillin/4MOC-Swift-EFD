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
exports.PackageResolver = void 0;
const graphql_1 = require("@nestjs/graphql");
const package_service_1 = require("./package.service");
const package_schema_1 = require("./schemas/package.schema");
const create_package_input_1 = require("./dto/create-package.input");
const update_package_dto_1 = require("./dto/update-package.dto");
let PackageResolver = class PackageResolver {
    constructor(packageService) {
        this.packageService = packageService;
    }
    async findAll() {
        return this.packageService.findAll();
    }
    async findOne(id) {
        return this.packageService.findOne(id);
    }
    async createPackage(createPackageInput) {
        return this.packageService.create(createPackageInput);
    }
    async updatePackage(id, updatePackageInput) {
        return this.packageService.update(id, updatePackageInput);
    }
    async findPackageByDeliveryProcess(id) {
        return this.packageService.findPackageByDeliveryProcess(id);
    }
    async findPackageByProcess() {
        return this.packageService.findPackageByProcess();
    }
    async findPackageByUserIdSuccess(idUserClient) {
        return this.packageService.findPackageByUserIdSuccess(idUserClient);
    }
    async removePackage(id) {
        return this.packageService.remove(id);
    }
    async update(id, updatePackageDto) {
        return this.packageService.update(id, updatePackageDto);
    }
};
exports.PackageResolver = PackageResolver;
__decorate([
    (0, graphql_1.Query)(() => [package_schema_1.Package], { name: 'packages' }),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], PackageResolver.prototype, "findAll", null);
__decorate([
    (0, graphql_1.Query)(() => package_schema_1.Package, { name: 'package' }),
    __param(0, (0, graphql_1.Args)('id', { type: () => graphql_1.ID })),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], PackageResolver.prototype, "findOne", null);
__decorate([
    (0, graphql_1.Mutation)(() => package_schema_1.Package),
    __param(0, (0, graphql_1.Args)('createPackageInput')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [create_package_input_1.CreatePackageInput]),
    __metadata("design:returntype", Promise)
], PackageResolver.prototype, "createPackage", null);
__decorate([
    (0, graphql_1.Mutation)(() => package_schema_1.Package),
    __param(0, (0, graphql_1.Args)('id')),
    __param(1, (0, graphql_1.Args)('updatePackageInput')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, update_package_dto_1.UpdatePackageDto]),
    __metadata("design:returntype", Promise)
], PackageResolver.prototype, "updatePackage", null);
__decorate([
    (0, graphql_1.Query)(() => [package_schema_1.Package]),
    __param(0, (0, graphql_1.Args)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], PackageResolver.prototype, "findPackageByDeliveryProcess", null);
__decorate([
    (0, graphql_1.Query)(() => [package_schema_1.Package]),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], PackageResolver.prototype, "findPackageByProcess", null);
__decorate([
    (0, graphql_1.Query)(() => [package_schema_1.Package]),
    __param(0, (0, graphql_1.Args)('idUserClient')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], PackageResolver.prototype, "findPackageByUserIdSuccess", null);
__decorate([
    (0, graphql_1.Mutation)(() => String),
    __param(0, (0, graphql_1.Args)('id', { type: () => graphql_1.ID })),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], PackageResolver.prototype, "removePackage", null);
__decorate([
    (0, graphql_1.Mutation)(() => package_schema_1.Package),
    __param(0, (0, graphql_1.Args)("id")),
    __param(1, (0, graphql_1.Args)("updatePackageDto")),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, update_package_dto_1.UpdatePackageDto]),
    __metadata("design:returntype", Promise)
], PackageResolver.prototype, "update", null);
exports.PackageResolver = PackageResolver = __decorate([
    (0, graphql_1.Resolver)(() => package_schema_1.Package),
    __metadata("design:paramtypes", [package_service_1.PackageService])
], PackageResolver);
//# sourceMappingURL=package.resolver.js.map