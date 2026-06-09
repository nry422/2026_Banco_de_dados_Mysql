<?php

$meses = [
    1 => 'Janeiro', 2 => 'Fevereiro', 3 => 'Março',
    4 => 'Abril', 5 => 'Maio', 6 => 'Junho',
    7 => 'Julho', 8 => 'Agosto', 9 => 'Setembro',
    10 => 'Outubro', 11 => 'Novembro', 12 => 'Dezembro'
];
// REALIZAR A CONSULTA PARA EXIBIR OS DADOS NA TABELA
include 'conexao.php';



// 1 qtd produtos
$sql1 = "SELECT COUNT(id) AS total_produtos FROM produto";
$res1 = $pdo->query($sql1)->fetch(PDO::FETCH_ASSOC);

// 2: avg preço agrupado por categoria

$sql2 = "SELECT categoria, AVG(preco) AS media_preco FROM produto GROUP BY categoria";
$res2 = $pdo->query($sql2);

// 3: Produto mais caro e mais barato de cada loja

$sql3 = "SELECT 
    l.id AS loja_id,
    l.nome AS loja_nome,
    l.cidade AS loja_cidade,

    p_maior.nome AS produto_caro,
    p_maior.preco AS preco_caro,

    p_menor.nome AS produto_barato,
    p_menor.preco AS preco_barato

FROM Loja l

LEFT JOIN Produto p_maior 
ON p_maior.id = (
    SELECT e1.id_produto
    FROM Estoque e1
    INNER JOIN Produto p1 ON p1.id = e1.id_produto
    WHERE e1.id_loja = l.id
    ORDER BY p1.preco DESC
    LIMIT 1
)

LEFT JOIN Produto p_menor 
ON p_menor.id = (
    SELECT e2.id_produto
    FROM Estoque e2
    INNER JOIN Produto p2 ON p2.id = e2.id_produto
    WHERE e2.id_loja = l.id
    ORDER BY p2.preco ASC
    LIMIT 1
)
";
$res3 = $pdo->query($sql3);

// Consulta 4
$sql4 = "SELECT l.cidade, SUM(e.quantidade_disponivel) AS total_estoque 
         FROM Estoque e
         JOIN Loja l ON e.id_loja = l.id
         GROUP BY l.cidade";
$res4 = $pdo->query($sql4);

// Consulta 5: Quantidade de produtos lançados por mês em 2023

$sql5 = "SELECT 
    MONTH(data_lancamento) AS mes_num,
    COUNT(id) AS total_lancados
FROM Produto
WHERE YEAR(data_lancamento) = 2023
GROUP BY MONTH(data_lancamento)
ORDER BY mes_num
";
$res5 = $pdo->query($sql5);

// Consulta 6: Lojas com mais de 20 produtos em estoque (HAVING)
$sql6 = "SELECT l.id AS loja_id, l.nome AS loja_nome, l.cidade AS loja_cidade, SUM(e.quantidade_disponivel) AS total_estoque
         FROM Loja l
         JOIN Estoque e ON e.id_loja = l.id
         GROUP BY l.id, l.nome, l.cidade
         HAVING total_estoque > 20";
$res6 = $pdo->query($sql6);
?>


<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Relatorio analitico</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
</head>
<body class="bg-light">

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
        <h1 class="h2 text-dark">Relatório Analítico de Produtos</h1>
        <span class="badge bg-primary p-2">Filtro: Ano 2023</span>
    </div>

        <!-- 1ª LINHA: Indicador Geral e Estoque por Cidade -->
        <div class="row g-4 mb-4">
        <!-- CARD 1: Total Geral -->
        <div class="col-md-4">
            <div class="card h-100 border-start border-primary border-4 shadow-sm">
                <div class="card-body d-flex flex-column justify-content-center text-center">
                    <h6 class="card-title text-muted text-uppercase fs-7 fw-bold">Produtos Diferentes</h6>
                    <p class="display-4 fw-bold text-primary my-2"><?= $res1['total_produtos'] ?></p>
                    <small class="text-muted">Cadastrados via COUNT(id)</small>
                </div>
            </div>
        </div>

          <!-- CARD 4: Estoque por Cidade -->
          <div class="col-md-8">
            <div class="card h-100 shadow-sm">
                <div class="card-header bg-white fw-bold">Total em Estoque por Cidade</div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr><th>Cidade</th><th class="text-end">Qtd Disponível</th></tr>
                            </thead>
                            <tbody>
                                <?php while($row = $res4->fetch(PDO::FETCH_ASSOC)): ?>
                                <tr>
                                    <td><?= htmlspecialchars($row['cidade']) ?></td>
                                    <td class="text-end fw-bold"><?= number_format($row['total_estoque'], 0, ',', '.') ?> un</td>
                                </tr>
                                <?php endwhile; ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

     <!-- 2ª LINHA: Médias por Categoria e Alertas de Estoque Alto -->
     <div class="row g-4 mb-4">
        <!-- CARD 2: Média por Categoria -->
        <div class="col-md-6">
            <div class="card h-100 shadow-sm">
                <div class="card-header bg-white fw-bold">Média de Preço por Categoria</div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr><th>Categoria (SET)</th><th class="text-end">Preço Médio</th></tr>
                            </thead>
                            <tbody>
                                <?php while($row = $res2->fetch(PDO::FETCH_ASSOC)): ?>
                                <tr>
                                    <td><span class="badge bg-light text-dark border"><?= htmlspecialchars($row['categoria']) ?></span></td>
                                    <td class="text-end text-success fw-semibold">R$ <?= number_format($row['media_preco'], 2, ',', '.') ?></td>
                                </tr>
                                <?php endwhile; ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>


        <!-- CARD 6: Lojas com Estoque > 20 -->
        <div class="col-md-6">
            <div class="card h-100 shadow-sm border-danger-subtle">
                <div class="card-header bg-danger-subtle text-danger-emphasis fw-bold">Alerta: Lojas com Estoque Crítico (> 20 un)</div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr><th>Loja ID / Nome</th><th>Cidade</th><th class="text-end">Estoque Total</th></tr>
                            </thead>
                            <tbody>
                            <?php if($res6->rowCount() == 0): ?>
                                    <tr><td colspan="3" class="text-center text-muted p-3">Nenhuma loja acima de 20 unidades.</td></tr>
                                <?php endif; ?>
                                <?php while($row = $res6->fetch(PDO::FETCH_ASSOC)): ?>
                                <tr>
                                    <td><small class="text-muted">#<?= $row['loja_id'] ?></small> <strong><?= htmlspecialchars($row['loja_name'] ?? $row['loja_nome']) ?></strong></td>
                                    <td><?= htmlspecialchars($row['loja_cidade']) ?></td>
                                    <td class="text-end text-danger fw-bold"><?= $row['total_estoque'] ?> un</td>
                                </tr>
                                <?php endwhile; ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- CARD 3: Maior e Menor Preço por Loja -->
<div class="row g-4 mb-4">
    <div class="col-12">
        <div class="card shadow-sm">
            <div class="card-header bg-white fw-bold">
                Produto Mais Caro e Mais Barato por Loja
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>Loja</th>
                                <th>Cidade</th>
                                <th>Produto Mais Caro</th>
                                <th>Preço</th>
                                <th>Produto Mais Barato</th>
                                <th>Preço</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php while($row = $res3->fetch(PDO::FETCH_ASSOC)): ?>
                            <tr>
                                <td><?= htmlspecialchars($row['loja_nome']) ?></td>
                                <td><?= htmlspecialchars($row['loja_cidade']) ?></td>
                                <td><?= htmlspecialchars($row['produto_caro']) ?></td>
                                <td class="text-success fw-bold">
                                    R$ <?= number_format($row['preco_caro'], 2, ',', '.') ?>
                                </td>
                                <td><?= htmlspecialchars($row['produto_barato']) ?></td>
                                <td class="text-primary fw-bold">
                                    R$ <?= number_format($row['preco_barato'], 2, ',', '.') ?>
                                </td>
                            </tr>
                            <?php endwhile; ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

    
    <!-- 3ª LINHA: Lançamentos por Mês -->
<div class="row g-4 mb-4">
    <div class="col-12">
        <div class="card shadow-sm">
            <div class="card-header bg-white fw-bold">
                Lançamentos de Produtos por Mês (2023)
            </div>

            <div class="card-body">
                <div class="row row-cols-2 row-cols-sm-3 row-cols-md-4 row-cols-lg-6 g-3">

                    <?php while($row = $res5->fetch(PDO::FETCH_ASSOC)): ?>
                    <div class="col">
                        <div class="p-3 bg-light rounded text-center border">

                            <small class="text-muted d-block">
                                <?= $meses[$row['mes_num']] ?>
                            </small>

                            <span class="fs-4 fw-bold">
                                <?= $row['total_lancados'] ?>
                            </span>

                        </div>
                    </div>
                    <?php endwhile; ?>

                </div>
            </div>
        </div>
    </div>
</div>

    
</body>
</html>