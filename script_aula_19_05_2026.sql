--Aula dia 19/05/2026

--subconsulta

SELECT nome
FROM produto
where id IN (
	select id_produto
    from Produto_Caracteristica
    where id_caracteristica = (
		select id
        from caracteristica
        where nome = 'Sistema Operacional'
        AND descricao = 'Android 12'
	)
);

select p.nome as pNome
from Produto p
where p.id in (
	select pc.id_produto
    from produto_caracteristica pc
    where pc.id_caracteristica in (
		select c.id
        from caracteristica c
        where c.nome = 'Tela HD'
	)
);

--com inner join para ter nomes

select p.nome as pNome, c.nome
from Produto p
inner join produto_caracteristica pc
inner join caracteristica c
on p.id = pc.id_produto
and pc.id_caracteristica = c.id
where p.id in (
	select pc.id_produto
    from produto_caracteristica pc
    where pc.id_caracteristica in (
		select c.id
        from caracteristica c
        where c.nome = 'Tela HD'
	)
);

-- opcao com innerjoin
select p.nome as pNome, c.nome
from Produto p
inner join produto_caracteristica pc
inner join caracteristica c
on p.id = pc.id_produto
and pc.id_caracteristica = c.id
where c.nome = 'Tela HD';

--opcao professor
select p.nome as pNome, c.nome
from produto p 
inner join produto_caracteristica pc
inner join caracteristica c 
on c.id = pc.id_caracteristica and p.id = pc.id_produto
where c.nome like 'Tela HD';

--case
select nome,tipo, preco,
	case
		when tipo = 'Usado' then preco * 0.10
        when tipo = 'Promocao' then preco * 0.20
        when tipo = 'Liquidacao' then preco * 0.30
        else 0.0
	end as novoDesconto
from Produto;


--cidade quantidade de produtos por cidade e total valor
select l.cidade, sum(p.preco*quantidade_disponivel) as 'valor total', count(p.id) as 'diferentes produto'
from produto as p
inner join estoque as e
inner join loja as l
on p.id = e.id_produto
and e.id_loja = l.id
group by l.cidade
having count(p.id) > 2;

--

select l.cidade, sum(p.preco*quantidade_disponivel) as 'valor total', count(p.id) as 'diferentes produto'
from produto as p
inner join estoque as e
inner join loja as l
on p.id = e.id_produto
and e.id_loja = l.id
group by l.cidade
having sum(p.preco*quantidade_disponivel) > 3000;


--exercicios pdf funcoes embutidas pag 22

--exercicio 1 Liste todos os produtos em ordem alfabética de nome.

select nome from produto
ORDER BY nome ASC;

--exercicio 2 Liste todos os produtos em ordem decrescente de preço.

 
select nome, preco from produto
ORDER BY preco DESC;

--exercicio 3 Liste a quantidade de produtos em cada categoria.


select p.categoria, sum(e.quantidade_disponivel)
from produto as p
inner join estoque as e 
on p.id = e.id_produto
group by p.categoria;

--exercicio 4 Liste a quantidade de produtos em cada loja, apenas para produtos com mais de 5 unidades em estoque.


select sum(e.quantidade_disponivel), l.cidade, l.nome
from estoque as e 
inner join loja as l 
on l.id = e.id_loja
GROUP BY l.cidade
HAVING SUM(e.quantidade_disponivel) > 5;

--exercicio 5 Liste a quantidade total de produtos em estoque por categoria, em ordem decrescente de quantidade.


select sum(e.quantidade_disponivel) as total, p.categoria
from estoque as e 
inner join produto as p 
on  p.id = e.id_produto
group by p.categoria
order by total DESC;

--exercicio 6 Liste as categorias de produtos com o seu respectivo preço médio, ordenado em ordem decrescente de preço médio.


select p.categoria, avg(p.preco) as media
from produto as p
group by p.categoria
order by media DESC;

--exercicio 7 Liste as categorias de produtos junto com o número de produtos em cada categoria que têm um preço superior a 1000. Ordene os resultados em ordem decrescente pelo número de produtos em cada categoria.


select l.nome, l.cidade, avg(e.quantidade_disponivel) as media
from loja as l
inner join estoque as e 
on l.id = e.id_loja
group by l.cidade, l.nome
order by media asc;

--exercicio 8 Liste as categorias de produtos junto com o número de produtos em cada categoria que têm um
-- preço superior a 1000. Ordene os resultados em ordem decrescente pelo número de produtos em cada categoria.


select p.categoria, p.preco, count(p.id) qtd
from produto as p
inner join estoque as e
on p.id = e.id_produto
where p.preco > 1000
group by p.categoria, p.preco;

--exercicio 9 Liste as características (características) que estão associadas a pelo menos 3 produtos diferentes.
 -- Ordene as características em ordem alfabética.


select c.nome, count(pc.id_produto) as total
from caracteristica as c
inner join produto_caracteristica as pc
on c.id = pc.id_caracteristica
group by c.nome
having count(pc.id_produto) >= 3
order by c.nome asc;

--exercicios pag 34

--1  Exiba o nome do produto, seu preço original e uma coluna chamada Faixa que classifique os produtos
-- como: "Econômico" (preço < 50), "Intermediário" (entre 50 e 500) ou "Premium" (acima de 500).


SELECT nome, preco AS preco_original,
    CASE 
        WHEN preco < 50 THEN 'Econômico'
        WHEN preco >= 50 AND preco <= 500 THEN 'Intermediário'
        ELSE 'Premium'
    END AS Faixa
FROM Produto;

--2 Liste o nome, o tipo e calcule o Preco_Final aplicando descontos dinâmicos: se for "Usado", use o
 -- percentual da coluna desconto_usados; se for "Promocao", aplique 15%; se for "Liquidacao", aplique
-- 30%; nos demais casos, mantenha o preço original.


select nome, tipo, 
	case
		when tipo = 'Usado' then preco - (preco * desconto_usados / 100)
		when tipo = 'Promocao' then preco - (0.15 * preco)
		when tipo = 'Liquidacao' then preco - (preco * 0.30)
		else preco
	end as Preco_Final
from Produto;

--3 Mostre o nome de cada produto e uma coluna Status_Estoque com a soma da quantidade disponível
-- em todas as lojas. Classifique como: "Esgotado" (soma = 0), "Baixo" (entre 1 e 5) ou "Adequado" (acima de 5).


select p.nome,
	case
		when sum(e.quantidade_disponivel) = 0 then 'Esgotado'
		when sum(e.quantidade_disponivel) >= 1 and sum(e.quantidade_disponivel) <=5 then 'Baixo'
		else 'Adequado'
	end as Status_Estoque
from produto as p
inner join estoque as e
on p.id = e.id_produto
group by p.nome;

--4 Liste o nome e o preço dos produtos com valor acima da média de preço de todos os produtos cadastrados.


SELECT nome, preco
FROM produto
WHERE preco > (SELECT AVG(preco) FROM produto);

--5 Exiba o nome e a cidade das lojas que possuem em estoque o produto mais caro do catálogo.
Exiba o nome e a cidade das lojas que possuem em estoque o produto mais caro do catálogo.

select l.nome, l.cidade
from loja as l 
inner join estoque as e 
inner join produto as p
on p.id = e.id_produto
and l.id = e.id_loja
WHERE p.preco = (SELECT MAX(preco) FROM produto)
group by l.nome, l.cidade;

--6 Liste os nomes dos produtos que possuem ao menos uma característica contendo a palavra "Tela" no
-- nome, utilizando o operador IN com uma subconsulta.
select p.nome
from produto as p 
where p.id in (
	select pc.id_produto
	from produto_caracteristica as pc
	where pc.id_caracteristica in (
		select c.id
		from caracteristica as c 
		where c.nome like '%Tela%'
	)
);

--7 Liste o nome dos produtos e a quantidade de características vinculadas a eles, filtrando apenas os
-- produtos com mais de 2 características.
SELECT p.nome, COUNT(pc.id_caracteristica) AS total_caracteristicas
FROM produto AS p
INNER JOIN produto_caracteristica AS pc
ON p.id = pc.id_produto
GROUP BY p.nome
HAVING COUNT(pc.id_caracteristica) > 2;

--8 Exiba o nome de cada loja e a soma total de itens em estoque, retornando apenas as lojas com
-- estoque total superior a 30 unidades.

select l.nome, l.cidade, sum(e.quantidade_disponivel)
from loja as l
inner join estoque as e 
on l.id = e.id_loja 
group by l.nome, l.cidade
having sum(e.quantidade_disponivel) > 30;

--9 Agrupe os produtos pelo campo tipo, exiba o tipo e o preço médio, e filtre apenas os grupos com
-- preço médio superior a R$ 400,00.

select tipo, avg(preco) as preco_medio
from Produto
group by tipo
having avg(preco) > 400;








