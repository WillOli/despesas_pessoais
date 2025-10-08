-- =================================================================
-- SCRIPT DE CRIAÇÃO DO BANCO DE DADOS E TABELAS
-- PROJETO: DESPESAS PESSOAIS V2
-- =================================================================

-- 1. CRIA E SELECIONA O BANCO DE DADOS
-- -----------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS db_despesas;
USE db_despesas;

-- 2. TAREFA: Criar a tabela `usuarios`
-- -----------------------------------------------------------------
-- Armazena as informações de login de cada usuário.
CREATE TABLE IF NOT EXISTS usuarios (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL
) ENGINE=InnoDB;


-- 3. TAREFA: Criar a tabela `categorias` com a coluna `usuario_id`
-- -----------------------------------------------------------------
-- Armazena as categorias de despesas, onde cada categoria pertence a um usuário.
CREATE TABLE IF NOT EXISTS categorias (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    usuario_id BIGINT NOT NULL,

    -- Define a relação: a coluna `usuario_id` desta tabela...
    -- ...se refere à coluna `id` da tabela `usuarios`.
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),

    -- Garante que um mesmo usuário não pode ter duas categorias com o mesmo nome.
    UNIQUE KEY uc_categoria_usuario (nome, usuario_id)
) ENGINE=InnoDB;


-- 4. TAREFA: Criar a tabela `transacoes` com a coluna `usuario_id`
-- -----------------------------------------------------------------
-- Armazena cada receita ou despesa, pertencendo a um usuário e a uma categoria.
CREATE TABLE IF NOT EXISTS transacoes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(255) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    data DATE NOT NULL,
    tipo ENUM('RECEITA', 'DESPESA') NOT NULL,
    categoria_id BIGINT NOT NULL,
    usuario_id BIGINT NOT NULL,

    -- Define a relação com a tabela `categorias`.
    FOREIGN KEY (categoria_id) REFERENCES categorias(id),

    -- Define a relação com a tabela `usuarios`.
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
) ENGINE=InnoDB;