PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Mensagens;
DROP TABLE IF EXISTS Seguidores;
DROP TABLE IF EXISTS Posts;
DROP TABLE IF EXISTS Grupo;
DROP TABLE IF EXISTS GrupoMembros;
DROP TABLE IF EXISTS GrupoModeradores;
DROP TABLE IF EXISTS PedidosAdesao;
DROP TABLE IF EXISTS Partilha;
DROP TABLE IF EXISTS Gosto;
DROP TABLE IF EXISTS Comentario;
DROP TABLE IF EXISTS RecomendacoesPosts;
DROP TABLE IF EXISTS InteressesUtilizador;
DROP TABLE IF EXISTS Interesses;
-- DROP TRIGGER IF EXISTS trigger_grupo_moderadores;
-- DROP TRIGGER IF EXISTS trigger_pedidos_aceites;
DROP TABLE IF EXISTS Utilizadores;

CREATE TABLE Utilizadores (
  id integer NOT NULL PRIMARY KEY,
  nomeUtilizador text(20) NOT NULL UNIQUE,
  email text(100) NOT NULL UNIQUE,
  primeiroNome text(255) NOT NULL,
  ultimoNome text(255) NOT NULL,
  dataNascimento date NOT NULL,
  localizacao text(255) NOT NULL,
  descricao text(255) NOT NULL,
  statusVerificado boolean NOT NULL,
  fotoPerfil text(255) NOT NULL
);
CREATE TABLE IF NOT EXISTS Mensagens (
  id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  idUtilizador integer NOT NULL,
  idUtilizadorDestinatario integer NOT NULL,
  mensagem text(255) NOT NULL,
  estadoEnvio boolean NOT NULL,
  estadoVisualizacao boolean NOT NULL,
  dataEnvio datetime DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (idUtilizador) REFERENCES Utilizadores(id),
  FOREIGN KEY (idUtilizadorDestinatario) REFERENCES Utilizadores(id)
);
CREATE TABLE IF NOT EXISTS Seguidores (
    id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    Utilizador integer NOT NULL,
    UtilizadorSeguido integer NOT NULL,
    FOREIGN KEY (Utilizador) REFERENCES Utilizadores(id),
    FOREIGN KEY (UtilizadorSeguido) REFERENCES Utilizadores(id),
    UNIQUE(Utilizador, UtilizadorSeguido)
    );
CREATE TABLE IF NOT EXISTS Posts (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    visualizacoes INTEGER NOT NULL,
    idUtilizador INTEGER NOT NULL,
    idGrupo INTEGER NOT NULL,
    texto TEXT(255),
    imagem TEXT(255),
    video TEXT(255),
    data DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (idUtilizador) REFERENCES Utilizadores(id),
    FOREIGN KEY (idGrupo, idUtilizador) REFERENCES GrupoMembros(idGrupo, idUtilizador),
    FOREIGN KEY (idGrupo) REFERENCES Grupo(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS Grupo (
    id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    nome text(255) NOT NULL,
    descricao text(255) NOT NULL,
    foto text(255) NOT NULL,
    dataCriacao datetime DEFAULT CURRENT_TIMESTAMP,
    creator integer NOT NULL,
    statusAcesso boolean NOT NULL,
    FOREIGN KEY (creator) REFERENCES Utilizadores(id)
    );
CREATE TABLE IF NOT EXISTS GrupoMembros (
    id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    idGrupo INTEGER NOT NULL,
    idUtilizador INTEGER NOT NULL,
    FOREIGN KEY (idGrupo) REFERENCES Grupo(id) ON DELETE CASCADE,
    FOREIGN KEY (idUtilizador) REFERENCES Utilizadores(id),
    UNIQUE (idGrupo, idUtilizador)
);
CREATE TABLE IF NOT EXISTS GrupoModeradores (
    id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    idGrupo integer NOT NULL,
    idUtilizador integer NOT NULL,
    FOREIGN KEY (idGrupo) REFERENCES Grupo(id) ON DELETE CASCADE,
    FOREIGN KEY (idUtilizador) REFERENCES Utilizadores(id),
    UNIQUE (idGrupo, idUtilizador)
    );
/*CREATE TRIGGER IF NOT EXISTS trigger_grupo_moderadores
    AFTER INSERT ON Grupo
    BEGIN
        INSERT INTO GrupoModeradores (idGrupo, idUtilizador)
        VALUES (NEW.id, NEW.creator);
        INSERT INTO GrupoMembros (idGrupo, idUtilizador)
        VALUES (NEW.id, NEW.creator);
    END;*/
CREATE TABLE IF NOT EXISTS PedidosAdesao (
    id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    idGrupo INTEGER NOT NULL,
    idUtilizador INTEGER NOT NULL,
    dataPedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    dataAceitacao DATETIME,
    FOREIGN KEY (idGrupo) REFERENCES Grupo(id) ON DELETE CASCADE,
    FOREIGN KEY (idUtilizador) REFERENCES Utilizadores(id),
    UNIQUE (idGrupo, idUtilizador)
);
/*CREATE TRIGGER IF NOT EXISTS trigger_pedidos_aceites
    AFTER UPDATE ON PedidosAdesao
    WHEN PedidosAdesao.dataAceitacao IS NOT NULL
    BEGIN
        INSERT INTO GrupoMembros (idGrupo, idUtilizador)
        VALUES (NEW.idGrupo, NEW.idUtilizador);
    END;*/
CREATE TABLE IF NOT EXISTS Partilha(
    id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    idPost integer NOT NULL,   
    idUtilizador integer NOT NULL,
    idUtilizadorDestino integer NOT NULL,
    FOREIGN KEY (idPost) REFERENCES Posts(id)  ON DELETE CASCADE,
    FOREIGN KEY (idUtilizador) REFERENCES Utilizadores(id),
    FOREIGN KEY (idUtilizadorDestino) REFERENCES Utilizadores(id)
);
CREATE TABLE IF NOT EXISTS Gosto(
    id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    idPost integer NOT NULL, 
    idUtilizador integer NOT NULL,
    FOREIGN KEY (idPost) REFERENCES Posts(id) ON DELETE CASCADE,
    FOREIGN KEY (idUtilizador) REFERENCES Utilizadores(id),
    UNIQUE (idPost, idUtilizador)
);
CREATE TABLE IF NOT EXISTS Comentario(
    id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    idPost integer NOT NULL,   
    idUtilizador integer NOT NULL,
    data datetime DEFAULT CURRENT_TIMESTAMP,
    conteudo text(255) NOT NULL,
    FOREIGN KEY (idPost) REFERENCES Posts(id) ON DELETE CASCADE,
    FOREIGN KEY (idUtilizador) REFERENCES Utilizadores(id)
);
CREATE TABLE IF NOT EXISTS Interesses(
    topico TEXT NOT NULL PRIMARY KEY
);
CREATE TABLE IF NOT EXISTS RecomendacoesPosts(
    id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    topicos TEXT NOT NULL,
    post INTEGER NOT NULL,
    FOREIGN KEY (post) REFERENCES Posts(id) ON DELETE CASCADE,
    FOREIGN KEY (topicos) REFERENCES Interesses(topico),
    UNIQUE(topicos, post)
);
CREATE TABLE IF NOT EXISTS InteressesUtilizador(
    id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    topicos TEXT NOT NULL,
    utilizador INTEGER NOT NULL,
    FOREIGN KEY (utilizador) REFERENCES Utilizadores(id),
    FOREIGN KEY (topicos) REFERENCES Interesses(topico),
    UNIQUE(topicos, utilizador)
);
