CREATE TABLE IF NOT EXISTS Utilizadores (
  nomeUtilizador text(20) NOT NULL PRIMARY KEY,
  email text(100) NOT NULL UNIQUE,
  primeiroNome text(255) NOT NULL,
  ultimoNome text(255) NOT NULL,
  dataNacismento date NOT NULL,
  localizacao text(255) NOT NULL,
  descricao text(255) NOT NULL,
  statusVerificado boolean NOT NULL,
  fotoPerfil text(255) NOT NULL
);
CREATE TABLE Mensagens (
  id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  idUtilizador text(255) NOT NULL,
  idUtilizadorDestinatario text(255) NOT NULL,
  mensagem text(255) NOT NULL,
  estadoEnvio boolean NOT NULL,
  estadoVisualizacao boolean NOT NULL,
  dataEnvio date NOT NULL,
  FOREIGN KEY (idUtilizador) REFERENCES Utilizadores(nomeUtilizador),
  FOREIGN KEY (idUtilizadorDestinatario) REFERENCES Utilizadores(nomeUtilizador)
);
CREATE TABLE Seguidores (
    id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    Utilizador text(255) NOT NULL,
    UtilizadorSeguido text(255) NOT NULL,
    FOREIGN KEY (Utilizador) REFERENCES Utilizadores(nomeUtilizador),
    FOREIGN KEY (UtilizadorSeguido) REFERENCES Utilizadores(nomeUtilizador)
    );