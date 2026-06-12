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