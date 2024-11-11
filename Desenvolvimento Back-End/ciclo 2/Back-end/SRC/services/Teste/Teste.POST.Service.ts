import { prisma } from "../../utils/prisma";

export interface CreateTestParams {
  string: string;
  int: number;
}

export class CreateTestService {

  async run(data: { string: string; int: number }) {
    return prisma.teste.create({ data });
  }
}
