INSERT INTO Utilizadores (nomeUtilizador, email, primeiroNome, ultimoNome, dataNacismento, localizacao, descricao, statusVerificado, fotoPerfil) VALUES ('user1', 'user1@example.com', 'User', 'One', '1990-01-01', 'Porto, Portugal', 'I love social media!', 1, 'user1.jpg');
INSERT INTO Utilizadores (nomeUtilizador, email, primeiroNome, ultimoNome, dataNacismento, localizacao, descricao, statusVerificado, fotoPerfil) VALUES ('user2', 'user2@example.com', 'User', 'Two', '1992-02-02', 'Lisbon, Portugal', 'I love coding!', 0, 'user2.jpg');

INSERT INTO Mensagens (idUtilizador, idUtilizadorDestinatario, mensagem, estadoEnvio, estadoVisualizacao) VALUES ('user1', 'user2', 'Hello, User Two!', 1, 0);
INSERT INTO Mensagens (idUtilizador, idUtilizadorDestinatario, mensagem, estadoEnvio, estadoVisualizacao) VALUES ('user2', 'user1', 'Hello, User One!', 1, 1);

INSERT INTO Seguidores (Utilizador, UtilizadorSeguido) VALUES ('user1', 'user2');
INSERT INTO Seguidores (Utilizador, UtilizadorSeguido) VALUES ('user2', 'user1');

INSERT INTO Posts (visualizacoes, idUtilizador, texto, imagem, video) VALUES (10, 'user1', 'My first post!', 'post1.jpg', 'post1.mp4');
INSERT INTO Posts (visualizacoes, idUtilizador, texto, imagem, video) VALUES (20, 'user2', 'My first post!', 'post2.jpg', 'post2.mp4');

INSERT INTO Grupo (nome, descricao, foto, creator, statusAcesso) VALUES ('Group One', 'This is Group One', 'group1.jpg', 'user1', 1);
INSERT INTO Grupo (nome, descricao, foto, creator, statusAcesso) VALUES ('Group Two', 'This is Group Two', 'group2.jpg', 'user2', 0);

INSERT INTO GrupoMembros (idGrupo, idUtilizador) VALUES (1, 'user1');
INSERT INTO GrupoMembros (idGrupo, idUtilizador) VALUES (2, 'user2');

INSERT INTO GrupoModeradores (idGrupo, idUtilizador) VALUES (1, 'user1');
INSERT INTO GrupoModeradores (idGrupo, idUtilizador) VALUES (2, 'user2');

INSERT INTO PedidosAdesao (idGrupo, idUtilizador, dataPedido, dataAceitacao) VALUES (1, 'user2', '2023-11-14 00:00:00', '2023-11-15 00:00:00');
INSERT INTO PedidosAdesao (idGrupo, idUtilizador, dataPedido, dataAceitacao) VALUES (2, 'user1', '2023-11-14 00:00:00', NULL);