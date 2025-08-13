create table ambulatorio (
 nroa int primary key,
 andar int not null,
 capacidade int not null
);

insert into ambulatorio(nroa, andar, capacidade) values
(1, 1, 30),
(2, 1, 30),
(3, 1, 30),
(4, 2, 40),
(5, 2, 40),
(6, 2, 40);

create table medicos (
 codm int primary key,
 CPF numeric(11) not null unique,
 nome varchar(50) not null,
 idade int not null,
 cidade varchar(30),
 especialidade varchar(30) not null,
 nroa int,
 foreign key(nroa) references ambulatorio(nroa)
);

insert into medicos(codm, CPF, nome, idade, cidade, especialidade, nroa) values
(1, 13456728913, 'Amora', 33, 'João Pessoa', 'cirurgião geral', 6),
(2, 78905436129, 'Pepi', 49, 'Areia', 'neurocirurgião', 4),
(3, 67543988098, 'Lua', 37, 'Bananeiras', 'pediatria', 3),
(4, 89009754442, 'Binho', 56, 'Aracajú', 'ortopedista', 5),
(5, 54278901887, 'Linda', 46, 'Boa viagem', 'cardiologista', 1),
(6, 78859042322, 'Irís', 28, 'São Paulo', 'dermatologista', 2);

 
create table pacientes (
 codp int primary key,
 CPF numeric(11) not null unique,
 nome varchar(50) not null,
 idade int not null,
 cidade varchar(30),
 doenca varchar(30) not null
);

insert into pacientes(codp, CPF, nome, idade, cidade, doenca) values
(001, 54367315237, 'Lulu', 12, 'Guarabira', 'virose'),
(002, 62781812990, 'Paulo', 20, 'Guarabira', 'acne'),
(003, 89910383764, 'Julieta', 34, 'Mari', 'cardiopatia'),
(004, 56378991001, 'Carlos', 45, 'Araçagi', 'hipertensão');

create table consultas (
 codm int,
 codp int,
 data date,
 hora time,
 foreign key(codm) references medicos(codm),
 foreign key(codp) references pacientes(codp)
);

insert into consultas(codm, codp, data, hora) values
(3, 001, '2025-06-12', '16:30'),
(6, 002, '2025-06-14', '13:40'),
(5, 003, '2025-07-23', '09:15'),
(5, 004, '2025-07-20', '08:30');

-- consultas gerais
select * from ambulatorio;
select * from medicos;
select * from pacientes;

-- consultas especicificas
--consulta que apresenta o nome do médico, nome do paciente e a hora da consulta
create view medico_paciente_hconsulta as 
select m.nome as medico,
       p.nome as paciente,
       c.hora as horario
from consultas c 
join medicos m on c.codm = m.codm
join pacientes p on c.codp = p.codp;

-- hora da consulta, o andar do ambulatódrio e o código do médico
create view informacoes_consulta as
select c.hora as horario,
       a.andar as andar_ambulatorio,
       m.codm as cod_medico
from consultas c
join medicos m on c.codm = m.codm
join ambulatorio a on m.nroa = a.nroa;

-- nomes dos médicos, data e hora da consulta
create view medicos_dataEhoraConsulta as
select m.nome as medico,
       c.data, 
       c.hora as horario
from medicos m 
left join consultas c on m.codm = c.codm;

-- mostra a idade dos pacientes, doença, nome dos médicos e o código dos ambulatódrios
create view informacoes_paciente as
select p.idade as idade_paciente,
       p.doenca as doenca_paciente,
       m.nome as nome_medico,
       a.nroa as codigo_ambulatorio
from pacientes p
join consultas c on p.codp = c.codp
join medicos m on c.codm = m.codm
join ambulatorio a on m.nroa = a.nroa;

-- consulta das views
select * from medico_paciente_hconsulta; 
select * from informacoes_consulta;
select * from medicos_dataEhoraConsulta;
select * from informacoes_paciente;
