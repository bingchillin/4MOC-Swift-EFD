import { Resolver, Query, Mutation, Args } from '@nestjs/graphql';
import { User as UserModel } from './user.model'; 
import { UserService } from './user.service';
import { CreateUserInput } from './dto/create-user.input';
import { UpdateUserInput } from './dto/update-user.input';

@Resolver(() => UserModel)
export class UserResolver {
  constructor(private readonly userService: UserService) { }

  @Query(() => [UserModel], { name: 'users' })
  async findAll(): Promise<UserModel[]> {
    return this.userService.findAll();
  }

  @Query(() => UserModel, { name: 'user' })
  async findOne(@Args('id') id: string): Promise<UserModel | null> {
    return this.userService.findOne(id);
  }

  @Mutation(() => UserModel)
  async createUser(
    @Args('createUserInput') createUserInput: CreateUserInput,
  ): Promise<UserModel> {
    return this.userService.create(createUserInput);
  }

  @Mutation(() => UserModel)
  async updateUser(
    @Args('id') id: string,
    @Args('updateUserInput') updateUserInput: UpdateUserInput,
  ): Promise<UserModel | null> {
    return this.userService.update(id, updateUserInput);
  }

  @Mutation(() => String)
  async removeUser(@Args('id') id: string): Promise<string> {
    return this.userService.remove(id);
  }

  @Mutation(() => UserModel)
  async login(
    @Args('email') email: string,
    @Args('password') password: string,
  ): Promise<UserModel | string> {
    return this.userService.login(email, password);
  }
}

