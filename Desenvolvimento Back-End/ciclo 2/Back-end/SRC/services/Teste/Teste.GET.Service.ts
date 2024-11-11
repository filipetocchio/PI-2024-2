import { prisma } from "../../utils/prisma";

export class GetTestService {
    async run( id : number) {
        return prisma.teste.findUnique({where: {id}});
    }
}