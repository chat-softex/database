# ChatSoftex

<p align="center">
  <img src="http://img.shields.io/static/v1?label=Draw.io&message=24.6.4&color=f08705&style=for-the-badge&logo=diagramsdotnet"/>
  <img src="http://img.shields.io/static/v1?label=Workbench MySQL&message=8.0.38&color=4479a1&style=for-the-badge&logo=mysql&logoColor=f5f5f5"/>
  <img src="http://img.shields.io/static/v1?label=PostgreSQL&message=16&color=4169e1&style=for-the-badge&logo=postgresql&logoColor=f5f5f5"/>
  <img src="http://img.shields.io/static/v1?label=Firebase&message=10.13.0&color=DD2C00&style=for-the-badge&logo=firebase"/>
  <img src="http://img.shields.io/static/v1?label=STATUS&message=CONCLUIDO&color=green&style=for-the-badge"/>
  <img src="http://img.shields.io/static/v1?label=License&message=MIT&color=green&style=for-the-badge"/>
</p>

> Status do Projeto: :heavy_check_mark: (concluido) | :warning: (em desenvolvimento) | :x: (não iniciada)

### Tópicos 

:small_blue_diamond: [Entidades e Atributos](#entidades-e-atributos-file_folder) :heavy_check_mark:

:small_blue_diamond: [Relacionamentos](#relacionamentos-handshake) :heavy_check_mark:

:small_blue_diamond: [Modelo Lógico - DER](modelo_logico_der) :heavy_check_mark:

:small_blue_diamond: [Modelo Físico - Scripts Create Database](scripts_create_database) :heavy_check_mark:

--- 

## Entidades e Atributos :file_folder:

<p align="justify">

**1. Usuarios** :heavy_check_mark:
  - id (PK) UUID
  - nome VARCHAR
  - email VARCHAR
  - senha (ATENÇÃO: Deverá ser permitido apenas um cadastro por email) VARCHAR
  - tipo (Avaliador, Administrador): VARCHAR
  - data_cadastro TIMESTAMP
  - **OBS:**
    - email com a cláusula UNIQUE: Restrição que garante que todos os valores na coluna email sejam únicos em toda a tabela.
    - data_cadastro com cláusula DEFAULT CURRENT_TIMESTAMP: Define que por padrão, será preenchida com a data e hora atuais no momento em que um novo registro é inserido na tabela.

**2. Empresas** :heavy_check_mark:
  - id (PK) VARCHAR (UUID)
  - nome_fantasia VARCHAR
  - cnpj VARCHAR (UNIQUE)
  - email VARCHAR
  - data_cadastro TIMESTAMP
  - **OBS:**
    - cnpj_empresa com a cláusula UNIQUE: Restrição que garante que todos os valores na coluna cnpj_empresa sejam únicos em toda a tabela.
    - data_cadastro com cláusula DEFAULT CURRENT_TIMESTAMP: Define que por padrão, será preenchida com a data e hora atuais no momento em que um novo registro é inserido na tabela.

**3. Projetos** :heavy_check_mark:
  - id (PK) UUID
  - titulo_projeto VARCHAR
  - data_submissao TIMESTAMP
  - status VARCHAR
  - arquivo VARCHAR (URL para arquivo PDF armazenado no Firebase)
  - avaliador (FK para tabela Usuarios): UUID
  - empresa (FK para tabela Empresas): UUID
  - **OBS:**
    - data_submissao com cláusula DEFAULT CURRENT_TIMESTAMP: Define que por padrão, será preenchida com a data e hora atuais no momento em que um novo registro é inserido na tabela.

**4. Avaliacoes** :heavy_check_mark:
  - id (PK) UUID
  - projeto (FK para a tabela Projetos): UUID
  - data_avaliacao TIMESTAMP
  - feedback_qualitativo TEXT (gerado pela IA ChatGPT)
  - **OBS:**
    - Cada projeto pode ter apenas uma avaliação, garantindo que cada projeto seja avaliado uma única vez.
    - data_avaliacao com cláusula DEFAULT CURRENT_TIMESTAMP: Define que por padrão, será preenchida com a data e hora atuais no momento em que um novo registro é inserido na tabela.

</p>

---

## Relacionamentos :handshake:

**1. Usuarios e Projetos:** :heavy_check_mark:
  - Um-para-Muitos (1:N).
  - Um avaliador (Usuarios) pode avaliar vários projetos, mas cada projeto é avaliado por um único avaliador.
  - Chave Estrangeira: avaliador em Projetos refere-se a id em Usuarios.

**2. Empresas e Projetos:** :heavy_check_mark:
  - Um-para-Muitos (1:N).
  - Uma empresa (Empresas) pode submeter vários projetos, mas cada projeto pertence a uma única empresa.
  - Chave Estrangeira: empresa em Projetos refere-se a id em Empresas.

**3. Projetos e Avaliacoes:** :heavy_check_mark:
  - Um-para-Um (1:1).
  - Cada projeto tem uma única avaliação e cada avaliação está associada a um único projeto.
  - Chave Estrangeira: projeto em Avaliacoes refere-se a id em Projetos.


## Regras de Integridade :pencil:

- **UUID**: Utilização de UUIDs como identificadores primários.
- **Únicos**: Emails de usuários e CNPJs de empresas são únicos.
- **Chaves Estrangeiras**: Cada projeto pertence a uma empresa e a um avaliador.
- **Status dos Projetos**: Os projetos podem estar em um dos seguintes estados: "Em avaliação", "Aprovado" ou "Reprovado".
- **Tipo de Usuarios**: Os usuários podem ser "Administrador" ou "Avaliador".
- **Feedback**: Cada projeto pode ter uma única avaliação gerada pela IA ChatGPT.

---

## Licença 

The [MIT License]() (MIT)

Copyright :copyright: 2024 - ChatSoftex
