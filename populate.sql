-- Inserting data into Utilizadores
INSERT INTO Utilizadores (id, nomeUtilizador, email, primeiroNome, ultimoNome, dataNacismento, localizacao, descricao, statusVerificado, fotoPerfil) VALUES
(1, 'user1', 'user1@example.com', 'User', 'One', '1990-01-01', 'Porto, Portugal', 'Hello, I am User One!', 1, 'user1.jpg'),
(2, 'user2', 'user2@example.com', 'User', 'Two', '1992-02-02', 'Lisbon, Portugal', 'Hello, I am User Two!', 0, 'user2.jpg');

-- Inserting data into Grupo
INSERT INTO Grupo (id, nome, descricao, foto, creator, statusAcesso) VALUES
(1, 'Group One', 'This is Group One', 'group1.jpg', 1, 1),
(2, 'Group Two', 'This is Group Two', 'group2.jpg', 2, 0);

-- Inserting data into Posts
INSERT INTO Posts (id, visualizacoes, idUtilizador, idGrupo, texto, imagem, video) VALUES
(1, 100, 1, 1, 'Hello, this is my first post!', 'post1.jpg', 'post1.mp4'),
(2, 200, 2, 2, 'Hello, this is my second post!', 'post2.jpg', 'post2.mp4');