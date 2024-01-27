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
exports.RoundController = void 0;
const common_1 = require("@nestjs/common");
const round_service_1 = require("./round.service");
const create_round_dto_1 = require("./dto/create-round.dto");
const update_round_dto_1 = require("./dto/update-round.dto");
let RoundController = class RoundController {
    constructor(roundService) {
        this.roundService = roundService;
    }
    create(createRoundDto) {
        return this.roundService.create(createRoundDto);
    }
    findAll() {
        return this.roundService.findAll();
    }
    findOne(id) {
        return this.roundService.findOne(id);
    }
    update(id, updateRoundDto) {
        return this.roundService.update(id, updateRoundDto);
    }
    remove(id) {
        return this.roundService.remove(id);
    }
};
exports.RoundController = RoundController;
__decorate([
    (0, common_1.Post)(),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [create_round_dto_1.CreateRoundDto]),
    __metadata("design:returntype", void 0)
], RoundController.prototype, "create", null);
__decorate([
    (0, common_1.Get)(),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", void 0)
], RoundController.prototype, "findAll", null);
__decorate([
    (0, common_1.Get)(':id'),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], RoundController.prototype, "findOne", null);
__decorate([
    (0, common_1.Patch)(':id'),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, update_round_dto_1.UpdateRoundDto]),
    __metadata("design:returntype", void 0)
], RoundController.prototype, "update", null);
__decorate([
    (0, common_1.Delete)(':id'),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], RoundController.prototype, "remove", null);
exports.RoundController = RoundController = __decorate([
    (0, common_1.Controller)('round'),
    __metadata("design:paramtypes", [round_service_1.RoundService])
], RoundController);
//# sourceMappingURL=round.controller.js.map