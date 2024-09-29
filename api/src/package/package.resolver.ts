import { Resolver, Query, Mutation, Args, ID } from '@nestjs/graphql';
import { PackageService } from './package.service';
import { Package } from './schemas/package.schema';
import { CreatePackageInput } from './dto/create-package.input';
import { UpdatePackageDto } from './dto/update-package.dto';

@Resolver(() => Package)
export class PackageResolver {
  constructor(private readonly packageService: PackageService) {}

    @Query(() => [Package], { name: 'packages' })
    async findAll() {
        return this.packageService.findAll();
    }

    @Query(() => Package, { name: 'package' })
    async findOne(@Args('id', { type: () => ID }) id: string) {
        return this.packageService.findOne(id);
    }

    @Mutation(() => Package) 
    async createPackage(
        @Args('createPackageInput') createPackageInput: CreatePackageInput
    ) {
        return this.packageService.create(createPackageInput);
    }
 
    @Mutation(() => Package)
    async updatePackage(
        @Args('id') id: string,
        @Args('updatePackageInput') updatePackageInput: UpdatePackageDto 
    ): Promise<Package> {
        return this.packageService.update(id, updatePackageInput);
    }

    @Query(() => [Package])
    async findPackageByDeliveryProcess(@Args('id') id: string): Promise<Package[]> {
        return this.packageService.findPackageByDeliveryProcess(id); // Appelle le service
    }

    @Query(() => [Package]) 
    async findPackageByProcess(): Promise<Package[]> {
        return this.packageService.findPackageByProcess();
    }

    @Query(() => [Package])
    async findPackageByUserIdSuccess(
        @Args('idUserClient') idUserClient: string,
    ): Promise<Package[]> {
        return this.packageService.findPackageByUserIdSuccess(idUserClient);
    }

    @Mutation(() => String)
    async removePackage(@Args('id', { type: () => ID }) id: string) {
        return this.packageService.remove(id);
    }

  

}
