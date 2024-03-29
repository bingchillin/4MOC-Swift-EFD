import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { PackageService } from './package.service';
import { CreatePackageDto } from './dto/create-package.dto';
import { UpdatePackageDto } from './dto/update-package.dto';

@Controller('package')
export class PackageController {
  constructor(private readonly packageService: PackageService) {}

  @Post()
  create(@Body() createPackageDto: CreatePackageDto) {
    return this.packageService.create(createPackageDto);
  }

  @Get()
  findAll() {
    return this.packageService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.packageService.findOne(id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updatePackageDto: UpdatePackageDto) {
    return this.packageService.update(id, updatePackageDto);
  }

  @Get('user/:id')
  findPackageByUseId(@Param('id') id: string) {
    return this.packageService.findPackageByUserId(id);
  }

  @Get('user/:id/success')
  findPackageByUserIdSuccess(@Param('id') id: string) {
    return this.packageService.findPackageByUserIdSuccess(id);
  }

  @Get('delivery/:id')
  findPackageByDeliveryId(@Param('id') id: string) {
    return this.packageService.findPackageByDeliveryId(id);
  }

  @Get('delivery/:id/process')
  findPackageByDeliveryProcess(@Param('id') id: string) {
    return this.packageService.findPackageByDeliveryProcess(id);
  }

  @Get('process/create')
  findPackageByProcess() {
    return this.packageService.findPackageByProcess();
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.packageService.remove(id);
  }
}
