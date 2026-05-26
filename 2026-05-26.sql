--Aula 26/05/2026

--Questão Crie uma função chamada "soma_numeros" que receba dois números como argumentos e
-- retorne a soma desses dois números.

DELIMITER //
CREATE FUNCTION soma_numeros(num1 INT, num2 INT)
RETURNS INT
BEGIN
	DECLARE resultado INT;
	SET resultado = num1 + num2;
	RETURN resultado;
END //
DELIMITER;

SELECT soma_numeros(10, 20);

show function status

drop function ...

--questão Crie uma função que retorna o preço final de um produto com base no desconto aplicado.
--Receber dois argumentos: preco e desconto. Retorna o preço final do produto após a aplicação do
--desconto especificado.

DELIMITER //
create function preco_final(preco decimal(8,2),desconto decimal(8,2))
returns decimal(8,2)
BEGIN
	declare resultado decimal(8,2);
	set resultado = preco - preco * desconto;
	return resultado;
end //
delimiter ;

select preco_final(100, 0.1)

--questão Crie uma função calcula_imposto que recebe um argumento salario e retorna um valor imposto
-- calculado com base na taxa de imposto correspondente ao salário.
-- - Para salários menores que R$2.000,00 deve cobrar 10% de imposto
-- - Para salários maiores ou iguais a R$2.000,00 deve cobrar 20% de imposto

delimiter //
create function calcula_imposto(salario decimal(8,2))
returns decimal(8,2)
BEGIN
	declare resultado decimal(8,2);
	set resultado = if (salario< 2000, (salario * 0.10), (salario * 0.20));
	return resultado;
end //
delimiter ;

select calcula_imposto(1000)

//ou

CREATE FUNCTION calcula_imposto(salario DECIMAL(10,2))
RETURNS DECIMAL(10,2)
BEGIN
 DECLARE imposto DECIMAL(10,2);
 IF salario < 2000 THEN
 SET imposto = salario * 0.1;
 ELSE
 SET imposto = salario * 0.2;
 END IF;
 RETURN imposto;
END //

--exercicio Crie uma função chamada media_notas que receba três notas como argumentos. Retorne
-- Aprovado se a média for maior ou igual a 6.0 e Reprovado se a média for menor que 6.0

CREATE FUNCTION media_notas(nota1 DECIMAL(4,2), nota2 DECIMAL(4,2), nota3
DECIMAL(4,2))
RETURNS DECIMAL(4,2)
BEGIN
 DECLARE media DECIMAL(4,2);
 SET media = (nota1 + nota2 + nota3) / 3;
 RETURN media;
END;
SELECT media_notas(7.5, 8.2, 6.9);

--exercicio Crie uma função que retorna o número de dias entre duas datas. Receber dois argumentos:
-- data_inicio e data_fim. Retornar o número de dias entre as duas datas especificadas.

CREATE FUNCTION calcula_dias_entre_datas(data_inicio DATE, data_fim DATE)
RETURNS INT
BEGIN
 DECLARE dias INT;
 SET dias = DATEDIFF(data_fim, data_inicio);
 RETURN dias;
END;

--exercicio Crie uma função que retorna a idade com base na data de nascimento. Receber um argumento
-- data_nascimento e retornar a idade calculada com base na data atual.

CREATE FUNCTION calcula_idade(data_nascimento DATE)
RETURNS INT
BEGIN
 DECLARE idade INT;
 SET idade = TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE());
 RETURN idade;
END;

--exercicio Crie uma função chamada calcula_imc que receba o peso (em kg) e a altura (em metros) de
--uma pessoa como argumentos e retorne o índice de massa corporal (IMC) dessa pessoa. O
--IMC é calculado dividindo o peso pela altura ao quadrado.

CREATE FUNCTION calcula_imc(peso DECIMAL(5,2), altura DECIMAL(5,2))
RETURNS DECIMAL(5,2)
BEGIN
 DECLARE imc DECIMAL(5,2);
 SET imc = peso / (altura * altura);
 RETURN imc;
END;
SELECT calcula_imc(75, 1.75); 

--exercicio Crie uma função chamada "maior_valor" que receba três valores como argumentos e
-- retorne o maior valor entre eles.

CREATE FUNCTION maior_valor(valor1 INT, valor2 INT, valor3 INT)
RETURNS INT
BEGIN
 DECLARE maior INT;
 IF valor1 >= valor2 AND valor1 >= valor3 THEN
 SET maior = valor1;
 ELSEIF valor2 >= valor1 AND valor2 >= valor3 THEN
 SET maior = valor2;
 ELSE
 SET maior = valor3;
 END IF;
 RETURN maior;
END; 

SELECT maior_valor(10, 20, 15); 
SELECT maior_valor(5, 8, 3); 
SELECT maior_valor(100, 80, 120);

--exercicio Calcule o fatorial de um número inteiro positivo dado, multiplicando todos os inteiros de 1
-- até o número dado

CREATE PROCEDURE CalculateFactorial(IN num INT, OUT result BIGINT)
BEGIN
 DECLARE counter INT DEFAULT 1;
 DECLARE factorial BIGINT DEFAULT 1;
 WHILE counter <= num DO
 SET factorial = factorial * counter;
 SET counter = counter + 1;
 END WHILE;
 SET result = factorial;
END //

--exercicio 01 -Crie uma função chamada CalculaDesconto que recebe o preço de um produto e o desconto a ser aplicado e
-- retorna o preço com desconto. Em seguida, use essa função para calcular o preço com desconto de todos os
-- produtos que têm desconto (desconto_usados > 0) e liste o nome do produto e o preço original e com desconto.

DELIMITER //
create function calculaDesconto(preco decimal(8,2),desconto decimal(8,2))
returns decimal(8,2)
BEGIN
	declare resultado decimal(8,2);
	set resultado = preco - preco * (desconto / 100) ;
	return resultado;
end //
delimiter ;

select p.nome, p.preco as preco_original, CalculaDesconto(p.preco, p.desconto_usados) as preco_com_desconto
from produto as p
WHERE p.desconto_usados > 0;


--exercicio 02 Crie uma função chamada ConverteData que recebe uma data no formato 'YYYY-MM-DD' como date e retorna a
-- data no formato 'DD/MM/YYYY' como date. Em seguida, use essa função para listar o nome do produto e a data
-- de lançamento formatada no formato 'DD/MM/YYYY' para todos os produtos.

delimiter //
create function ConverteData(data DATE)
returns VARCHAR(10)
BEGIN
	DECLARE novadata VARCHAR(10);
	set novadata = DATE_FORMAT(DATA, "%d/%m/%Y");
	return novadata; 
	
end //
delimiter ; 

select nome, data_lancamento, ConverteData(data_lancamento) as "Nova Data"
from produto;


--exercicio 03 Crie uma função chamada CalculaMediaEstoque que recebe o ID de um produto e retorna a média da quantidade
-- disponível desse produto em todas as lojas. Em seguida, liste o nome de todos os produtos e a média da
-- quantidade disponível para cada um

delimiter //
create function CalculaMediaEstoque(produto int)
returns decimal(8,2)
BEGIN
	declare x decimal(8,2);
	select avg(quantidade_disponivel) INTO x 
	from estoque
	where id_produto = produto;	
	return x;	
end //
delimiter ;

select nome, CalculaMediaEstoque(id) as "media qtd disponivel"
from produto;




--conteudo prova
--inner join select, select com like, select com where, order by, agrupamento, funcoes embutidas, funcoes dos usuarios, gatilhos


--exercicio 04 Crie uma função chamada ContaCaracteristicas que recebe o ID de um produto e retorna o número de
-- características associadas a esse produto. Em seguida, liste o nome de todos os produtos e o número de
-- características para cada um.

delimiter //
create function ContaCaracteristicas(produto int)
returns INT
BEGIN
	declare n int;
	select count(*) into n
	from produto_caracteristica
	where id_produto = produto;
	return n;	
end //
delimiter ;

select nome, ContaCaracteristicas(id) as "N. características"
from produto;