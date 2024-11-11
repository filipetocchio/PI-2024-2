-- CreateTable
CREATE TABLE "TbVoluntario" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nome" TEXT NOT NULL,
    "sobrenome" TEXT NOT NULL,
    "cpf" TEXT NOT NULL,
    "hashimg" TEXT NOT NULL,
    "openedat" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "closedAt" DATETIME,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "excludedAt" DATETIME
);

-- CreateTable
CREATE TABLE "TbONG" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "cnpj" TEXT NOT NULL,
    "razaoSocial" TEXT NOT NULL,
    "nomeFantasia" TEXT NOT NULL,
    "site" TEXT,
    "instagram" TEXT,
    "descricao" TEXT,
    "areasAtuacao" TEXT NOT NULL,
    "responsavel" TEXT NOT NULL,
    "CPFResponsavel" TEXT NOT NULL,
    "hashimg" TEXT NOT NULL,
    "openedat" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "closedAt" DATETIME,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "excludedAt" DATETIME
);

-- CreateTable
CREATE TABLE "TbUsuario" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "email" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "refreshToken" TEXT,
    "FkIdTbVoluntario" INTEGER,
    "FkIdTbONG" INTEGER,
    "openedat" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "closedAt" DATETIME,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "excludedAt" DATETIME,
    CONSTRAINT "TbUsuario_FkIdTbVoluntario_fkey" FOREIGN KEY ("FkIdTbVoluntario") REFERENCES "TbVoluntario" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "TbUsuario_FkIdTbONG_fkey" FOREIGN KEY ("FkIdTbONG") REFERENCES "TbONG" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "TbEndereco" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "endereco" TEXT NOT NULL,
    "cep" TEXT NOT NULL,
    "cidade" TEXT NOT NULL,
    "estado" TEXT NOT NULL,
    "numero" TEXT NOT NULL,
    "complemento" TEXT,
    "FkIdTbVoluntario" INTEGER,
    "FkIdTbONG" INTEGER,
    "openedat" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "closedAt" DATETIME,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "excludedAt" DATETIME,
    CONSTRAINT "TbEndereco_FkIdTbVoluntario_fkey" FOREIGN KEY ("FkIdTbVoluntario") REFERENCES "TbVoluntario" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "TbEndereco_FkIdTbONG_fkey" FOREIGN KEY ("FkIdTbONG") REFERENCES "TbONG" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "TbContato" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "telefone" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "FkIdTbVoluntario" INTEGER,
    "FkIdTbONG" INTEGER,
    "openedat" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "closedAt" DATETIME,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "excludedAt" DATETIME,
    CONSTRAINT "TbContato_FkIdTbVoluntario_fkey" FOREIGN KEY ("FkIdTbVoluntario") REFERENCES "TbVoluntario" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "TbContato_FkIdTbONG_fkey" FOREIGN KEY ("FkIdTbONG") REFERENCES "TbONG" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "TbProjeto" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nome" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,
    "data" DATETIME NOT NULL,
    "hora" TEXT NOT NULL,
    "local" TEXT NOT NULL,
    "numerVagas" INTEGER NOT NULL,
    "hashimg" TEXT NOT NULL,
    "FkIdTbONG" INTEGER NOT NULL,
    "openedat" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "closedAt" DATETIME,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "excludedAt" DATETIME,
    CONSTRAINT "TbProjeto_FkIdTbONG_fkey" FOREIGN KEY ("FkIdTbONG") REFERENCES "TbONG" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "TbNewsletter" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "titulo" TEXT NOT NULL,
    "conteudo" TEXT NOT NULL,
    "FkIdTbONG" INTEGER NOT NULL,
    "openedat" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "closedAt" DATETIME,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "excludedAt" DATETIME,
    CONSTRAINT "TbNewsletter_FkIdTbONG_fkey" FOREIGN KEY ("FkIdTbONG") REFERENCES "TbONG" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "teste" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "string" TEXT NOT NULL,
    "int" INTEGER NOT NULL,
    "openedat" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "closedAt" DATETIME,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "excludedAt" DATETIME
);

-- CreateTable
CREATE TABLE "_Seguidores" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    CONSTRAINT "_Seguidores_A_fkey" FOREIGN KEY ("A") REFERENCES "TbONG" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_Seguidores_B_fkey" FOREIGN KEY ("B") REFERENCES "TbVoluntario" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_Inscritos" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    CONSTRAINT "_Inscritos_A_fkey" FOREIGN KEY ("A") REFERENCES "TbProjeto" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_Inscritos_B_fkey" FOREIGN KEY ("B") REFERENCES "TbVoluntario" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "TbVoluntario_cpf_key" ON "TbVoluntario"("cpf");

-- CreateIndex
CREATE UNIQUE INDEX "TbONG_cnpj_key" ON "TbONG"("cnpj");

-- CreateIndex
CREATE UNIQUE INDEX "TbUsuario_email_key" ON "TbUsuario"("email");

-- CreateIndex
CREATE UNIQUE INDEX "TbUsuario_username_key" ON "TbUsuario"("username");

-- CreateIndex
CREATE UNIQUE INDEX "TbUsuario_refreshToken_key" ON "TbUsuario"("refreshToken");

-- CreateIndex
CREATE UNIQUE INDEX "TbUsuario_FkIdTbVoluntario_key" ON "TbUsuario"("FkIdTbVoluntario");

-- CreateIndex
CREATE UNIQUE INDEX "TbUsuario_FkIdTbONG_key" ON "TbUsuario"("FkIdTbONG");

-- CreateIndex
CREATE UNIQUE INDEX "TbContato_email_key" ON "TbContato"("email");

-- CreateIndex
CREATE UNIQUE INDEX "_Seguidores_AB_unique" ON "_Seguidores"("A", "B");

-- CreateIndex
CREATE INDEX "_Seguidores_B_index" ON "_Seguidores"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_Inscritos_AB_unique" ON "_Inscritos"("A", "B");

-- CreateIndex
CREATE INDEX "_Inscritos_B_index" ON "_Inscritos"("B");
