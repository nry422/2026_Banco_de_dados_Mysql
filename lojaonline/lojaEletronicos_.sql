-- Criação da tabela 'Caracteristica'
CREATE TABLE Caracteristica (
    id INT(4) AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT
);

-- Criação da tabela 'Produto'
CREATE TABLE Produto (
    id INT(4) AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    tipo ENUM('Novo', 'Usado', 'Promocao', 'Liquidacao', 'Outros') NOT NULL,
    categoria SET('Eletronico', 'Telefonia', 'Informatica', 'Eletrodomesticos', 'Acessorios', 'Outros') NOT NULL,
    data_lancamento DATE,
    desconto_usados DECIMAL(10, 2)
);

-- Criação da tabela de associação 'Produto_Caracteristica'
CREATE TABLE Produto_Caracteristica (
	id INT(4) AUTO_INCREMENT PRIMARY KEY,
    id_produto INT(4),
    id_caracteristica INT(4),
    valor VARCHAR(255),
    FOREIGN KEY (id_produto) REFERENCES Produto(id),
    FOREIGN KEY (id_caracteristica) REFERENCES Caracteristica(id)
);

-- Criação da tabela 'Loja'
CREATE TABLE Loja (
    id INT(4) AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
	telefone VARCHAR(15),
    rua varchar(45),
    numero int(5),
    bairro varchar(45),
    cep varchar(45),
    complemento varchar(45),
    cidade varchar(45)   
);

-- Criação da tabela de associação 'Estoque'
CREATE TABLE Estoque (
    id INT(4) AUTO_INCREMENT PRIMARY KEY,
	id_produto INT(4),
    id_loja INT(4),
    quantidade_disponivel INT(6) NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES Produto(id),
    FOREIGN KEY (id_loja) REFERENCES Loja(id)
);

-- --------------------------------------------------------------------------------
-- POPULAÇÃO DO BANCO

INSERT INTO Produto 
(id, nome, descricao, preco, tipo, categoria, data_lancamento, desconto_usados) VALUES 
(1, "Smartphone XYZ", "Um smartphone de ultima geracao com câmera de alta resolucao.", 999.99, "Usado", "Eletronico", "2023-01-01", 0.00),
(2, 'Camera DSLR 123', 'Camera com fotografia profissional.', 1299.99, 'Novo', 'Eletronico', '1999-09-29', 0.00),
(3, 'Notebook Pro', 'Um poderoso notebook ultrafino.', 1799.99, 'Novo', 'Informatica', '1998-04-10', 0.00),
(4, 'Smartphone Premium', 'Smartphone de alta qualidade.', 999.99, 'Usado', 'Telefonia', '2023-05-19', 10.00),
(5, 'Impressora Laser X1000', 'Uma impressora laser rapida e de alta qualidade.', 399.99, 'Liquidacao', 'Informatica', '2023-03-19', 0.00),
(6, 'Fone de Ouvido Bluetooth Pro', 'Fones de ouvido sem fio com cancelamento de ruido.', 149.99, 'Usado', 'Telefonia', '2023-08-23', 50.00),
(7, 'TV LED 4K 55 polegadas', 'Uma televisao LED de alta resolucao para entretenimento em casa.', 799.99, 'Novo', 'Eletronico', '2023-09-19', 0.00),
(8, 'Mouse sem Fio Ergonomico', 'Um mouse sem fio confortavel para uso diario.', 29.99, 'Promocao', 'Informática', '2020-09-19', 20.00),
(9, 'Caixa de Som Bluetooth Portatil', 'Uma caixa de som portatil com conexão Bluetooth.', 59.99, 'Novo', 'Eletronico', '2020-03-10', 15.00),
(10, 'Cafeteira Eletrica 1.5L', 'Uma cafeteira eletrica para preparar cafe fresco.', 49.99, 'Promocao', 'Eletrodomesticos', '2023-09-12', 0.00),
(11, 'Roteador Wi-Fi Dual Band', 'Um roteador com tecnologia Dual Band para conexoes de alta velocidade.', 79.99, 'Novo', 'Informatica', '2023-09-19', 5.00);


INSERT INTO Caracteristica
(id, nome, descricao) VALUES
(1, 'Sistema Operacional', 'Android 12'),
(2, 'Tela', '6.5 polegadas AMOLED'),
(3, 'Bluetooth', 'Recursos de conectividade Bluetooth.'),
(4, 'Tela HD', 'Tela de alta definição para qualidade de imagem superior.'),
(5, 'Bateria de Longa Duracao', 'Bateria com longa autonomia para uso prolongado.'),
(6, 'Camera de 48MP', 'Câmera com resolução de 48 megapixels para fotos detalhadas.'),
(7, 'Armazenamento SSD', 'Armazenamento em estado solido para alta velocidade de acesso.'),
(8, 'À Prova de agua', 'Proteção contra água e umidade.'),
(9, 'Tela Touchscreen', 'Tela sensivel ao toque para interação intuitiva.'),
(10, 'Processador de Alto Desempenho', 'Processador potente para tarefas exigentes.'),
(11, 'Design Compacto', 'Design compacto e portatil.'),
(12, 'Sistema Operacional Android', 'Sistema operacional Android para flexibilidade e aplicativos.');

INSERT INTO Produto_Caracteristica
(id, id_produto, id_caracteristica) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 5),
(4, 2, 5),
(5, 3, 5),
(6, 4, 5),
(7, 5, 3),
(8, 6, 3),
(9, 7, 4),
(10, 8, 8),
(11, 9, 3),
(12, 10, 11),
(13, 11, 11),
(14, 1, 6),
(15, 3, 7),
(16, 4, 9),
(17, 3, 10),
(18, 4, 12);

INSERT INTO Loja 
(nome, telefone, rua, numero, bairro, cep, complemento, cidade) VALUES
('Amazon(as)', '123-456-7890', 'Rua 1', 123, 'Bairro A', '12345-678', 'Complemento A', 'Jaragua do Sul'),
('Amazon(as)', '987-654-3210', 'Rua 2', 456, 'Bairro B', '56789-012', 'Complemento B', 'Sao Paulo'),
('Amazon(as)', '555-555-5555', 'Rua 3', 789, 'Bairro C', '99999-999', 'Complemento C', 'Rio de Janeiro'),
('Amazon(as)', '111-222-3333', 'Rua 4', 101, 'Bairro D', '11111-222', 'Complemento D', 'Salvador');

INSERT INTO Estoque (id_produto, id_loja, quantidade_disponivel) VALUES
(1, 1, 0),
(1, 2, 1),
(1, 3, 25),
(1, 4, 10),
(2, 1, 5),
(3, 4, 10),
(4, 1, 20),
(5, 2, 0),
(6, 2, 10),
(7, 3, 5),
(8, 4, 2),
(8, 3, 5),
(9, 3, 0),
(9, 4, 6),
(10, 1, 8),
(10, 2, 1),
(10, 3, 2),
(11, 2, 10),
(11, 3, 3);
