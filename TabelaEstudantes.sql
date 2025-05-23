CREATE TABLE Estudantes (
    id INT PRIMARY KEY,
    nome VARCHAR(50),
    curso VARCHAR(30),
    idade INT,
    nota DECIMAL(3,1),
    cidade VARCHAR(30)
);

INSERT INTO Estudantes VALUES 
(1, 'Amora', 'Moda', 24, 10.0, 'Pilõezinhos'),
(2, 'Suga', 'Engenharia aeroespacial', 33, 9.9, 'Cuitegi'), 
(3, 'Mayllon', 'Educação física', 25, 10.0, 'Sapé'),
(4, 'Pink', 'Moda', 29, 9.5, 'Sapé'),
(5, 'Mellyna', 'Moda', 4, 9.3, 'Souza'),
(6, 'Dolly', 'Moda', 31, 9.5, 'Souza'),
(7, 'Lua', 'Moda', 5, 8.0, 'Pilõezinhos'),
(8, 'Mel', 'Moda', 27, 6.0, 'Cuitegi'),
(9, 'Aninha', 'Educação Física', 23, 10.0, 'João Pessoa'),
(10, 'Pepi', 'Engenharia aeroespacial', 25, 7.0, 'Pilõezinhos'),
(11, 'Bartolomeu', 'Fisica', 25, 8.0, 'João Pessoa'),
(12, 'Aurora', 'Quimica', 19, 9.0, 'Campina Grande');

-- Consultas
SELECT * FROM Estudantes WHERE nome LIKE 'A%';
SELECT * FROM Estudantes ORDER BY nota DESC;
SELECT AVG(nota) AS media, MIN(nota) AS menor_nota, MAX(nota) AS maior_nota FROM Estudantes;
SELECT COUNT(*) AS total_estudantes FROM Estudantes;
SELECT curso, COUNT(*) AS quantidade FROM Estudantes GROUP BY curso;
SELECT SUM(idade) AS soma_idades FROM Estudantes;
SELECT curso, COUNT(*) AS quantidade FROM Estudantes GROUP BY curso HAVING COUNT(*) > 5;
SELECT curso, AVG(nota) AS media_notas
FROM Estudantes WHERE cidade LIKE 'S%' GROUP BY curso HAVING AVG(nota) > 7;
