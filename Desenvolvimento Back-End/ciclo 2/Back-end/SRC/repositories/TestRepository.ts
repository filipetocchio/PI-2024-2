import { DeleteTestService } from "../services/Teste/Teste.DELETE.Service";
import { GetTestService } from "../services/Teste/Teste.GET.Service";
import { CreateTestParams, CreateTestService } from "../services/Teste/Teste.POST.Service";
import { ITestRepository } from "./ITestRepository";


export class TestRepository implements ITestRepository {

constructor(private createTestService: CreateTestService, private deleteTestService: DeleteTestService, private getTestService: GetTestService) {}

  async createTest(data: CreateTestParams) {
    return this.createTestService.run(data);
  };

  async deleteTest(id: number) {
    return this.deleteTestService.run(id);
  };

  async getTest(id: number) {
    return this.getTestService.run(id)
  };
}


