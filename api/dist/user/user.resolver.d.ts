import { User as UserModel } from './user.model';
import { UserService } from './user.service';
import { CreateUserInput } from './dto/create-user.input';
import { UpdateUserInput } from './dto/update-user.input';
export declare class UserResolver {
    private readonly userService;
    constructor(userService: UserService);
    findAll(): Promise<UserModel[]>;
    findOne(id: string): Promise<UserModel | null>;
    findAllLivreur(): Promise<UserModel[]>;
    createUser(createUserInput: CreateUserInput): Promise<UserModel>;
    updateUser(id: string, updateUserInput: UpdateUserInput): Promise<UserModel | null>;
    remove(id: string): Promise<string>;
    login(email: string, password: string): Promise<UserModel | null>;
}
