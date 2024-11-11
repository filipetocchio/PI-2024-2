import { prisma } from "../../utils/prisma";

export interface CreateTestParams {
  string: string;
  int: number;
}

export class DeleteTestService {

  async run(id: number) {
    return prisma.teste.delete({ where: {id} });
  }
}
