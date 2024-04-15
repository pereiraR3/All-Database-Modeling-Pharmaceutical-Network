
-- Cria a tabela 'filial'
CREATE TABLE filial (
    id SERIAL,
    cnpj VARCHAR(14) UNIQUE,
    site VARCHAR(50),
    telefone VARCHAR(15),
    endereco VARCHAR(200),
    CONSTRAINT pk_id_filial PRIMARY KEY (id)
);

COMMENT ON TABLE filial IS 'Entidade do DER que representa uma filial.';
COMMENT ON COLUMN filial.id IS 'Chave primária de uma filial.';
COMMENT ON COLUMN filial.cnpj IS 'Número único designado pela Receita Federal na abertura legal de uma empresa.';
COMMENT ON COLUMN filial.site IS 'Site para compras online de uma farmácia.';
COMMENT ON COLUMN filial.telefone IS 'Telefone comercial da Filial.';
COMMENT ON COLUMN filial.endereco IS 'Endereço da localidade da filial.';

-- Cria a tabela 'fornecedor'
CREATE TABLE fornecedor (
    id SERIAL,
    cnpj CHAR(14) UNIQUE,
    nome VARCHAR(100) NOT NULL,
    telefone CHAR(11) NOT NULL,
    endereco VARCHAR(200),
    portfolio TEXT NOT NULL,
    CONSTRAINT pk_id_fornecedor PRIMARY KEY (id)
);

COMMENT ON TABLE fornecedor IS 'Entidade do DER que representa um fornecedor.';
COMMENT ON COLUMN fornecedor.id IS 'Chave primária de um fornecedor.';
COMMENT ON COLUMN fornecedor.cnpj IS 'Número único designado pela Receita Federal na abertura legal de uma empresa.';
COMMENT ON COLUMN fornecedor.nome IS 'Nome que se refere à empresa fornecedora de produtos.';
COMMENT ON COLUMN fornecedor.telefone IS 'Telefone para entrar em contato com o fornecedor.';
COMMENT ON COLUMN fornecedor.endereco IS 'Endereço corresponde à posição geográfica da empresa fornecedora.';
COMMENT ON COLUMN fornecedor.portfolio IS 'Portfólio se refere à lista de produtos que uma empresa fornecedora fornece.';

-- Cria a tabela 'funcionario' entidade do DER.
CREATE TABLE funcionario (
    id SERIAL,
    cpf CHAR(11) UNIQUE,
    rg CHAR(9) UNIQUE,
    nome CHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE, 
    telefone CHAR(11),
    certificado BOOLEAN NOT NULL,
    cargo VARCHAR(15) NOT NULL,
    comissao DECIMAL(5, 2) NOT NULL,
    salario_fixo MONEY NOT NULL CHECK (salario_fixo > CAST(0.00 AS MONEY)),
    salario_mensal MONEY NOT NULL,
    id_filial INT NOT NULL,
    endereco VARCHAR(200) NOT NULL,
    CONSTRAINT pk_id_funcionario PRIMARY KEY (id),
    CONSTRAINT fk_id_filial_in_funcionario FOREIGN KEY (id_filial) REFERENCES filial (id)
);

COMMENT ON TABLE funcionario IS 'Entidade do DER que representa um funcionário.';
COMMENT ON COLUMN funcionario.id IS 'Chave primária de um funcionário.';
COMMENT ON COLUMN funcionario.cpf IS 'Número de documento que identifica o contribuinte perante a Receita Federal.';
COMMENT ON COLUMN funcionario.rg IS 'Número de documento que identifica o contribuinte perante a SSP.';
COMMENT ON COLUMN funcionario.nome IS 'Nome completo do funcionário.';
COMMENT ON COLUMN funcionario.email IS 'E-mail do funcionário.';
COMMENT ON COLUMN funcionario.telefone IS 'Número de telefone do funcionário.';
COMMENT ON COLUMN funcionario.certificado IS 'Certificado de curso do funcionário (1 se ele possui e 0 se não possui).';
COMMENT ON COLUMN funcionario.cargo IS 'Cargo do funcionário na empresa filial.';
COMMENT ON COLUMN funcionario.comissao IS 'Comissão fixa recebida pelo funcionário por produto vendido, independente de qual seja.';
COMMENT ON COLUMN funcionario.salario_fixo IS 'Salário fixo do funcionário.';
COMMENT ON COLUMN funcionario.salario_mensal IS 'Salário mensal (calculado com a comissão) a ser recebido pelo funcionário.';
COMMENT ON COLUMN funcionario.id_filial IS 'Chave estrangeira para a filial em que o funcionário trabalha.';
COMMENT ON COLUMN funcionario.endereco IS 'Endereço residencial do funcionário.';


-- Cria a tabela 'cliente' entidade do DER.
CREATE TABLE cliente (
    id SERIAL,
    cpf CHAR(11) UNIQUE,
    email VARCHAR(100) UNIQUE, 
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE,
    telefone CHAR(11),
    endereco VARCHAR(200),
    status_aniversario BOOL DEFAULT FALSE, 
    CONSTRAINT pk_id_cliente PRIMARY KEY (id)
);

COMMENT ON TABLE cliente IS 'Entidade do DER que representa um cliente.';
COMMENT ON COLUMN cliente.id IS 'Chave primária de um cliente.';
COMMENT ON COLUMN cliente.cpf IS 'Número do documento que identifica o contribuinte perante a Receita Federal.';
COMMENT ON COLUMN cliente.email IS 'Email do cliente.';
COMMENT ON COLUMN cliente.nome IS 'Nome completo do cliente.';
COMMENT ON COLUMN cliente.data_nascimento IS 'Data de nascimento do cliente.';
COMMENT ON COLUMN cliente.telefone IS 'Telefone do cliente.';
COMMENT ON COLUMN cliente.endereco IS 'Endereço do cliente.';
COMMENT ON COLUMN cliente.status_aniversario IS 'Verifica se é aniversário do cliente.';

-- Cria a tabela 'venda' entidade do DER.
CREATE TABLE venda (
    id SERIAL,
    id_funcionario INT NOT NULL,
    id_cliente INT NOT NULL,
    data_venda DATE NOT NULL DEFAULT CURRENT_DATE,
    valor_total MONEY NOT NULL,
    nota_fiscal TEXT NOT NULL,
    id_filial INT NOT NULL,
    CONSTRAINT pk_id_venda PRIMARY KEY (id),
    CONSTRAINT fk_id_funcionario_in_venda FOREIGN KEY (id_funcionario) REFERENCES funcionario (id),
    CONSTRAINT fk_id_cliente_in_venda FOREIGN KEY (id_cliente) REFERENCES cliente (id),
    CONSTRAINT fk_id_filial_in_venda FOREIGN KEY (id_filial) REFERENCES filial (id)
);

COMMENT ON TABLE venda IS 'Entidade do DER que representa uma venda.';
COMMENT ON COLUMN venda.id IS 'Chave primária de uma venda.';
COMMENT ON COLUMN venda.id_funcionario IS 'Chave estrangeira para o funcionário que realizou a venda.';
COMMENT ON COLUMN venda.id_cliente IS 'Chave estrangeira para o cliente que realizou a compra.';
COMMENT ON COLUMN venda.data_venda IS 'Data de quando ocorre uma venda de um funcionário para um cliente.';
COMMENT ON COLUMN venda.valor_total IS 'Valor total dos produtos vendidos por um funcionário.';
COMMENT ON COLUMN venda.nota_fiscal IS 'Nota fiscal emitida da venda para o cliente.';
COMMENT ON COLUMN venda.id_filial IS 'Chave estrangeira para a filial em que a venda pertence.';


-- Cria a tabela 'produto' entidade DER.
CREATE TABLE produto (
    id SERIAL,
    nome VARCHAR(100) NOT NULL,
    preco MONEY NOT NULL CHECK (preco > CAST(0.00 AS MONEY)),
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

COMMENT ON TABLE produto IS 'Entidade DER que representa um produto.';
COMMENT ON COLUMN produto.id IS 'Chave primária de um produto.';
COMMENT ON COLUMN produto.nome IS 'Nome de um produto da farmácia.';
COMMENT ON COLUMN produto.preco IS 'Preço para a compra de um produto da farmácia.';
COMMENT ON COLUMN produto.marca IS 'Marca que criou o produto.';
COMMENT ON COLUMN produto.tipo_remedio IS 'Tipo que caracteriza o remédio, como antibiótico ou analgésico.';
COMMENT ON COLUMN produto.prescricao_medica IS 'Atributo booleano para comprovar se o produto necessita de receita.';
COMMENT ON COLUMN produto.tipo_tarja IS 'As cores das tarjas indicam a classificação de venda do medicamento.';
COMMENT ON COLUMN produto.forma_de_administracao IS 'Diz respeito à forma de usar o remédio, se deve ser oral, injeção, etc.';
COMMENT ON COLUMN produto.composicao_remedio IS 'Serve para especificar se o remédio é original ou genérico.';
COMMENT ON COLUMN produto.data_validade IS 'Data de validade do produto antes de se tornar não utilizável.';
COMMENT ON COLUMN produto.data_fabricacao IS 'Data em que o produto foi criado.';
COMMENT ON COLUMN produto.secao IS 'O produto está guardado em alguma seção da filial.';

-- Cria a tabela 'lote' entidade do DER.
CREATE TABLE lote ( 
    id SERIAL,
    id_produto INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    quantidade INT NOT NULL,
    data_despacho DATE NOT NULL DEFAULT CURRENT_DATE, 
    id_filial INT NOT NULL,
    CONSTRAINT pk_composta_lote_produto PRIMARY KEY (id, id_produto), 
    FOREIGN KEY (id_produto) REFERENCES produto (id),
    CONSTRAINT fk_id_filial_in_lote FOREIGN KEY (id_filial) REFERENCES filial (id)
);

COMMENT ON TABLE lote IS 'Entidade do DER que representa um lote de produtos.';
COMMENT ON COLUMN lote.id IS 'Chave primária de um lote.';
COMMENT ON COLUMN lote.id_produto IS 'Chave estrangeira do produto que está dentro do lote.';
COMMENT ON COLUMN lote.nome IS 'Nome designado para o lote de produtos.';
COMMENT ON COLUMN lote.quantidade IS 'Quantidade de itens dentro de um lote de produtos.';
COMMENT ON COLUMN lote.data_despacho IS 'Data de despacho de uma entrega de determinado lote a uma filial.';
COMMENT ON COLUMN lote.id_filial IS 'Chave estrangeira para a filial em que o lote pertence.';

-- Cria a tabela 'principio_ativo' entidade do DER.
CREATE TABLE principio_ativo (
    id SERIAL,
    nome VARCHAR(100) NOT NULL,
    CONSTRAINT pk_id_principio_ativo PRIMARY KEY (id)
);

COMMENT ON TABLE principio_ativo IS 'Entidade do DER que representa um princípio ativo de medicamentos.';
COMMENT ON COLUMN principio_ativo.id IS 'Chave primária de um princípio ativo.';
COMMENT ON COLUMN principio_ativo.nome IS 'Nome do componente farmacologicamente ativo destinado a um medicamento.';

-- Cria a tabela 'tem_venda' que vem do relacionamento N-M entre [venda] e [produto].
CREATE TABLE tem_venda (
    id SERIAL,
    id_produto INT NOT NULL,
    id_venda INT NOT NULL,
    quantidade INT NOT NULL,
    preco MONEY NOT NULL,
    desconto DECIMAL(5, 2),
    CONSTRAINT pk_id_tem_venda PRIMARY KEY (id), 
    CONSTRAINT uq_produto_venda UNIQUE (id_produto, id_venda),
    CONSTRAINT fk_id_venda_in_tem_venda FOREIGN KEY (id_venda) REFERENCES venda (id),
    CONSTRAINT fk_id_produto_in_tem_venda FOREIGN KEY (id_produto) REFERENCES produto (id)
);

COMMENT ON TABLE tem_venda IS 'Tabela que vem do relacionamento N-M entre venda e produto.';
COMMENT ON COLUMN tem_venda.id IS 'Chave primária de um tem_venda.';
COMMENT ON COLUMN tem_venda.id_produto IS 'Chave estrangeira do produto, na qual passou por uma determinada venda.';
COMMENT ON COLUMN tem_venda.id_venda IS 'Chave estrangeira da venda, na qual vendeu determinada quantidade de um produto.';
COMMENT ON COLUMN tem_venda.quantidade IS 'Quantidade vendida de um determinado produto.';
COMMENT ON COLUMN tem_venda.preco IS 'Valor referente ao total de uma determinada quantidade de um produto.';
COMMENT ON COLUMN tem_venda.desconto IS 'Valor referente ao desconto na compra de determinado produto.';

-- Cria a tabela 'fornece' que vem do relacionamento N-M entre [fornecedor] e [lote].
CREATE TABLE fornece (
    id SERIAL,
    id_fornecedor INT NOT NULL,
	id_produto INT NOT NULL, 
    id_lote INT NOT NULL,
    CONSTRAINT pk_id_fornece PRIMARY KEY (id),
    CONSTRAINT fk_id_fornecedor_in_fornece FOREIGN KEY (id_fornecedor) REFERENCES fornecedor (id),
	CONSTRAINT fk_id_produto_in_fornece FOREIGN KEY (id_lote, id_produto) REFERENCES lote (id, id_produto)
);

COMMENT ON TABLE fornece IS 'Tabela que vem do relacionamento N-M entre fornecedor e lote.';
COMMENT ON COLUMN fornece.id IS 'Chave primária para identificar o fornecimento de um lote de produto de um fornecedor.';
COMMENT ON COLUMN fornece.id_fornecedor IS 'Chave estrangeira para relacionar o fornecedor a determinado lote de um produto.';
COMMENT ON COLUMN fornece.id_produto IS 'Chave estrangeira para relacionar o fornecedor a determinado lote de um produto.';
COMMENT ON COLUMN fornece.id_lote IS 'Chave estrangeira para relacionar o fornecedor a determinado lote de um produto.';

-- Cria a tabela 'produto_tem_principio' que vem do relacionamento N-M entre [produto] e [principio_ativo].
CREATE TABLE produto_tem_principio (
    id_produto INT NOT NULL,
    id_principio INT NOT NULL,
    CONSTRAINT pk_id_produto_tem_principio PRIMARY KEY (id_produto, id_principio),
    CONSTRAINT fk_id_produto_tem_principio FOREIGN KEY (id_produto) REFERENCES produto (id),
    CONSTRAINT fk_id_principio_tem_principio FOREIGN KEY (id_principio) REFERENCES principio_ativo (id)
);

COMMENT ON TABLE produto_tem_principio IS 'Tabela que vem do relacionamento N-M entre produto e princípio ativo.';
COMMENT ON COLUMN produto_tem_principio.id_produto IS 'Chave estrangeira do produto para relacionar com princípio.';
COMMENT ON COLUMN produto_tem_principio.id_principio IS 'Chave estrangeira do principio para relacionar com produto.';

-- Cria a tabela 'classe' entidade do DER.
CREATE TABLE classe (
    id SERIAL,
    nome VARCHAR(100),
    CONSTRAINT pk_id_classe PRIMARY KEY (id)
);

COMMENT ON TABLE classe IS 'Tabela que representa a classe terapêutica de um medicamento.';
COMMENT ON COLUMN classe.id IS 'Chave primária da classe de um remédio.';
COMMENT ON COLUMN classe.nome IS 'O nome da classe terapêutica de um medicamento, indica para que tipo de doença ou condição é indicado.';

-- Cria a tabela 'tem_classe' que vem do relacionamento N-M entre [produto] e [classe].
CREATE TABLE tem_classe(
    id_produto INT NOT NULL,
    id_classe INT NOT NULL,
    CONSTRAINT pk_id_tem_classe PRIMARY KEY (id_produto, id_classe),
    CONSTRAINT fk_id_produto_in_tem_classe FOREIGN KEY (id_produto) REFERENCES produto (id),
    CONSTRAINT fk_id_classe_in_tem_classe FOREIGN KEY (id_classe) REFERENCES classe (id)
);

COMMENT ON TABLE tem_classe IS 'Tabela que vem do relacionamento N-M entre produto e classe.';
COMMENT ON COLUMN tem_classe.id_produto IS 'Chave estrangeira do produto para relacionar com classe.';
COMMENT ON COLUMN tem_classe.id_classe IS 'Chave estrangeira de classe para relacionar com produto.';
