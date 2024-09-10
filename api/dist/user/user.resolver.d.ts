import { User } from './entities/user.entity';
import { UserService } from './user.service';
export declare class UserResolver {
    private readonly userService;
    constructor(userService: UserService);
    findAll(): Promise<User[]>;
    createUser(name: string, email: string, password: string, role: string, latitude?: number, longitude?: number): Promise<User>;
}
