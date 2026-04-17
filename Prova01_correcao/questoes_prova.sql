--Questoes Prova
--Questao 3

CREATE DATABASE cinefun;

USE cinefun;

--Questao 4

CREATE TABLE Sala(
	id INT PRIMARY KEY AUTO_INCREMENT,
	tam_tela_pol DECIMAL(8,2),
	area_m DECIMAL(8, 2),
	status ENUM('disponivel', 'limpeza', 'manutenção'),
	capacidade INT 
);

CREATE TABLE Filme(
	id INT PRIMARY KEY AUTO_INCREMENT,
	titulo VARCHAR(45) NOT NULL,
	classificacao VARCHAR(45),
	duracao INT
);

CREATE TABLE Sessoes(
	id INT PRIMARY KEY AUTO_INCREMENT,
	data DATE,
	hora TIME,
	preco DECIMAL(8,2),
	sala INT,
	filme INT,
	FOREIGN KEY (sala) REFERENCES Sala(id),
	FOREIGN KEY (filme) REFERENCES Filme(id)

);

CREATE TABLE Clientes(
	cpf VARCHAR(30) PRIMARY KEY,
	nome_completo VARCHAR(200) NOT NULL,
	telefone VARCHAR(45)
);

--Questao 5 comandos DDL

ALTER TABLE Clientes 
ADD COLUMN data_nascimento DATE
DEFAULT "2026-04-14"

--DML Questão 6

INSERT INTO Sala(id, tam_tela_pol, area_m, status, capacidade) VALUES
(NULL, 600, 50.5, "disponivel", 150),
(NULL, 900, 100, "limpeza", 500);

INSERT INTO Filme VALUES
(NULL, "Avatar I", "Maiores de 12 anos", 120),
(NULL, "Crepusculo", "Maiores de 16 anos", 90);

--Questao 7
INSERT INTO Sessoes VALUES
(NULL, '2026-04-14', '19:00', 25.80, 1, 1);

--Questao 8

UPDATE Clientes SET telefone = "+55 (47) 98866-8866"
WHERE cpf = "000.098.098-87";

--Questao 9

DELETE FROM Filme WHERE id = 10;

--Questão 10
--DCL

CREATE USER 'user_ext'@'localhost' IDENTIFIED BY 'senha0101';

--Questao 11

GRANT SELECT, INSERT ON Cinefun.* TO 'user_ext'@'localhost';

--- questões adicionais

create table Funcionario(
	matricula INT PRIMARY KEY,
    nome_completo VARCHAR(200),
    cargo VARCHAR(45)
);

create table Ingressos(
	codigo INT PRIMARY KEY,
    tipo ENUM('Inteira', 'Meia'),
    hora_compra TIME,
    valor DECIMAL(8,2),
    assento VARCHAR(45),
    sessao INT,
    cliente VARCHAR(45),
    funcionario INT,
    FOREIGN KEY (sessao) REFERENCES Sessoes(id),
    foreign key (cliente) references Clientes(cpf),
    foreign key (funcionario) references funcionario(matricula)
	
);
-- inserir dados
insert into Funcionario(matricula, nome_completo, cargo)
values (123, 'Fulano Ciclano', 'Demitido'),
(321, 'Ciclano Fulanus', 'Caixa');


insert into Ingressos
values (25, 'Meia', '09:00', 25.80, 2, 1, '000.098.098-87', 321);

insert into clientes
values ('000.098.098-88', 'Falano', '33721700', '2026-01-01');

-- criar usuarios
create user 'caixa'@'localhost' identified by 'senha123';
create user 'gerente'@'localhost' identified by 'senha123';
create user 'analistamarketing'@'localhost' identified by 'senha123';
create user 'auditorexterno'@'localhost' identified by 'senha123';
create user 'funcionariodemitido'@'localhost' identified by 'senha123';

-- mostrar grants
show grants for 'caixa'@'localhost';

SELECT user, host FROM mysql.user;

GRANT SELECT, INSERT ON Cinefun.* TO 'funcionariodemitido'@'localhost';

-- revoke all priviledges só funciona se tiver dado all privileges, nesse caso eu deveria usar revoke para select e insert manualmente para funcionar;
revoke all privileges on cinefun.* from 'funcionariodemitido'@'localhost';


--todos os privilegios para gerente
GRANT all privileges on Cinefun.* TO 'gerente'@'localhost';

-- select pode acessar o banco de dados, insert pode editar..
GRANT select on Cinefun.* TO 'analistademarketing';

GRANT select on Cinefun.* TO 'auditorexterno'@'localhost';

GRANT select on Cinefun.sessoes TO 'caixa'@'localhost';

GRANT insert on Cinefun.ingressos TO 'caixa'@'localhost';












