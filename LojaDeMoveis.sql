-- Tabelas e dados inseridos
create table vendedor (
 CodVdd integer primary key,
 CPF numeric(11) not null unique,
 V_comissao numeric(4,2),
 Nome varchar(50) not null,
 Endereço varchar(100)
);
 
insert into vendedor (CodVdd, CPF, V_comissao, Nome, Endereço) values
(1, 12345678901, 5.50, 'Gato Amora', 'Rua das Flores, 123 - Centro'),
(2, 98765432109, 6.00, 'Pepi', 'Av. Canarinho, 456 - Jardim'),
(3, 45678912345, 4.75, 'Pink', 'Rua Feliz, 789');
 
create table cliente (
 CodCli integer primary key,
 Nome varchar(50) not null,
 Tel char(10) not null,
 CPF numeric(11) not null unique,
 Email varchar(50)
);

insert into cliente (CodCli, Nome, Tel, CPF, Email) values
(101, 'Julia', '4198765432', 11122233344, 'julinhaa@email.com'),
(102, 'Thor', '1191234567', 55566677788, 'trovaoo@email.com'),
(103, 'Mel', '2196543210', 99988877766, 'mel.l@email.com'),
(104, 'Felipo', '3199876543', 44433322211, 'opilef@email.com');

create table motorista (
 CodMot integer primary key,
 CPF numeric(11) not null unique,
 CNH numeric(10) not null unique,
 Nome varchar(50) not null,
 Endereço varchar(100)
);

INSERT INTO motorista (CodMot, CPF, CNH, Nome, Endereço) VALUES
(501, 22233344455, 1234567890, 'Ramon', 'Rua das Flores, 321'),
(502, 77788899900, 9876543210, 'Nando', 'Av. Otacilio, 1000'),
(503, 33344455566, 5554443332, 'Luca', 'Rua do Bolo, 45');

create table venda (
 NumVen integer primary key,
 Valor_Total numeric(11,2) not null,
 CodVdd integer,
 CodCli integer,
 foreign key(CodVdd) references vendedor(CodVdd),
 foreign key(CodCli) references cliente(CodCli)
);

insert into venda (NumVen, Valor_Total, CodVdd, CodCli) values
(5001, 1029.80, 1, 101),
(5002, 2999.90, 2, 102),
(5003, 3999.80, 1, 103),
(5004, 129.90, 3, 104);

create table produto (
 CodPro integer primary key,
 Custo numeric(11,2) not null,
 Descricao text,
 Preco numeric(11,2) not null,
 Nome varchar(50) not null
);
insert into produto (CodPro, Custo, Descricao, Preco, Nome) values
(1001, 5000.00, 'Sofá super confortavel rosa da Barbie', 8999.90, 'Sofá da Barbie'),
(1002, 100.00, 'Batedeira planetaria: mistura e solva com eficiencie ', 299.90, 'Batedeira Perfeita'),
(1003, 15.00, 'Cortina rosa com estampa de corações', 129.90, 'Cortina Fofa'),
(1004, 8000.00, 'Geladeira inteligente com 2 duas portas e computador imbutido', 19990.90, 'Geladeira'),
(1005, 25.00, 'Almofada decorativa em formato de gato', 79.90, 'Almofada de gatinho');

create table item_venda (
 CodPro integer,
 NumVen integer,
 vUnitario numeric (11,2),
 Qtd integer,
primary key(CodPro, NumVen),
 foreign key(CodPro) references produto(CodPro),
 foreign key(NumVen) references venda(NumVen)
);

insert into item_venda (CodPro, NumVen, vUnitario, Qtd) values
(1001, 5001, 8999.90, 2),
(1003, 5001, 299.90, 5),
(1002, 5002, 129.90, 1),
(1001, 5003, 8999.90, 2),
(1004, 5003, 19999.90, 1),
(1003, 5004, 129.90, 1);

create table veiculo (
 placa char(7) primary key,
 Capacidade integer
);
INSERT INTO veiculo (placa, Capacidade) VALUES
('SKZ1234', 500),
('BTS5678', 1000),
('GOT0007', 750);

create table entrega (
 Hora time not null,
 Data date not null,
 NumVen integer,
 Placa char(7),
 CodCli integer,
 CodMot integer,
 primary key(Hora, Data),
 foreign key(NumVen) references venda(NumVen),
 foreign key(Placa) references veiculo(placa),
 foreign key(CodMot) references motorista(CodMot)
);

insert into entrega (Hora, Data, NumVen, Placa, CodCli, CodMot) values
('14:30:00', '2023-05-10', 5001, 'SKZ1234', 101, 501),
('09:15:00', '2023-05-11', 5002, 'BTS5678', 102, 502),
('16:45:00', '2023-05-12', 5003, 'GOT0007', 103, 501),
('11:00:00', '2023-05-13', 5004, 'SKZ1234', 104, 501);

-- Consultas gerais
select * from vendedor;
select * from cliente;
select * from motorista;
select * from venda;
select * from produto;
select * from item_venda;
select * from entrega;

-- Consultas utilizando as variações do comando JOIN
-- Vendas e seus respectivos vendedores e clientes
select v.NumVen, v.Valor_Total, 
       vd.Nome as vendedor, 
       c.Nome as cliente
from venda v
 join vendedor vd on v.CodVdd = vd.CodVdd
 join cliente c on v.CodCli = c.CodCli;
 
-- Motoristas e entregas realizadas
select m.Nome as motorista, 
       COUNT(e.NumVen) as total_de_entregas
from entrega e
right join motorista m on e.CodMot = m.CodMot
group by m.Nome;

-- Produtos e vendas
select p.Nome as produto,
       p.Preco as preco,
       iv.Qtd as quantidade_vendida,
       v.NumVen as numero_venda,
       v.Valor_Total
from produto p
left join item_venda iv on p.CodPro = iv.CodPro
left join venda v on iv.NumVen = v.NumVen
order by p.Preco desc;
