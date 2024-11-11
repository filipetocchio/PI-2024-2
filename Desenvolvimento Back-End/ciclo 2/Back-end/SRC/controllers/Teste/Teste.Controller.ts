import { Request, Response } from "express";
import { TestRepository } from "../../repositories/TestRepository";
import { DeleteTestService } from "../../services/Teste/Teste.DELETE.Service";
import { GetTestService } from "../../services/Teste/Teste.GET.Service";
import { CreateTestService } from "../../services/Teste/Teste.POST.Service";

class TestController {
  private testRepository: TestRepository;

  constructor() {
    const createTestService = new CreateTestService();
    const deleteTestService = new DeleteTestService();
    const getTestService = new GetTestService();

    this.testRepository = new TestRepository(
      createTestService,
      deleteTestService,
      getTestService
    );
  }

  public async createTest(req: Request, res: Response): Promise<void> {
    try {
      const { string, int } = req.body;

      const newTest = await this.testRepository.createTest({ string, int });
      
      res.status(201).json(newTest);
    } catch (error) {
      console.error("Erro ao criar teste:", error);
      res.status(500).json({ error: "Erro ao criar teste" });
    }


  }
}

export default new TestController();