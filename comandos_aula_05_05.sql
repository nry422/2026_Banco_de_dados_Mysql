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













