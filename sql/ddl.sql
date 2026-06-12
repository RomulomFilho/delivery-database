-- =========================
-- DDL (Estrutura)
-- =========================


-- Tabelas base (sem dependencia forte)
CREATE TABLE Cliente (
    id_cliente  INT AUTO_INCREMENT PRIMARY KEY,
    nome        VARCHAR(100) NOT NULL,
    email       VARCHAR(100) NOT NULL UNIQUE,
    telefone    VARCHAR(20)
);

CREATE TABLE Restaurante (
    id_restaurante  INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(100) NOT NULL,
    categoria       VARCHAR(50),
    taxa_entrega    DECIMAL(10,2) DEFAULT 0
);

CREATE TABLE Entregador (
    id_entregador INT AUTO_INCREMENT PRIMARY KEY,
    nome                VARCHAR(100) NOT NULL,
    telefone            VARCHAR(20),
    veiculo             VARCHAR(50),
    status_entregador   ENUM('disponivel', 'ocupado', 'offline') DEFAULT 'disponivel'
);

-- Tabelas dependentes
CREATE TABLE Endereco (
    id_endereco     INT AUTO_INCREMENT PRIMARY KEY,
    rua             VARCHAR(150)  NOT NULL,
    numero          VARCHAR(10),
    bairro          VARCHAR(100),
    cidade          VARCHAR(100)  NOT NULL,
    estado          VARCHAR(50)   NOT NULL,
    cep             VARCHAR(20),
    id_cliente      INT,
    id_restaurante  INT,
    
    FOREIGN KEY (id_cliente)      REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_restaurante)  REFERENCES Restaurante(id_restaurante),
    
    CHECK (
        (id_cliente IS NOT NULL AND id_restaurante IS NULL)
        OR
        (id_cliente IS NULL AND id_restaurante IS NOT NULL)
    )
);

CREATE TABLE Produto (
    id_produto      INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(100)  NOT NULL,
    preco           DECIMAL(10,2) NOT NULL,
    descricao       VARCHAR(255),
    id_restaurante  INT           NOT NULL,
    FOREIGN KEY (id_restaurante) REFERENCES Restaurante(id_restaurante)
);

-- Tabela central
CREATE TABLE Pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    status_pedido ENUM('pendente', 'entregue', 'cancelado') 
        NOT NULL DEFAULT 'pendente',
    valor_total DECIMAL(10,2) NOT NULL CHECK (valor_total >= 0),
    id_cliente INT NOT NULL,
    id_restaurante INT NOT NULL,
    id_entregador INT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_restaurante) REFERENCES Restaurante(id_restaurante),
    FOREIGN KEY (id_entregador) REFERENCES Entregador(id_entregador)
);

-- Relacionamentos
CREATE TABLE ItemPedido (
    id_pedido       INT             NOT NULL,
    id_produto      INT             NOT NULL,
    quantidade      INT             NOT NULL,
    CHECK (quantidade > 0),
    preco_unitario  DECIMAL(10,2)   NOT NULL,
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido)   REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_produto)  REFERENCES Produto(id_produto)
);

CREATE TABLE Pagamento (
    id_pagamento      INT AUTO_INCREMENT PRIMARY KEY,
    metodo            ENUM('cartao', 'pix', 'dinheiro')   NOT NULL,
    status_pagamento  ENUM('pendente', 'aprovado', 'recusado')   NOT NULL DEFAULT 'pendente',
    valor             DECIMAL(10,2) NOT NULL,
    CHECK (valor >= 0),
    data_pagamento    DATETIME,
    id_pedido         INT           UNIQUE,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido)
);

CREATE TABLE Avaliacao (
    id_avaliacao    INT AUTO_INCREMENT PRIMARY KEY,
    nota            INT NOT NULL, 
    CHECK (nota >= 1 AND nota <= 5),
    comentario      VARCHAR(255),
    data_avaliacao  DATETIME,
    id_cliente      INT NOT NULL,
    id_restaurante  INT NOT NULL,
    FOREIGN KEY (id_cliente)      REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_restaurante)  REFERENCES Restaurante(id_restaurante)
);