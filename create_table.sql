CREATE TABLE filial (
    id SERIAL,
    site VARCHAR(50),
    telefone VARCHAR(11),
    endereco VARCHAR(200),
    unidade BOOL,
    CONSTRAINT pk_id_filial PRIMARY KEY (id)
);

CREATE TABLE fornecedor (
    id SERIAL,
    cnpj VARCHAR(14) UNIQUE,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(11) NOT NULL,
    endereco VARCHAR(200),
    portfolio TEXT NOT NULL,
    CONSTRAINT pk_id_fornecedor PRIMARY KEY (id)
);

CREATE TABLE funcionario (
    id SERIAL,
    cpf VARCHAR(11) UNIQUE,
    rg VARCHAR(9) UNIQUE,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE, 
    telefone VARCHAR(11),
    certificado BOOLEAN NOT NULL,
    cargo VARCHAR(15) NOT NULL,
    comissao DECIMAL(5, 2) NOT NULL,
    salario DECIMAL(10, 2) NOT NULL,
    salario_mensal DECIMAL (10, 2) NOT NULL,
    id_filial INT NOT NULL,
    endereco VARCHAR(200),
    CONSTRAINT pk_id_funcionario PRIMARY KEY (id),
    CONSTRAINT fk_id_filial_in_funcionario FOREIGN KEY (id_filial) REFERENCES filial (id)
);

CREATE TABLE cliente (
    id SERIAL,
    cpf VARCHAR(11) UNIQUE,
    email VARCHAR(100) UNIQUE, 
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    idade INT GENERATED ALWAYS AS (EXTRACT (YEAR FROM (age(CURRENT_TIMESTAMP, data_nascimento)))) STORED,
    telefone VARCHAR(11),
    endereco VARCHAR(200),
    CONSTRAINT pk_id_cliente PRIMARY KEY
);

CREATE TABLE atende (
    id SERIAL,
    id_cliente INT NOT NULL,
    id_funcionario INT NOT NULL,
    CONSTRAINT  pk_compound_atende PRIMARY KEY (id, id_cliente, id_funcionario),
    CONSTRAINT  fk_id_cliente_in_atende FOREIGN KEY (id_cliente) REFERENCES cliente (id),
    CONSTRAINT  fk_id_funcionario_in_atende FOREIGN KEY (id_funcionario) REFERENCES funcionario (id)
);

CREATE TABLE venda (
    id SERIAL,
    id_funcionario INT NOT NULL,
    id_cliente INT NOT NULL,
    data_venda DATE,
    valor_total DECIMAL(10, 2),
    nota_fiscal TEXT,
    CONSTRAINT  pk_compound_venda PRIMARY KEY (id, id_funcionario, id_cliente),
    CONSTRAINT  fk_id_funcionario_in_venda FOREIGN KEY (id_funcionario) REFERENCES funcionario (id),
    CONSTRAINT  fk_id_cliente_in_venda FOREIGN KEY (id_cliente) REFERENCES cliente (id)
);

CREATE TABLE produto (
    id SERIAL,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    tipo_remedio VARCHAR(20),
    prescricao_medica BOOLEAN,
    tipo_tarja VARCHAR(20),
    forma_de_administracao VARCHAR(50),
    composicao_remedio TEXT,
    data_validade DATE NOT NULL,
    data_fabricacao DATE NOT NULL,
    secao VARCHAR(20) NOT NULL,
    CONSTRAINT pk_id_produto PRIMARY KEY (id)
);

CREATE TABLE lote ( 
    id SERIAL PRIMARY KEY,
    id_produto INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    quantidade INT NOT NULL,
    origem VARCHAR(30) NOT NULL,
    destino VARCHAR(30) NOT NULL,
    data DATE NOT NULL, 
    FOREIGN KEY (id_produto) REFERENCES produto (id)
);

CREATE TABLE principio_ativo (
    id SERIAL,
    nome VARCHAR(100) NOT NULL,
    CONSTRAINT pk_id_principio_ativo PRIMARY KEY (id)
);

CREATE TABLE tem_venda (
    id SERIAL,
    id_produto INT NOT NULL,
    id_venda INT NOT NULL,
    quantidade INT NOT NULL,
    preco DECIMAL (10, 2),
    desconto DECIMAL(5, 2),
    CONSTRAINT pk_id_tem_venda PRIMARY KEY (id, id_produto, id_venda), 
    CONSTRAINT fk_id_venda_in_tem_venda FOREIGN KEY (id_venda) REFERENCES venda (id),
    CONSTRAINT fk_id_produto_in_tem_venda FOREIGN KEY (id_produto) REFERENCES produto (id)
);

CREATE TABLE fornece (
    id SERIAL,
    id_fornecedor INT NOT NULL,
    id_lote INT NOT NULL,
    id_filial INT NOT NULL,
    CONSTRAINT pk_id_fornece PRIMARY KEY (id, id_fornecedor, id_lote, id_filial)
    CONSTRAINT fk_id_filial_in_fornece  FOREIGN KEY (id_filial) REFERENCES filial (id),
    CONSTRAINT fk_id_fornecedor_in_fornece FOREIGN KEY (id_fornecedor) REFERENCES fornecedor (id),
    CONSTRAINT fk_id_lote_in_fornece FOREIGN KEY (id_lote) REFERENCES lote (id)
);

CREATE TABLE produto_tem_principio (
    id SERIAL, 
    id_produto INT NOT NULL,
    id_principio INT NOT NULL,
    CONSTRAINT pk_id_produto_tem_principio PRIMARY KEY (id, id_produto, id_principio),
    CONSTRAINT fk_id_produto_tem_principio FOREIGN KEY (id_produto) REFERENCES produto (id),
    CONSTRAINT fk_id_principio_tem_principio FOREIGN KEY (id_principio) REFERENCES principio_ativo (id)
);

CREATE TABLE classe (
    id SERIAL,
    nome VARCHAR(100),
    CONSTRAINT pk_id_classe PRIMARY KEY (id)
);

CREATE TABLE tem_classe(
    id SERIAL,
    id_produto INT NOT NULL,
    id_classe INT NOT NULL,
    CONSTRAINT pk_id_tem_classe PRIMARY KEY (id, id_produto,),
    CONSTRAINT  fk_id_produto_in_tem_classe FOREIGN KEY (id_produto) REFERENCES produto (id),
    CONSTRAINT  fk_id_classe_in_tem_classe KEY (id_classe) REFERENCES classe (id)
);