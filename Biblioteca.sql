create table alunos (
    id_aluno INT primary key,
    nome VARCHAR(100),
    curso VARCHAR(100)
);
 insert into alunos (id_aluno, nome, curso) values 
 (4002, 'Amora', 'Informática'),
 (4003, 'Pepi', 'Música'),
 (4004, 'Leticia', 'Informática'),
 (4005, 'Mel', 'Edificações'),
 (4006, 'Lua', 'Informática'),
 (4007, 'Noemy', 'Edificações');
 

create table livros (
    id_livros INT primary key,
    titulo VARCHAR(150),
    autor VARCHAR(100),
    categoria VARCHAR(50)
);

insert into livros (id_livros, titulo, autor, categoria) values
(123, 'Mulherzinhas', 'Louisa May Alcott', 'Romance'),
(456, 'Menino de Engenho', 'José Lins do Rego', 'Romance modernista/ Literatura brasileira'),
(334, 'Filoteia', 'São  Francisco de Sales', 'Literatura Cristã'),
(890, 'Comer, rezar, amar', 'Elizabeth Gilbert', 'Comédia dramática'),
(578, 'A hora da estrela', 'Clarice Lispector', 'Romace'),
(709, 'Jantar secreto', 'Raphael Montes', 'Ficção');


create table emprestimos (
    id INT primary key,
    aluno_id INT,
    livro_id INT,
    data_emprestimo DATE,
    data_devolucao DATE,
    foreign key (aluno_id) references alunos(id_aluno),
    foreign key (livro_id) REFERENCES livros(id_livros)
);

insert into emprestimos (id, aluno_id, livro_id, data_emprestimo, data_devolucao) values 
(1, 4002, 578, '2025-06-25', '2025-07-08'),
(2, 4007, 709, '2025-05-04', null),
(3, 4005, 123, '2025-07-03', '2025-07-18'),
(4, 4006, 578, '2025-06-01', '2025-06-16'),
(5, 4004, 890, '2025-04-02', null),
(6, 4002, 123, '2025-08-03', '2025-08-18'),
(7, 4007, 123, '2025-07-03', '2025-07-18'),
(8, 4002, 709, '2025-05-04', null);

-- consultas gerais
select * from alunos;
select * from livros;
select * from emprestimos;

-- alunos e a quantidade total de livros que cada um pegou emprestado.
select a.nome as alunos,
       count(e.id) as livros_emprestados
       from alunos a
       left join emprestimos e on a.id_aluno = e.aluno_id
       group by a.nome
       order by livros_emprestados desc;

-- livros mais emprestados

