--comandos aula 05-05-2026

--01
select nome, tipo
where categoria like "Eletro%";

--02
select nome, tipo
from produto
where preco > 1000;

--03
select nome, categoria, data_lancamento
from produto
where year(data_lancamento) = 2023;

--04
select nome, descricao
from produto where descricao like "Smartphone%";

--05
select nome, categoria
from produto where categoria like "eletronico%" or categoria like "telefonia%";

--06
select nome, descricao
from produto where descricao like "%profissional%";

--07
select nome, descricao
from produto where nome like "C%";

--08
select nome, categoria
from produto where nome like "%Premium";

--09
select nome, descricao
from produto where descricao like "%alta%" and preco > '900';

--10
select nome, descricao
from produto 
where nome like "%smartphone%" or  "%notebook%";

--exercicio 02

--01
select p.nome, p.descricao
from produto AS p
inner join estoque as e
inner join loja as l
on p.id = e.id_produto
and l.id = e.id_loja
where l.cidade like "Sao Paulo";

--02

select p.nome, c.descricao
from produto AS p
inner join caracteristica as c
inner join produto_caracteristica as pc
on p.id = pc.id_produto
and c.id = pc.id_caracteristica;

--03

select l.nome, l.cidade, e.quantidade_disponivel
from loja AS l
inner join estoque as e
on l.id = e.id_loja;

--04

select p.nome, p.descricao
from produto AS p
inner join estoque as e
on p.id = e.id_produto;
where e.quantidade_disponivel > '10';

--05 nao funciona

select p.nome, e.quantidade_disponivel, l.cidade
from produto AS p
inner join estoque as e
inner join loja as l
on p.id = e.id_produto and l.id = e.id_loja
where l.cidade like 'Salvador';


--06

select p.nome, p.descricao, c.nome
from produto AS p
inner join caracteristica as c
inner join produto_caracteristica as pc
on p.id = pc.id_produto and c.id = pc.id_caracteristica
where c.nome like 'Tela HD';

--07

select p.nome, p.tipo, p.preco
from produto AS p
inner join estoque as e
on p.id = e.id_produto
where p.preco > '1000' and e.quantidade_disponivel > 0;


















