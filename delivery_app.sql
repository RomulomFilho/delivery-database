-- Criação do banco 

-- CREATE DATABASE delivery_app;
-- USE delivery_app;


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


-- =========================
-- DML (Manipulação de dados)
-- =========================


-- CLIENTES (10)
INSERT INTO Cliente (nome, email, telefone) VALUES
('João Silva', '[joao@email.com](mailto:joao@email.com)', '81999990001'),
('Maria Souza', '[maria@email.com](mailto:maria@email.com)', '81999990002'),
('Carlos Lima', '[carlos@email.com](mailto:carlos@email.com)', '81999990003'),
('Ana Paula', '[ana@email.com](mailto:ana@email.com)', '81999990004'),
('Pedro Santos', '[pedro@email.com](mailto:pedro@email.com)', '81999990005'),
('Juliana Alves', '[juliana@email.com](mailto:juliana@email.com)', '81999990006'),
('Rafael Costa', '[rafael@email.com](mailto:rafael@email.com)', '81999990007'),
('Fernanda Rocha', '[fernanda@email.com](mailto:fernanda@email.com)', '81999990008'),
('Bruno Martins', '[bruno@email.com](mailto:bruno@email.com)', '81999990009'),
('Camila Freitas', '[camila@email.com](mailto:camila@email.com)', '81999990010');

-- RESTAURANTES (3)
INSERT INTO Restaurante (nome, categoria, taxa_entrega) VALUES
('Pizza Top', 'Pizza', 5.00),
('Burger House', 'Hamburguer', 6.50),
('Sushi Express', 'Japonesa', 8.00);

-- ENTREGADORES (3)
INSERT INTO Entregador (nome, telefone, veiculo, status_entregador) VALUES
('José Entrega', '81988880001', 'Moto', 'disponivel'),
('Lucas Rápido', '81988880002', 'Bicicleta', 'ocupado'),
('Marcos Flash', '81988880003', 'Moto', 'disponivel');

-- ENDEREÇOS (10 clientes + 3 restaurantes)
INSERT INTO Endereco (rua, numero, bairro, cidade, estado, cep, id_cliente) VALUES
('Rua A', '10', 'Centro', 'Recife', 'PE', '50000-000', 1),
('Rua B', '20', 'Boa Viagem', 'Recife', 'PE', '50000-001', 2),
('Rua C', '30', 'Pina', 'Recife', 'PE', '50000-002', 3),
('Rua D', '40', 'Casa Forte', 'Recife', 'PE', '50000-003', 4),
('Rua E', '50', 'Graças', 'Recife', 'PE', '50000-004', 5),
('Rua F', '60', 'Derby', 'Recife', 'PE', '50000-005', 6),
('Rua G', '70', 'Espinheiro', 'Recife', 'PE', '50000-006', 7),
('Rua H', '80', 'Madalena', 'Recife', 'PE', '50000-007', 8),
('Rua I', '90', 'Torre', 'Recife', 'PE', '50000-008', 9),
('Rua J', '100', 'Afogados', 'Recife', 'PE', '50000-009', 10);

INSERT INTO Endereco (rua, numero, bairro, cidade, estado, cep, id_restaurante) VALUES
('Rua Pizza', '101', 'Centro', 'Recife', 'PE', '50010-000', 1),
('Rua Burger', '202', 'Boa Viagem', 'Recife', 'PE', '50020-000', 2),
('Rua Sushi', '303', 'Pina', 'Recife', 'PE', '50030-000', 3);

-- PRODUTOS (15)
INSERT INTO Produto (nome, preco, descricao, id_restaurante) VALUES
('Pizza Calabresa', 30.00, 'Pizza média', 1),
('Pizza Frango', 32.00, 'Pizza média', 1),
('Pizza Portuguesa', 35.00, 'Pizza grande', 1),
('Hamburguer Simples', 15.00, 'Carne e pão', 2),
('Hamburguer Duplo', 22.00, '2 carnes', 2),
('Batata Frita', 10.00, 'Porção média', 2),
('Sushi Combo 10', 25.00, '10 peças', 3),
('Sushi Combo 20', 45.00, '20 peças', 3),
('Temaki', 18.00, 'Cone japonês', 3),
('Refrigerante', 6.00, 'Lata', 1),
('Suco', 7.00, 'Natural', 2),
('Água', 4.00, '500ml', 3),
('Pizza Chocolate', 28.00, 'Doce', 1),
('Hamburguer Vegano', 20.00, 'Sem carne', 2),
('Hot Roll', 22.00, 'Frito', 3);

-- PEDIDOS (10)
INSERT INTO Pedido (status_pedido, valor_total, id_cliente, id_restaurante, id_entregador) VALUES
('pendente', 40.00, 1, 1, 1),
('entregue', 22.00, 2, 2, 2),
('entregue', 45.00, 3, 3, 3),
('pendente', 35.00, 4, 1, 1),
('cancelado', 15.00, 5, 2, 2),
('entregue', 50.00, 6, 3, 3),
('pendente', 28.00, 7, 1, 1),
('entregue', 20.00, 8, 2, 2),
('entregue', 60.00, 9, 3, 3),
('pendente', 18.00, 10, 3, 1);

-- ITENS DO PEDIDO
INSERT INTO ItemPedido VALUES
(1, 1, 1, 30.00),
(1, 10, 2, 6.00),
(2, 4, 1, 15.00),
(2, 6, 1, 10.00),
(3, 8, 1, 45.00),
(4, 3, 1, 35.00),
(5, 4, 1, 15.00),
(6, 8, 1, 45.00),
(6, 12, 1, 4.00),
(7, 13, 1, 28.00),
(8, 14, 1, 20.00),
(9, 8, 1, 45.00),
(9, 15, 1, 22.00),
(10, 9, 1, 18.00);

-- PAGAMENTOS (1:1)
INSERT INTO Pagamento (metodo, status_pagamento, valor, data_pagamento, id_pedido) VALUES
('pix', 'aprovado', 40.00, NOW(), 1),
('cartao', 'aprovado', 22.00, NOW(), 2),
('pix', 'aprovado', 45.00, NOW(), 3),
('dinheiro', 'pendente', 35.00, NULL, 4),
('cartao', 'recusado', 15.00, NOW(), 5),
('pix', 'aprovado', 50.00, NOW(), 6),
('dinheiro', 'pendente', 28.00, NULL, 7),
('cartao', 'aprovado', 20.00, NOW(), 8),
('pix', 'aprovado', 60.00, NOW(), 9),
('dinheiro', 'pendente', 18.00, NULL, 10);

-- AVALIAÇÕES
INSERT INTO Avaliacao (nota, comentario, data_avaliacao, id_cliente, id_restaurante) VALUES
(5, 'Excelente!', NOW(), 1, 1),
(4, 'Muito bom', NOW(), 2, 2),
(3, 'Ok', NOW(), 3, 3),
(5, 'Perfeito', NOW(), 4, 1),
(2, 'Demorou', NOW(), 5, 2),
(4, 'Gostei', NOW(), 6, 3),
(5, 'Top!', NOW(), 7, 1),
(3, 'Normal', NOW(), 8, 2),
(4, 'Bom', NOW(), 9, 3),
(5, 'Recomendo', NOW(), 10, 3);


-- =========================
-- Consultas SQL
-- =========================


-- Mostra todos os clientes
SELECT * FROM Cliente;

-- Filtra clientes por nome (exemplo)
SELECT nome, email
FROM Cliente
WHERE nome LIKE '%Silva%';

-- Pedidos com cliente e restaurante
SELECT 
    p.id_pedido,
    c.nome AS cliente,
    r.nome AS restaurante,
    p.status_pedido,
    p.valor_total
FROM Pedido p
INNER JOIN Cliente c ON p.id_cliente = c.id_cliente
INNER JOIN Restaurante r ON p.id_restaurante = r.id_restaurante;

-- JOIN com entregador
SELECT 
    p.id_pedido,
    e.nome AS entregador,
    p.status_pedido
FROM Pedido p
LEFT JOIN Entregador e ON p.id_entregador = e.id_entregador;

-- Quantidade de pedidos por restaurante
SELECT 
    r.nome,
    COUNT(p.id_pedido) AS total_pedidos
FROM Restaurante r
LEFT JOIN Pedido p ON r.id_restaurante = p.id_restaurante
GROUP BY r.id_restaurante, r.nome;

-- Faturamento por restaurante
SELECT 
    r.nome,
    SUM(p.valor_total) AS faturamento
FROM Restaurante r
JOIN Pedido p ON r.id_restaurante = p.id_restaurante
GROUP BY r.id_restaurante, r.nome;

-- Cliente que mais gastou
SELECT 
    c.nome,
    SUM(p.valor_total) AS total_gasto
FROM Cliente c
JOIN Pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nome
ORDER BY total_gasto DESC
LIMIT 1;

-- Pedido com itens detalhados
SELECT 
    p.id_pedido,
    pr.nome AS produto,
    ip.quantidade,
    ip.preco_unitario
FROM ItemPedido ip
JOIN Pedido p ON ip.id_pedido = p.id_pedido
JOIN Produto pr ON ip.id_produto = pr.id_produto
ORDER BY p.id_pedido;

-- Média de valor dos pedidos
SELECT AVG(valor_total) AS media_pedidos
FROM Pedido;

-- Entregadores mais ativos
SELECT 
    e.nome,
    COUNT(p.id_pedido) AS entregas
FROM Entregador e
JOIN Pedido p ON e.id_entregador = p.id_entregador
GROUP BY e.id_entregador, e.nome
ORDER BY entregas DESC;

-- Pedidos por status
SELECT 
    status_pedido,
    COUNT(*) AS quantidade
FROM Pedido
GROUP BY status_pedido;

-- Clientes que nunca fizeram pedido
-- Adicionado UNION para tratar caso tabela vazia
SELECT c.nome
FROM Cliente c
LEFT JOIN Pedido p ON c.id_cliente = p.id_cliente
WHERE p.id_pedido IS NULL

UNION

SELECT 'Todos os clientes já fizeram pedidos'
WHERE NOT EXISTS (
    SELECT 1
    FROM Cliente c
    LEFT JOIN Pedido p ON c.id_cliente = p.id_cliente
    WHERE p.id_pedido IS NULL
);


-- =========================
-- Procedures
-- =========================


-- PROCEDURE 1 — Criar Pedido
DELIMITER $$

CREATE PROCEDURE CriarPedido (
    IN p_id_cliente INT,
    IN p_id_restaurante INT,
    IN p_id_entregador INT
)
BEGIN
    INSERT INTO Pedido (
        id_cliente,
        id_restaurante,
        id_entregador,
        status_pedido,
        valor_total,
        data_pedido
    )
    VALUES (
        p_id_cliente,
        p_id_restaurante,
        p_id_entregador,
        'pendente',
        0,
        NOW()
    );
END $$

DELIMITER ;

-- PROCEDURE 2 — Adicionar Item ao Pedido
DELIMITER $$

CREATE PROCEDURE AdicionarItemPedido (
    IN p_id_pedido INT,
    IN p_id_produto INT,
    IN p_quantidade INT
)
BEGIN
    DECLARE v_preco DECIMAL(10,2);

    -- pegar preço do produto
    SELECT preco INTO v_preco
    FROM Produto
    WHERE id_produto = p_id_produto;

    -- inserir item
    INSERT INTO ItemPedido (
        id_pedido,
        id_produto,
        quantidade,
        preco_unitario
    )
    VALUES (
        p_id_pedido,
        p_id_produto,
        p_quantidade,
        v_preco
    );
END $$

DELIMITER ;

-- PROCEDURE 3 — Atualizar Valor Total do Pedido
DELIMITER $$

CREATE PROCEDURE AtualizarTotalPedido (
    IN p_id_pedido INT
)
BEGIN
    UPDATE Pedido
    SET valor_total = (
        SELECT SUM(quantidade * preco_unitario)
        FROM ItemPedido
        WHERE id_pedido = p_id_pedido
    )
    WHERE id_pedido = p_id_pedido;
END $$

DELIMITER ;

-- PROCEDURE 4 — Atualizar Status do Pedido
DELIMITER $$

CREATE PROCEDURE AtualizarStatusPedido (
    IN p_id_pedido INT,
    IN p_status_pedido VARCHAR(50)
)
BEGIN
    UPDATE Pedido
    SET status_pedido = p_status_pedido
    WHERE id_pedido = p_id_pedido;
END $$

DELIMITER ;

-- PROCEDURE 5 — Listar Pedidos por Cliente
DELIMITER $$

CREATE PROCEDURE ListarPedidosCliente (
    IN p_id_cliente INT
)
BEGIN
    SELECT 
        p.id_pedido,
        p.status_pedido,
        p.valor_total,
        p.data_pedido,
        r.nome AS restaurante
    FROM Pedido p
    JOIN Restaurante r ON p.id_restaurante = r.id_restaurante
    WHERE p.id_cliente = p_id_cliente;
END $$

DELIMITER ;

-- Execução dos Procedures
CALL CriarPedido(1, 1, 1);

CALL AdicionarItemPedido(11, 2, 5);

CALL AtualizarTotalPedido(11);

CALL AtualizarStatusPedido(11, 'entregue');

CALL ListarPedidosCliente(1);