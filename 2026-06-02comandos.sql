--- aula 02/06/2026
--TRIGGERS

--01 Validação de Estoque Negativo: Crie uma trigger BEFORE UPDATE na tabela Estoque que impeça
-- a atualização se quantidade_disponivel for menor que 0. Lance uma exceção clara com SIGNAL.

delimiter //
create trigger trg_deny_update_bellow_zero
before update on Estoque
for each row 
BEGIN
	if new.quantidade_disponivel < 0 THEN
	signal sqlstate '45000'
	set message_text = 'A quantidade disponivel não pode ser menor que 0!!!';
end if;
end//
delimiter ;

--02 Preenchimento Automático de Data: Crie uma trigger BEFORE INSERT na tabela Produto que,
-- caso data_lancamento seja NULL na inserção, preencha automaticamente com a data atual do
-- sistema (CURDATE()).

delimiter //
create trigger trg_update_current_date
before insert on produto 
for each row 
BEGIN 
	if new.data_lancamento is null THEN
	set new.data_lancamento = curdate();
end if;
end//
delimiter ;

--03 . Alerta de Estoque Baixo: Crie uma tabela alertas_estoque e uma trigger AFTER UPDATE na tabela
-- Estoque que registre um alerta sempre que a quantidade disponível cair abaixo de 5 unidades,
-- mas apenas se antes estava em 5 ou mais.

create table alerta_estoque (
	id int auto_increment primary key,
	id_produto INT not null,
	id_loja INT,
	quantidade_disponivel INT,	
	data_alerta TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	);

delimiter //
create trigger trg_alerta_estoque_baixo
after update on Estoque
for each row
begin 
	if old.quantidade_disponivel >= 5 AND new.quantidade_disponivel < 5 THEN
	insert into alerta_estoque (id_produto, id_loja, quantidade_disponivel)
	values (new.id_produto,  new.id_loja, new.quantidade_disponivel);
end if ;
end//
delimiter ;

--04 Bloqueio de Tipo Incompatível: Crie uma trigger BEFORE INSERT ou UPDATE na tabela Produto
--que impeça a inserção/atualização se tipo for 'Novo' e desconto_usados for maior que 0. Lance
-- erro via SIGNAL.

delimiter //
create trigger trg_tipo_incompativel_insert
before insert on produto
for each row 
begin 
	if new.tipo = 'Novo' and new.desconto_usados > 0 then 
	signal sqlstate '45000'
	set message_text = 'Produto novo nao pode ter desconto de usado!!!';
end if ;
end//
delimiter ;

delimiter //
create trigger trg_tipo_incompativel_update
before update on produto
for each row 
begin 
	if new.tipo = 'Novo' and new.desconto_usados > 0 then 
	signal sqlstate '45000'
	set message_text = 'Produto novo nao pode ter desconto de usado!!!';
end if ;
end//
delimiter ;
	
--5 Log de Características Associadas: Crie uma tabela log_caracteristicas e uma trigger AFTER
-- INSERT na tabela Produto_Caracteristica que registre o id_produto, id_caracteristica, valor e a
-- data/hora da associação	

create table log_caracteristicas (
	id int auto_increment primary key,
	id_produto int,
	id_caracteristica int,
	valor varchar(100),
	data_assoc TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

delimiter //
create trigger trg_log_caracteristica
after insert on Produto_Caracteristica
for each row
begin
	insert into log_caracteristicas (id_produto, id_caracteristica, valor)
	values (new.id_produto,  new.id_caracteristica, new.valor);
end//
delimiter ;
	
--Transação

--1 Cadastro de Loja + Estoque Inicial: Crie uma transação que insira uma nova loja na tabela Loja e,
-- imediatamente, registre 2 itens de estoque inicial para essa loja. 
--Se qualquer INSERT falhar, reverta tudo

START TRANSACTION;

--set @erro = 0;

insert into loja (nome, telefone, rua, numero, bairro, cep, complemento, cidade) VALUES
('Amazon(as)', '123-456-7890', 'Rua 2', 12345, 'Bairro Z', '12345-679', 'Complemento B', 'Guaramirim');

SET @novo_id = LAST_INSERT_ID();

insert into estoque (id_produto, id_loja, id_caracteristica, valor) values
(1, @novo_id, 1, 1);
--if row_count() = 0 then 
--	set @erro = 1;
--end if;
insert into estoque (id_produto, id_loja, id_caracteristica, valor) values
(2, @novo_id, 2, 5);
--if row_count() = 0 then 
--	set @erro = 1;
--end if;

--if @erro = 1 then
--	ROLLBACK
--	select 'Transacao revertida';
--else
--	commit;
--	select 'Transação confirmada';
--end if;

commit;



	
-- 2  Reajuste de Preços em Lote: Crie uma transação que aumente em 10% o preço de todos os produtos da
-- categoria 'Eletronico'. Antes de confirmar, verifique se algum produto ficou com preco > 5000.00. Se sim,
-- execute ROLLBACK. Caso contrário, COMMIT.

SET SQL_SAFE_UPDATES = 0;
START TRANSACTION;

update produto set preco = preco + (preco * 0.10)
where categoria like 'Eletronico%';

select count(*) from produto where preco > 5000 and categoria like 'Eletronico%';

commit;
SET SQL_SAFE_UPDATES = 1;








	
