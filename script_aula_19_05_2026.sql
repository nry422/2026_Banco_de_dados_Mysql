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

--exercicio 1
select nome from produto
ORDER BY nome ASC;

--exercicio 2

select nome, preco from produto
ORDER BY preco DESC;

--exercicio 3

select p.categoria, sum(e.quantidade_disponivel)
from produto as p
inner join estoque as e 
on p.id = e.id_produto
group by p.categoria;

--exercicio 4

select sum(e.quantidade_disponivel), l.cidade, l.nome
from estoque as e 
inner join loja as l 
on l.id = e.id_loja
where e.quantidade_disponivel > 5
group by l.cidade;

--exercicio 5

select sum(e.quantidade_disponivel) as total, p.categoria
from estoque as e 
inner join produto as p 
on  p.id = e.id_produto
group by p.categoria
order by total DESC;

--exercicio 6

select p.categoria, avg(p.preco) as media
from produto as p
group by p.categoria
order by media DESC;

--exercicio 7

select l.nome, l.cidade, avg(e.quantidade_disponivel) as media
from loja as l
inner join estoque as e 
on l.id = e.id_loja
group by l.cidade
order by media asc;

--exercicio 8

select p.categoria, p.preco, count(p.id) qtd
from produto as p
inner join estoque as e
on p.id = e.id_produto
where p.preco > 1000
group by p.categoria;

--exercicio 9

select c.nome, count(pc.id_produto) as total
from caracteristica as c
inner join produto_caracteristica as pc
on c.id = pc.id_caracteristica
group by c.nome
having count(pc.id_produto) >= 3
order by c.nome asc;

--exercicios pag 34

--1

select nome, preco,
		case
			when p.preco >



SELECT 
    nome,
    preco AS preco_original,
    CASE 
        WHEN preco < 50 THEN 'Econômico'
        WHEN preco BETWEEN 50 AND 500 THEN 'Intermediário'
        ELSE 'Premium'
    END AS Faixa
FROM Produto;





