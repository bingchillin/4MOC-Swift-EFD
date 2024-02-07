export class CreatePackageDto {
    name: string;
    status: string;
    proof: string;
    latitude: number;
    longitude: number;
    idUserclient: string;
    idUserDelivery: string;
    isAffected: boolean;
}
