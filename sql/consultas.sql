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