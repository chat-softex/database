-- Habilitar a extensão pgcrypto para usar UUIDs
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Criação da tabela de Empresas
CREATE TABLE Empresas (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nome_fantasia_empresa VARCHAR(255) NOT NULL,
    cnpj_empresa VARCHAR(18) UNIQUE NOT NULL,
    email VARCHAR(255) NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Criação da tabela de Usuarios
CREATE TABLE Usuarios (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    tipo VARCHAR(50) NOT NULL CHECK (tipo IN ('Avaliador', 'Administrador')),
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Criação da tabela de Projetos
CREATE TABLE Projetos (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    titulo_projeto VARCHAR(255) NOT NULL,
    data_submissao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) NOT NULL,
    arquivo VARCHAR(255) NOT NULL, -- URL do arquivo PDF armazenado no Firebase
    avaliador UUID REFERENCES Usuarios(id),
    empresa UUID REFERENCES Empresas(id)
);

-- Criação da tabela de Avaliacoes 
CREATE TABLE Avaliacoes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    projeto UUID UNIQUE REFERENCES Projetos(id),
    data_avaliacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    feedback_qualitativo TEXT NOT NULL -- Feedback gerado pela IA ChatGPT
);
