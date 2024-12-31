CREATE TABLE TIPO_USUARIO(
                             id int GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY UNIQUE,
                             tipo_usuario varchar(255)
);

CREATE TABLE USUARIOS (
                          id int GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY UNIQUE,
                          nome varchar(255) NOT NULL,
                          email varchar(255) NOT NULL,
                          senha varchar(255) NOT NULL,
                          tipo_usuario_id int NOT NULL,
                          FOREIGN KEY (tipo_usuario_id) REFERENCES TIPO_USUARIO(id)
);

CREATE TABLE ENDERECO (
                          id int GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY UNIQUE,
                          cep varchar(8) NOT NULL,
                          logradouro varchar(255) NOT NULL,
                          complemento varchar(255),
                          numero int NOT NULL,
                          usuario_id int NOT NULL,
                          FOREIGN KEY (usuario_id) REFERENCES USUARIOS(id)
);

CREATE TABLE PRODUTOS (
                          id int GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY UNIQUE,
                          nome varchar(255) NOT NULL ,
                          valor BIGINT,
                          quantidade_estoque int
);

CREATE TABLE CATEGORIA_PRODUTOS (
                                    id int GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY UNIQUE,
                                    categoria varchar(255)
);

CREATE TABLE RELACIONAMENTO_PRODUTOS_CATEGORIAS (
                                                    produto_id int,
                                                    categoria_id int,
                                                    PRIMARY KEY (produto_id, categoria_id),
                                                    FOREIGN KEY (produto_id) REFERENCES PRODUTOS(id),
                                                    FOREIGN KEY (categoria_id) REFERENCES CATEGORIA_PRODUTOS(id)
);
