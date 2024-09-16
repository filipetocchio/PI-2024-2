# Documentação do PI-2024-2

# Documentação Unificada de Arquitetura e Qualidade de Software - MobSocial

## 1. Arquitetura do Sistema

A arquitetura escolhida para o sistema MobSocial é **MVC (Model-View-Controller)**. Esta arquitetura divide o sistema em três componentes principais:

- **Model:** Responsável pela lógica de dados, interações com o banco de dados e manipulação dos dados de negócio.
- **View:** Responsável pela interface com o usuário, apresentando os dados de forma visual e interativa.
- **Controller:** Intermedia as requisições do usuário, manipulando os dados através do Model e atualizando a View conforme necessário.

Esta separação de responsabilidades facilita a manutenção, escalabilidade e a adição de novas funcionalidades ao sistema.

## 2. Componentes e Requisitos do Sistema

### Requisitos Funcionais

#### Para Voluntários:
- Cadastro e login como voluntário.
- Acesso e edição do perfil.
- Seguir e deixar de seguir ONGs.
- Desativar notificações, incluindo notificações específicas de ONGs.
- Inscrição, desvinculação e confirmação de presença em projetos sociais.

#### Para ONGs:
- Cadastro e login como ONG.
- Criação, edição e exclusão (soft delete) de projetos sociais.
- Criação, edição e exclusão (soft delete) de posts para newsletters.
- Listagem de seus projetos sociais e voluntários inscritos.

#### Listagens Gerais:
- Listagem de ONGs e informações detalhadas.
- Listagem de projetos e informações detalhadas.
- Listagem de newsletters e filtro por projetos e ONGs.

### Regras de Negócio

- Notificações de newsletters e projetos sociais controladas por inscrição ou seguimento de ONGs.
- Exclusão de projetos e posts via soft delete.
- Apenas ONGs e admins podem criar e gerenciar projetos e newsletters.
- Envio de QRCode ao criar uma ONG com link para a página de acesso.
- Sistema permite upload e processamento de imagens de documentos pessoais.

### Requisitos Não Funcionais

- Uso de **Docker** para gerenciamento de ambientes.
- Banco de dados **PostgreSQL**.
- Front-End desenvolvido em **React.js**.
- Back-End desenvolvido em **Nest.js**.
- Senhas armazenadas com **criptografia** segura.
- Sistema **responsivo**, acessível e otimizado para **SEO**.
- **Paginação** em todas as listagens.
- Testes automatizados e código bem documentado e organizado.

## 3. Comunicação entre os Componentes

- **Voluntário/ONG (View):** As interações realizadas pelos voluntários e ONGs, como cadastro, login, e ações no sistema, são recebidas pelo **Controller**, que processa as requisições.
- **Controller:** O controller é responsável por processar as requisições recebidas da View e interagir com o **Model** para acessar ou alterar os dados necessários.
- **Model:** O Model contém a lógica de negócio e acessa o banco de dados PostgreSQL para persistir ou recuperar informações. 
- **Banco de Dados (PostgreSQL):** Armazena informações de usuários, projetos, ONGs, newsletters, etc.
- **Back-End (Nest.js):** Processa a lógica de autenticação, segurança, e outras funcionalidades do sistema, comunicando-se com o banco de dados e o Front-End.
- **Front-End (React.js):** Exibe os dados de forma interativa e amigável para os usuários, recebendo as respostas processadas do Back-End.

## 4. Contribuição de Cada Componente

- **Model:** Trata a lógica de negócio, como validações de regras de negócios, controle de exclusão com soft delete, e persistência de dados no banco de dados PostgreSQL.
- **View:** Apresenta ao usuário final as interfaces para que ele possa interagir com o sistema, seja através de listagens, formulários ou notificações.
- **Controller:** Gerencia as requisições de usuários e garante que as interações entre o Model e o View ocorram de forma coesa e eficiente.
- **PostgreSQL:** Garante a persistência e recuperação dos dados de forma confiável e segura, com foco na integridade das informações.
- **Docker:** Facilita o gerenciamento de ambientes, garantindo que o sistema funcione da mesma maneira em diferentes máquinas e servidores.
- **Nest.js (Back-End):** Responsável pela lógica do servidor, segurança, e integração com o banco de dados e o front-end.
- **React.js (Front-End):** Fornece uma experiência de usuário interativa e responsiva, otimizando o acesso e a usabilidade do sistema.

---

# Qualidade de Software - MobSocial

## 1. Integração dos Princípios de Qualidade nas Entregas

O projeto MobSocial integra os princípios de qualidade em todas as suas entregas, garantindo que aspectos como arquitetura, componentes e interações do sistema sigam as melhores práticas para assegurar a manutenção, desempenho e usabilidade. A qualidade é aplicada tanto na fase de desenvolvimento quanto na entrega final, com ênfase em segurança, escalabilidade, e facilidade de uso.

## 2. Arquitetura Escolhida

A arquitetura selecionada para o sistema é **MVC (Model-View-Controller)**, contribuindo significativamente para a qualidade do sistema:

- **Separação de responsabilidades:** O MVC separa a lógica de apresentação (View), a lógica de negócios (Model) e a lógica de controle de fluxo (Controller). Isso facilita a manutenção e a adição de novas funcionalidades sem afetar as demais camadas.
- **Facilidade de manutenção:** Alterações em uma parte do sistema não afetam diretamente outras, tornando o código mais modular e fácil de depurar.
- **Escalabilidade:** A arquitetura MVC permite que componentes sejam facilmente escalados de forma independente, garantindo uma maior flexibilidade ao longo do ciclo de vida do sistema.

## 3. Delimitação e Documentação dos Componentes do Sistema

### Componentes Principais:

- **Front-End (React.js):** Responsável pela interface do usuário. Ele garante acessibilidade e boas práticas de SEO, além de ser responsivo para diferentes dispositivos.
- **Back-End (Nest.js):** Manipula a lógica de negócio, processa as requisições, faz o controle de acesso e integra o banco de dados PostgreSQL.
- **Banco de Dados (PostgreSQL):** Armazena dados de usuários, ONGs, projetos e interações no sistema de forma segura e eficiente.
- **API:** Responsável pela comunicação entre o Front-End e o Back-End, fornecendo dados e manipulando as requisições dos usuários.
- **Docker:** Gerencia o ambiente de desenvolvimento, garantindo consistência nos ambientes de produção e desenvolvimento.

### Comunicação Entre os Componentes:

- **Front-End e Back-End:** O Front-End comunica-se com o Back-End via API para carregar e enviar dados dos usuários, ONGs, e projetos.
- **Back-End e Banco de Dados:** O Back-End interage com o banco de dados para buscar, inserir, atualizar e deletar dados necessários para a aplicação.
- **Docker:** Garante que o ambiente seja replicável, gerenciando as dependências do sistema de forma segura.

## 4. Considerações sobre a Qualidade

### Manutenabilidade:

A arquitetura MVC e o uso de padrões de design como modularidade e separação de responsabilidades contribuem diretamente para a facilidade de manutenção do sistema. As interações entre Front-End e Back-End seguem uma estrutura clara e organizada, com camadas bem definidas, o que facilita a introdução de novas funcionalidades e a manutenção do código existente.

### Desempenho:

Para garantir o desempenho, o sistema utiliza estratégias como **caching** no Front-End e Back-End para acelerar o tempo de resposta. Além disso, a arquitetura é projetada para ser escalável horizontalmente, permitindo a adição de novos recursos e servidores conforme a demanda aumenta. O uso de **Docker** assegura que o sistema opere em ambientes consistentes, melhorando a eficiência em todas as etapas de desenvolvimento e operação.

### Usabilidade:

O Front-End desenvolvido em **React.js** assegura que o sistema seja intuitivo e fácil de usar. O design responsivo garante que o sistema seja acessível em múltiplos dispositivos, como desktops, tablets e smartphones. Além disso, o sistema é projetado com boas práticas de **acessibilidade**, permitindo que pessoas com diferentes níveis de habilidade utilizem o MobSocial de forma eficaz.

## 5. Documentação Completa

Toda a documentação do MobSocial segue uma estrutura clara, detalhando a arquitetura, os componentes e suas interações. Esta documentação serve como referência para os desenvolvedores e stakeholders, garantindo a compreensão do sistema e seu funcionamento.

- **Arquitetura:** Explicação detalhada da escolha do MVC e seus benefícios.
- **Componentes:** Listagem e descrição de todos os componentes do sistema, incluindo Front-End, Back-End, API, Banco de Dados e Docker.
- **Interações:** Documentação sobre como os componentes interagem entre si, como a API se comunica com o banco de dados e o Front-End, e como o Docker facilita a gestão do ambiente.
- **Qualidade:** Explicações sobre como a arquitetura, componentes e interações contribuem para a manutenabilidade, desempenho e usabilidade do sistema.

---

