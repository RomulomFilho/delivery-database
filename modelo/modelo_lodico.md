TABELA: Cliente

* id_cliente (PK)
* nome
* email
* telefone

TABELA: Restaurante

* id_restaurante (PK)
* nome
* categoria

TABELA: Pedido

* id_pedido (PK)
* data
* status
* valor_total
* id_cliente (FK)
* id_restaurante (FK)

TABELA: Produto

* id_produto (PK)
* nome
* preco
* id_restaurante (FK)

TABELA: Item_Pedido

* id_item (PK)
* quantidade
* preco_unitario
* id_pedido (FK)
* id_produto (FK)

TABELA: Entregador

* id_entregador (PK)
* nome
* telefone
