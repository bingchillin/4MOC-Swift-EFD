import { Resolver, Query, Mutation, Args } from '@nestjs/graphql';
import { User } from './entities/user.entity';
import { UserService } from './user.service';

@Resolver(() => User)
export class UserResolver {
    constructor(private readonly userService: UserService) { }

    @Query(() => [User], { name: 'users' })
    findAll(): Promise<User[]> {
        return this.userService.findAll();
    }

    @Mutation(() => User)
    async createUser(
        @Args('name') name: string,
        @Args('email') email: string,
        @Args('password') password: string,
        @Args('role') role: string,
        @Args('latitude', { nullable: true }) latitude?: number,
        @Args('longitude', { nullable: true }) longitude?: number,
    ): Promise<User> {
        return this.userService.createTest({ name, email, password, role, latitude, longitude });
    }
}
