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