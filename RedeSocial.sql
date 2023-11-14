CREATE TABLE IF NOT EXISTS Utilizadores (
  id integer NOT NULL PRIMARY KEY,
  nomeUtilizador text(20) NOT NULL UNIQUE,
  email text(100) NOT NULL UNIQUE,
  primeiroNome text(255) NOT NULL,
  ultimoNome text(255) NOT NULL,
  dataNacismento date NOT NULL,
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
    Utilizador integer NOT NULL,
    UtilizadorSeguido integer NOT NULL,
    FOREIGN KEY (Utilizador) REFERENCES Utilizadores(id),
    FOREIGN KEY (UtilizadorSeguido) REFERENCES Utilizadores(id)
    PRIMARY KEY(Utilizador, UtilizadorSeguido)
    );
CREATE TABLE IF NOT EXISTS Posts (
    id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    visualizacoes integer NOT NULL,
    idUtilizador integer NOT NULL,
    idGrupo integer NOT NULL,
    texto text(255),
    imagem text(255),
    video text(255),
    data datetime DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (idUtilizador) REFERENCES Utilizadores(id),
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
    idGrupo integer NOT NULL,
    idUtilizador integer NOT NULL,
    FOREIGN KEY (idGrupo) REFERENCES Grupo(id) ON DELETE CASCADE,
    FOREIGN KEY (idUtilizador) REFERENCES Utilizadores(id)
    PRIMARY KEY (idGrupo, idUtilizador)
    );
CREATE TABLE IF NOT EXISTS GrupoModeradores (
    idGrupo integer NOT NULL,
    idUtilizador integer NOT NULL,
    FOREIGN KEY (idGrupo) REFERENCES Grupo(id) ON DELETE CASCADE,
    FOREIGN KEY (idUtilizador) REFERENCES Utilizadores(id)
    PRIMARY KEY (idGrupo, idUtilizador)
    );
CREATE TRIGGER IF NOT EXISTS trigger_grupo_moderadores
    AFTER INSERT ON Grupo
    BEGIN
        INSERT INTO GrupoModeradores (idGrupo, idUtilizador)
        VALUES (NEW.id, NEW.creator);
        INSERT INTO GrupoMembros (idGrupo, idUtilizador)
        VALUES (NEW.id, NEW.creator);
    END;
CREATE TABLE IF NOT EXISTS PedidosAdesao (
    idGrupo integer NOT NULL,   
    idUtilizador integer NOT NULL,
    dataPedido datetime DEFAULT CURRENT_TIMESTAMP,
    dataAceitacao datetime,
    FOREIGN KEY (idGrupo) REFERENCES Grupo(id) ON DELETE CASCADE,
    FOREIGN KEY (idUtilizador) REFERENCES Utilizadores(id)
    PRIMARY KEY (idGrupo, idUtilizador)
    );
CREATE TRIGGER IF NOT EXISTS trigger_pedidos_aceites
    AFTER UPDATE ON PedidosAdesao
    WHEN PedidosAdesao.dataAceitacao IS NOT NULL
    BEGIN
        INSERT INTO GrupoMembros (idGrupo, idUtilizador)
        VALUES (NEW.idGrupo, NEW.idUtilizador);
    END;
CREATE TABLE IF NOT EXISTS PARTILHA(
    idPost integer NOT NULL,   
    idUtilizador integer NOT NULL,
    idUtilizadorDestino integer NOT NULL,
    FOREIGN KEY (idPost) REFERENCES Posts(id)  ON DELETE CASCADE,
    FOREIGN KEY (idUtilizador) REFERENCES Utilizadores(id)
    FOREIGN KEY (idUtilizadorDestino) REFERENCES Utilizadores(id)
    PRIMARY KEY (idPost, idUtilizador)
);
CREATE TABLE IF NOT EXISTS Gosto(
    idPost integer NOT NULL,   
    idUtilizador integer NOT NULL,
    FOREIGN KEY (idPost) REFERENCES Posts(id) ON DELETE CASCADE,
    FOREIGN KEY (idUtilizador) REFERENCES Utilizadores(id),
    PRIMARY KEY (idPost, idUtilizador)
);
CREATE TABLE IF NOT EXISTS Comentario(
    id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    idPost integer NOT NULL,   
    idUtilizador integer NOT NULL,
    dataPedido datetime DEFAULT CURRENT_TIMESTAMP,
    conteudo text(255) NOT NULL,
    FOREIGN KEY (idPost) REFERENCES Posts(id) ON DELETE CASCADE,
    FOREIGN KEY (idUtilizador) REFERENCES Utilizadores(id)
);