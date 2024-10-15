-- Habilitar a extensão pgcrypto para usar UUIDs
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Criação da tabela de Empresas
CREATE TABLE Empresas (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),  -- Geração automática de UUIDs como chave primária
    nome_fantasia_empresa VARCHAR(255) NOT NULL,    -- Nome da empresa
    cnpj_empresa VARCHAR(18) UNIQUE NOT NULL,       -- CNPJ único
    email VARCHAR(255) NOT NULL,                    -- Email da empresa
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Data de cadastro com valor padrão atual
);


-- Criação da tabela de Usuarios
CREATE TABLE Usuarios (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),  -- Geração automática de UUIDs como chave primária
    nome VARCHAR(255) NOT NULL,                     -- Nome do usuário
    email VARCHAR(255) UNIQUE NOT NULL,             -- Email único
    senha VARCHAR(255) NOT NULL,                    -- Senha do usuário
    tipo VARCHAR(50) NOT NULL CHECK (tipo IN ('avaliador', 'administrador')),  -- Tipo de usuário com restrição de valor
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Data de cadastro com valor padrão atual
);


-- Criação da tabela de Projetos
CREATE TABLE Projetos (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),  -- Geração automática de UUIDs como chave primária
    titulo_projeto VARCHAR(255) NOT NULL,           -- Título do projeto
    data_submissao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Data de submissão com valor padrão atual
    status VARCHAR(50) NOT NULL CHECK (status IN ('em avaliação', 'aprovado', 'reprovado')),  -- Status do projeto com valores específicos
    arquivo VARCHAR(255) NOT NULL,                 -- URL do arquivo PDF armazenado no Firebase
    avaliador UUID REFERENCES Usuarios(id) ON DELETE SET NULL,  -- Chave estrangeira referenciando a tabela Usuarios, define NULL em caso de exclusão
    empresa UUID REFERENCES Empresas(id) ON DELETE CASCADE  -- Chave estrangeira referenciando a tabela Empresas, com exclusão em cascata
);


-- Criação da tabela de Avaliacoes
CREATE TABLE Avaliacoes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),  -- Geração automática de UUIDs como chave primária
    projeto UUID UNIQUE REFERENCES Projetos(id) ON DELETE CASCADE,  -- Chave estrangeira para Projetos, com exclusão em cascata, relacionamento Um-para-Um
    data_avaliacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Data de avaliação com valor padrão atual
    feedback_qualitativo TEXT NOT NULL                  -- Feedback gerado pela IA ChatGPT
);

