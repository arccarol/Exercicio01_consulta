CREATE DATABASE ex_projeto
GO
USE ex_projeto

GO

CREATE TABLE project(
 id            INT            NOT NULL IDENTITY(10001,1),
 nome          VARCHAR(45)    NOT NULL,
 descricao     VARCHAR(45)    NOT NULL,
 data_projeto  DATE           NOT NULL CHECK (data_projeto > '2014-09-01')
 PRIMARY KEY (id)
 )

 GO
 CREATE TABLE users(
 id_user           INT            NOT NULL IDENTITY(1,1),
 nome			   VARCHAR(45)    NOT NULL,
 username		   VARCHAR(45)    NOT NULL UNIQUE,
 senha             VARCHAR(45)    NOT NULL DEFAULT '123mudar',
 email             VARCHAR(45)    NOT NULL
 PRIMARY KEY(id_user)
 )
  
GO
CREATE TABLE users_project(
id_user       INT            NOT NULL,
id            INT            NOT NULL
 PRIMARY KEY(id, id_user)
 FOREIGN KEY(id_user) REFERENCES users (id_user),
 FOREIGN KEY(id) REFERENCES project (id)
 )

SELECT username, CONVERT(VARCHAR(10), username)AS converted_username
FROM users;

SELECT senha, CONVERT(VARCHAR(8), senha)AS converted_senha
FROM users;

INSERT INTO users VALUES
( 'Maria','Rh_maria', '123mudar', 'maria@empresa.com'),
( 'Paulo','Ti_paulo', '123@456', 'paulo@empresa.com'),
( 'Ana','Rh_ana', '123mudar', 'ana@empresa.com'),
('Clara','Ti_clara', '123mudar', 'clara@empresa.com'),
( 'Aparecido','Rh_apareci', '55@!cido', 'aparecido@empresa.com')

INSERT INTO project VALUES
( 'Re_folha','Refatoração das Folhas', '2014-09-05'),
( 'Manutenção PC´s','Manutenção PC´s', '2014-09-06'),
( 'Auditoria','', '2014-09-07')

INSERT INTO users_project VALUES
(1, 10001),
(5, 10001),
(3, 10003),
(4, 10002),
(2, 10002)

UPDATE users
SET username = 'Rh_cido'
WHERE username = 'Aparecido';

UPDATE users
SET senha = '888@*'
WHERE username = 'Rh_maria' AND senha= '123mudar';

DELETE users_project
WHERE id = 2 AND id_user = 10002;

UPDATE project
SET data_projeto = '2014-09-12'
WHERE id = 10002;

SELECT id_user,
	   nome,
       email,
       username,
	    CASE
        WHEN senha = '123mudar' THEN senha
        ELSE REPLICATE('*', 8) + SUBSTRING(senha, 9, LEN(senha))
        END AS senha
FROM  users;

SELECT p.id,
	   p.nome,
	   p.descricao,
	   p.data_projeto,
	   CONVERT(CHAR(10), DATEADD(DAY, 15, p.data_projeto), 103) AS nova_data_fim
FROM project AS p
JOIN users AS u ON id_user = id_user
WHERE p.id =  1001 AND u.email = 'aparecido@empresa.com';

SELECT p.nome,
       u.nome,
	   u.email
FROM project AS p
JOIN users AS u ON id_user = id_user
WHERE p.nome= 'Auditoria';

SELECT nome,
	   descricao,
	   data_projeto,
	    '2014-09-16' AS data_final,
       SUM(DATEDIFF(day, data_projeto, '2014-09-16') * 79.85) AS custo_total
FROM project 
WHERE nome= 'Manutenção'
GROUP BY nome, descricao, data_projeto;