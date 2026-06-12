-- MODELO LÓGICO (representação simplificada)

Cliente (
    id_cliente PK,
    nome,
    email,
    telefone
)

Restaurante (
    id_restaurante PK,
    nome,
    categoria,
    taxa_entrega
)

Entregador (
    id_entregador PK,
    nome,
    telefone,
    veiculo,
    status_entregador
)
