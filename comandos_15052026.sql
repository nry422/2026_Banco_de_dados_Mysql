--aula 15/05/2026

--1criar view
create view produtoscomdesconto
as select nome, preco as "preco desconto",
desconto_usados as desconto from produto
where desconto_usados > 0;

--abrir view
select * from produtoscomdesconto;


--2criar view
create view caracteristicasporproduto
as select p.nome, c.nome as "nome descricao", c.descricao
from produto as p
inner join produto_caracteristica as pc
inner join caracteristica as c
on p.id = pc.id_produto
and pc.id_caracteristica = c.id;

--abrir view
select * from caracteristicasporproduto;

--3criar view
create view estoqueporproduto
as select p.nome, sum(e.quantidade_disponivel) as quantidade_total
from produto as p
inner join estoque as e 
on p.id = e.id_produto
group by p.nome;

--abrir view
select * from estoqueporproduto;


--4criar view
create view produtosporcategoria
as select p.categoria, count(p.id) as total_produtos, sum(e.quantidade_disponivel) as estoque_total
from produto as p
inner join estoque as e 
on p.id = e.id_produto
group by p.categoria;

--abrir view
select * from produtosporcategoria; 

--exemplo ORDER
select sum(preco) from produto; --some total do valor dos produtoscomdesconto sem considerar quantiade e estoque
select categoria, sum(preco) from produto group by categoria;

select p.categoria, sum(p.preco*e.quantidade_disponivel) --tentar mostrar produtos por categoria considerando estoque
from produto as p
inner join estoque as e
on p.id = e.id_produto
group by categoria;


--exercicios funcoes embutidas

SELECT NOW();

SELECT DAYNAME(NOW());

SELECT DATE_FORMAT('2026-05-12','%d/%M/%Y') 
as "Data Fromatada"

--3concatenar
select data_lancamento, CONCAT(concat(nome, " "), categoria) as "Nome completo"
from produto order by data_lancamento ASC
limit 1

--media preco produts
select concat("R$", truncate(avg(preco), 2)) as "preço médio"
from produto

---nome mais longo
select nome, length(descricao) as "comprimento"
from produto order by comprimento DESC
LIMIT 1



