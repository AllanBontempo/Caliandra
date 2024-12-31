CREATE TABLE clientes (
                          id_cliente SERIAL PRIMARY KEY,
                          nome VARCHAR(100) NOT NULL,
                          email VARCHAR(100) UNIQUE NOT NULL,
                          senha_hash VARCHAR(255) NOT NULL,
                          telefone VARCHAR(15),
                          data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          ativo BOOLEAN DEFAULT TRUE
);


CREATE TABLE enderecos (
                           id_endereco SERIAL PRIMARY KEY,
                           id_cliente INT REFERENCES clientes(id_cliente) ON DELETE CASCADE,
                           cep VARCHAR(9) NOT NULL,
                           logradouro VARCHAR(150) NOT NULL,
                           numero VARCHAR(10) NOT NULL,
                           complemento VARCHAR(100),
                           bairro VARCHAR(100) NOT NULL,
                           cidade VARCHAR(100) NOT NULL,
                           estado CHAR(2) NOT NULL
);


CREATE TABLE categorias (
                            id_categoria SERIAL PRIMARY KEY,
                            nome VARCHAR(100) UNIQUE NOT NULL,
                            descricao TEXT,
                            ativo BOOLEAN DEFAULT TRUE
);



CREATE TABLE produtos (
                          id_produto SERIAL PRIMARY KEY,
                          nome VARCHAR(100) NOT NULL,
                          descricao TEXT,
                          preco DECIMAL(10, 2) NOT NULL,
                          estoque INT NOT NULL CHECK (estoque >= 0),
                          id_categoria INT REFERENCES categorias(id_categoria) ON DELETE SET NULL,
                          ativo BOOLEAN DEFAULT TRUE,
                          data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE formas_pagamento (
                                  id_forma_pagamento SERIAL PRIMARY KEY,
                                  tipo VARCHAR(50) NOT NULL,
                                  ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE pedidos (
                         id_pedido SERIAL PRIMARY KEY,
                         id_cliente INT REFERENCES clientes(id_cliente) ON DELETE CASCADE,
                         id_endereco INT REFERENCES enderecos(id_endereco),
                         id_forma_pagamento INT REFERENCES formas_pagamento(id_forma_pagamento),
                         total DECIMAL(10, 2) NOT NULL,
                         status VARCHAR(50) DEFAULT 'PENDENTE',
                         data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE itens_pedido (
                              id_item SERIAL PRIMARY KEY,
                              id_pedido INT REFERENCES pedidos(id_pedido) ON DELETE CASCADE,
                              id_produto INT REFERENCES produtos(id_produto) ON DELETE CASCADE,
                              quantidade INT NOT NULL CHECK (quantidade > 0),
                              preco DECIMAL(10, 2) NOT NULL
);

CREATE TABLE cupons_desconto (
                                 id_cupom SERIAL PRIMARY KEY,
                                 codigo VARCHAR(20) UNIQUE NOT NULL,
                                 desconto DECIMAL(5, 2) NOT NULL,
                                 validade TIMESTAMP NOT NULL,
                                 ativo BOOLEAN DEFAULT TRUE
);


CREATE TABLE avaliacoes (
                            id_avaliacao SERIAL PRIMARY KEY,
                            id_cliente INT REFERENCES clientes(id_cliente) ON DELETE CASCADE,
                            id_produto INT REFERENCES produtos(id_produto) ON DELETE CASCADE,
                            nota INT NOT NULL CHECK (nota BETWEEN 1 AND 5),
                            comentario TEXT,
                            data_avaliacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




