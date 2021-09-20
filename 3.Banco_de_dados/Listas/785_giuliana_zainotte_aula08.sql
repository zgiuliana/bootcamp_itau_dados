--1. Crie duas tabelas: produto e categoria. Essas duas tabelas devem estar relacionadas.
--    - Considere que o produto possui uma descrição, preço, frete e categoria. 
--    - Considere que a categoria possui apenas uma descrição. 
--    - Não esqueça de inserir as chaves primárias e estrangeira da forma correta, de modo a criar o relacionamento entre as tabelas.
--    1. Adicione 3 registros em cada tabela.

    CREATE TABLE categoria(
        categoria_id SERIAL PRIMARY KEY, 
        descricao varchar(255) NOT NULL	
    );
    CREATE TABLE produto(
        produto_id SERIAL PRIMARY KEY, 
        descricao varchar(255) NOT NULL, -- restricao de campo não nulo
        preco NUMERIC (8, 2) NOT NULL, 
        frete NUMERIC (4, 2) NOT NULL,
		categoria_id  INTEGER NOT NULL,
		FOREIGN KEY (categoria_id) REFERENCES categoria (categoria_id) ON UPDATE CASCADE ON DELETE CASCADE
    );

INSERT INTO categoria(descricao)
    VALUES ('Alimentos'),
		   ('Bebidas'),
		   ('Higiene'),
		   ('Limpeza');
INSERT INTO produto(descricao,preco,frete,categoria_id)
    VALUES ('Margarina',7.30,1,1),
		   ('Refrigerante',3.5,0.5,2),
		   ('Sabonete',10,1,3),
		   ('Bom-Bril',4,0.2,4);	
	

--2. Crie duas tabelas: turmas e alunos. Essas duas tabelas devem estar relacionadas. 
--    - Um aluno pode pertencer a muitas turmas e uma turma deve conter muitos alunos (tabela extra).
--    - Considere que o aluno possui: nome, matrícula, data de nascimento e e-mail. 
--    - A turma possui os atributos descrição, professor (considere apenas um), data de início, e data de término.
--    1. Adicione 3 registros em cada tabela.
    CREATE TABLE turma(
        id_turma SERIAL PRIMARY KEY, 
        descricao varchar(255) NOT NULL,
		professor varchar(255) NOT NULL,
		data_inicio DATE NOT NULL,
		data_termino DATE NOT NULL 	
    );
    CREATE TABLE aluno(
        id_aluno SERIAL PRIMARY KEY, 
        nome varchar(255) NOT NULL, -- restricao de campo não nulo
        id_matricula NUMERIC (10) NOT NULL, 
        data_nasc DATE  NOT NULL,
		email  varchar(255) NOT NULL
    );
	CREATE TABLE turma_aluno(
		id_turma INTEGER NOT NULL,
		id_aluno INTEGER NOT NULL,
		FOREIGN KEY (id_turma) REFERENCES turma (id_turma) ON UPDATE CASCADE ON DELETE CASCADE,
		FOREIGN KEY (id_aluno) REFERENCES aluno (id_aluno) ON UPDATE CASCADE ON DELETE CASCADE
	);

INSERT INTO turma(descricao,professor,data_inicio,data_termino)
    VALUES ('SQL','Filipe','2021-07-10','2021-07-26'),
		   ('Linguagem de Programação','Walisson','2021-07-05','2021-07-26'),
		   ('Linux','Walisson','2021-07-05','2021-07-10');
INSERT INTO aluno(nome,id_matricula,data_nasc,email)
	VALUES ('Giuliana Zainotte',987307097,'1996-02-04','zainottegiuliana@gmail.com'),
		   ('Bruna de Oliveira Nobre',004309225,'1993-12-30','brunaoliveiranobre@correio.itau.com.br'),
		   ('Anderson Oliveira Sarmento',987331810,'1991-04-03','anderson.sarmento@itau-unibanco.com.br');
INSERT INTO turma_aluno(id_turma,id_aluno)
	VALUES (1,1),
		   (1,2),
		   (1,3),
		   (2,2),
		   (2,3),
		   (1,3),
		   (2,3);
		   