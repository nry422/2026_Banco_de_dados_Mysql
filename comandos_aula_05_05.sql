comandos aula 05-05

select nome, tipo
where categoria like "Eletro%";


select nome, tipo
from produto
where preco > 1000;


select nome, categoria, data_lancamento
from produto
where year(data_lancamento) = 2023;


select nome, descricao
from produto where descricao like "Smartphone%";


select nome, categoria
from produto where categoria like "eletronico%" or categoria like "telefonia%";












