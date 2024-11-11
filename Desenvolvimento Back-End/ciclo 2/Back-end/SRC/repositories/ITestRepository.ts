export interface ITestRepository {
    createTest(data: { string: string; int: number }): Promise<any>;
    deleteTest(id: number): Promise<any>;
    getTest(id: number): Promise<any>;
}


