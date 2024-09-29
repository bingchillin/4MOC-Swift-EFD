import { Module } from '@nestjs/common';
import { PackageService } from './package.service';
import { PackageResolver } from './package.resolver';
import { MongooseModule } from '@nestjs/mongoose';
import { Package, PackageSchema } from './schemas/package.schema';

@Module({
  imports: [
    MongooseModule.forFeature([{
      name: Package.name,
      schema: PackageSchema
    }]),
  ],
  providers: [PackageService, PackageResolver],
})
export class PackageModule {}
