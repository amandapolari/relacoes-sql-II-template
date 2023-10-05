-- Active: 1696450620715@@127.0.0.1@3306

-- PRÁTICA 1:

CREATE TABLE
    users (
        id TEXT PRIMARY KEY UNIQUE NULL,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        create_at TEXT DEFAULT (
            strftime(
                '%d%m%Y%H%M%S',
                'now',
                'localtime'
            )
        )
    );

INSERT INTO
    users (id, name, email, password)
VALUES (
        'u001',
        'Lily',
        'lily@email.com',
        123
    ), (
        'u002',
        'Ammy',
        'ammy@email.com',
        456
    ), (
        'u003',
        'Atlas',
        'atlas@email.com',
        789
    );

-- PRÁTICA 2

CREATE TABLE
    follows (
        follower_id TEXT NOT NULL,
        followed_id TEXT NOT NULL,
        FOREIGN KEY (follower_id) REFERENCES users(id),
        FOREIGN KEY (followed_id) REFERENCES users(id)
    )

SELECT * FROM follows;

INSERT INTO follows
VALUES ('u001', 'u002'), ('u001', 'u003'), ('u002', 'u001');

SELECT * FROM users INNER JOIN follows ON follower_id = users.id;

-- PRÁTICA 3:

SELECT *
FROM users AS A
    LEFT JOIN follows AS B ON B.follower_id = A.id;

SELECT
    A.name AS seguidor,
    B.name AS seguido
FROM follows AS f FULL
    JOIN users AS A ON f.follower_id = A.id
    LEFT JOIN users AS B ON f.followed_id = B.id;

-- =============> FIXAÇÃO:

-- ================== CRIAÇÃO DA TABELA PRINCIPAL:

CREATE TABLE
    authors (
        id_author TEXT PRIMARY KEY UNIQUE NOT NULL,
        name_author TEXT NOT NULL
    );

-- ================== CRIAÇÃO DA TABELA QUE VAI REFERENCIAR ===========================

CREATE TABLE
    books (
        id_book TEXT PRIMARY KEY UNIQUE NOT NULL,
        name_book TEXT NOT NULL,
        author_id TEXT,
        FOREIGN KEY (author_id) REFERENCES authors(id_author) ON UPDATE CASCADE ON DELETE CASCADE
    );

-- ================== POPULANDO TABELA DE AUTORES ===========================

INSERT INTO
    authors (id_author, name_author)
VALUES ('a001', 'Colleen Hoover'), ('a002', 'Raphael Montes'), ('a003', 'Stephen King');

-- ================== POPULANDO TABELA DE LIVROS ===========================

INSERT INTO
    books (id_book, name_book, author_id)
VALUES (
        'b001',
        'Uma Segunda Chance',
        'a001'
    ), ('b002', 'Verity', 'a001'), ('b003', 'O Iluminado', 'a003'), ('b004', 'O Vilarejo', 'a002');

INSERT INTO
    books (id_book, name_book)
VALUES ('b005', 'Livro X');

-- ================== VISUALIZAÇÕES ===========================

-- Visualizando APENAS livros que TEM RELAÇÃO com a tabela de AUTORES:

SELECT * FROM authors JOIN books ON author_id = id_author;

-- Visualizando livros que TEM RELAÇÃO e que NÃO TEM com a tabela de AUTORES:

SELECT * FROM authors FULL JOIN books ON author_id = id_author;

-- Visuzalizando livros que possuem "Collen Hoover" como autora:

SELECT
    id_author AS idDoAutor,
    name_book AS nomeDoLivro,
    name_author AS NomeDoAutor
FROM authors
    JOIN books ON authors.id_author = books.author_id
WHERE
    name_author = 'Colleen Hoover';
-- name_author = 'Raphael Montes';
-- name_author = 'Stephen King';

-- Visualizando uma tabela mais completa:

SELECT
    id_book AS IdDoLivro,
    name_book AS NomeDoLivro,
    name_author AS NomeDoautor,
    author_id AS IdDoAutor
FROM authors FULL
    JOIN books ON author_id = id_author;