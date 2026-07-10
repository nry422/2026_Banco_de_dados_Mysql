# Banco de Dados MySQL - IFSC 2026
Exercícios e projetos da aula de Banco de Dados do curso 
Técnico em Desenvolvimento de Sistemas - IFSC Jaraguá do Sul

## Projetos
- **Loja Online** - DB teste de Loja online 17/03/2026 explorando relacionamentos e testand funcionalidade
- **Biblioteca** - modelo de banco para sistema de biblioteca, explorando o modelo lógico, explorando relacionamentos e cardinalidade
- **Locadora** - modelo para locadora de filmes
- **Loja Online** - modelo para e-commerce
 
## Scripts de Aulas e Exercícios

`comandos_aula_05_05.sql` — Filtros Básicos e Relacionamentos (Joins)
Consultas introdutórias focadas na extração e filtragem de dados. Utiliza comandos para buscar padrões de texto específicos e navegar entre múltiplas tabelas (Produtos, Lojas, Estoque, Características) para montar relatórios completos.
* **Conceitos:** `SELECT`, cláusula `WHERE`, busca por padrões (`LIKE`), operadores lógicos (`AND`, `OR`), junção de tabelas (`INNER JOIN`), extração de datas (`YEAR`).

`comandos_15052026.sql` — Views e Funções Embutidas (Built-in)
Demonstra a criação de `VIEW`s (tabelas virtuais) para encapsular consultas complexas, facilitando a geração de relatórios recorrentes (ex: cálculo de estoque total, produtos por categoria). Também explora o uso de funções nativas do MySQL para tratar a saída visual dos dados.
* **Conceitos:** `CREATE VIEW`, funções de data e hora (`NOW()`, `DAYNAME()`, `DATE_FORMAT()`), manipulação de strings (`CONCAT()`, `LENGTH()`), arredondamento matemático (`TRUNCATE()`).

`script_aula_19_05_2026.sql` — Subconsultas, Agrupamentos e Lógica Condicional
Script robusto focado em relatórios analíticos avançados. Mostra como aninhar consultas para obter filtros precisos e como gerar colunas dinâmicas (como cálculo de descontos em tempo real) através de estruturas condicionais diretas no `SELECT`.
* **Conceitos:** Subconsultas aninhadas (`IN`), lógica condicional (`CASE WHEN ... THEN`), agrupamentos (`GROUP BY`), filtros pós-agrupamento (`HAVING`), funções de agregação (`SUM`, `COUNT`, `AVG`, `MAX`), ordenação (`ORDER BY`).

`2026-05-26.sql` — Funções Definidas pelo Usuário (Stored Functions)
Focado na criação de blocos de lógica programável e reutilizável dentro do banco de dados. Contém implementações de funções para cálculos matemáticos (descontos, impostos, IMC), manipulação de datas (idade, conversão de formato) e integração dessas funções em consultas `SELECT` do dia a dia. *(Nota: Abrange conteúdo de revisão para prova)*.
* **Conceitos:** `CREATE FUNCTION`, mudança de delimitador (`DELIMITER`), declaração de variáveis locais (`DECLARE`), estruturas de decisão (`IF/ELSE`, `ELSEIF`), laços de repetição (`WHILE`), determinação de tipo de retorno (`RETURNS`).

`2026-06-02comandos.sql` — Gatilhos (Triggers) e Transações (Transactions)
Trabalha com regras de negócio rígidas e integridade de dados. Implementa gatilhos para automatizar ações em segundo plano (como tabelas de log e inserção de data automática) e para bloquear operações inválidas (como estoque negativo) disparando exceções personalizadas. Também aborda a execução segura de múltiplos comandos em bloco.
* **Conceitos:** `TRIGGER` (`BEFORE/AFTER`, `INSERT/UPDATE`), controle de estado (`NEW` e `OLD`), tratamento de erros e exceções (`SIGNAL SQLSTATE`), integridade de transações (`START TRANSACTION`, `COMMIT`, `ROLLBACK`), uso de variáveis de sessão (`@`).
