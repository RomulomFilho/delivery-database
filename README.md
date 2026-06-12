# delivery-database
# 🍔 Sistema de Delivery - Banco de Dados

## 📌 Descrição
Projeto de banco de dados para um sistema de delivery.

## 📁 Estrutura do Projeto

- `sql/ddl.sql` → criação das tabelas  
- `sql/dml.sql` → inserção e manipulação de dados  
- `sql/procedures.sql` → regras de negócio  
- `sql/consultas.sql` → consultas SQL  
- `modelo/` → diagramas do banco  

## ⚙️ Como executar

### Opção 1
1. Através do script principal (run.sql) que automatiza toda a execução do banco, garantindo a ordem correta entre estrutura, dados, procedures e consultas.
   ```sql
   source run.sql;

### Opção 2
2. Execute o script completo:
   ```sql
   source delivery_app.sql;