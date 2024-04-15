
CREATE SEQUENCE one_by_one_filial
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE one_by_one_venda
    START WITH 1
    INCREMENT BY 1;

-- Cria a tabela 'filial'
CREATE TABLE filial (
    id INT DEFAULT nextval('one_by_one_filial'),
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
    id INT DEFAULT nextval('one_by_one_venda'),
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


----------------------------------------- TRIGGERS ---------------------------------------------------------

-- TRIGGER 01

CREATE OR REPLACE FUNCTION diminuir_quantidade_no_lote()
RETURNS TRIGGER AS $$
DECLARE 
    loteRecente DATE; 
BEGIN
    -- Verifica se a quantidade atual no lote é suficiente
    IF (SELECT quantidade FROM lote WHERE id_produto = NEW.id_produto ORDER BY data_despacho DESC LIMIT 1) >= NEW.quantidade THEN

        -- Obtendo a data do despacho mais recente
        SELECT data_despacho INTO loteRecente FROM lote WHERE id_produto = NEW.id_produto ORDER BY data_despacho DESC LIMIT 1;
        
        -- Diminui a quantidade do lote mais recente
        UPDATE lote
        SET quantidade = quantidade - NEW.quantidade
        WHERE id_produto = NEW.id_produto AND data_despacho = loteRecente;
		
    ELSE
        -- Lança um erro se a venda exceder a quantidade disponível no lote mais recente
        RAISE NOTICE 'Quantidade insuficiente no lote para o produto %', NEW.id_produto;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_diminuir_quantidade_no_lote
BEFORE INSERT ON tem_venda
FOR EACH ROW
EXECUTE FUNCTION diminuir_quantidade_no_lote();

COMMENT ON FUNCTION diminuir_quantidade_no_lote() IS $$
Esta trigger é responsável por atualizar a quantidade de produtos em estoque no 
lote mais recente após uma venda ser realizada. Ela verifica se a quantidade 
disponível é suficiente e diminui essa quantidade no lote de acordo com a 
quantidade vendida. Um erro é lançado caso a venda exceda a quantidade disponível. $$;

-- TRIGGER 02

CREATE OR REPLACE FUNCTION atualizar_valor_total_venda_e_aplicar_desconto_aniversario()
RETURNS TRIGGER AS $$
DECLARE
    valorDesconto DECIMAL(10,2) := 0.00; -- Inicializa o desconto com zero
    valorProduto MONEY;
    novoValorTotal MONEY;
    aniversario BOOL;
BEGIN
    -- Verifica se hoje é aniversário do cliente e se o status_aniversario é TRUE
    SELECT (EXTRACT(MONTH FROM data_nascimento) = EXTRACT(MONTH FROM CURRENT_DATE)
            AND EXTRACT(DAY FROM data_nascimento) = EXTRACT(DAY FROM CURRENT_DATE)
            AND status_aniversario = TRUE)
    INTO aniversario
    FROM cliente
    WHERE id = (SELECT id_cliente FROM venda WHERE id = NEW.id_venda);
    
    -- Determina o desconto aplicável
    IF aniversario THEN
        valorDesconto := 0.30; -- Desconto de 30% para aniversário
        
        -- Atualiza o status_aniversario para FALSE após aplicar o desconto
        UPDATE cliente
        SET status_aniversario = FALSE
        WHERE id = (SELECT id_cliente FROM venda WHERE id = NEW.id_venda);
    ELSE
        valorDesconto := NEW.desconto; -- Utiliza o desconto original da venda, se não for aniversário
    END IF;

    -- Calcula o valor do produto vendido multiplicado pela quantidade e aplica o desconto
    SELECT preco INTO valorProduto FROM produto WHERE id = NEW.id_produto;
    novoValorTotal = valorProduto * NEW.quantidade * (1 - valorDesconto);

    -- Atualiza o valor total na venda com ou sem desconto de aniversário
    UPDATE venda
    SET valor_total = valor_total + novoValorTotal
    WHERE id = NEW.id_venda;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_atualizar_valor_total_venda_e_aplicar_desconto_aniversario
AFTER INSERT ON tem_venda
FOR EACH ROW
EXECUTE FUNCTION atualizar_valor_total_venda_e_aplicar_desconto_aniversario();

COMMENT ON FUNCTION atualizar_valor_total_venda_e_aplicar_desconto_aniversario() IS $$
Esta trigger é acionada após a inserção de uma venda e verifica se o cliente está 
fazendo aniversário, aplicando um desconto de 30% se for o caso. Ela também 
atualiza o valor total da venda, considerando os descontos aplicados, e reseta o 
status de aniversário do cliente para evitar descontos múltiplos no mesmo dia. $$;

-- TRIGGER 03

CREATE OR REPLACE FUNCTION verificar_atualizar_contato_funcionario()
RETURNS TRIGGER AS $$
BEGIN
    -- Exemplo de verificação de formato de telefone
    IF NEW.telefone !~ '^\d{11}$' THEN
        RAISE EXCEPTION 'Formato de telefone inválido para funcionário: %', NEW.telefone;
    END IF;

    -- Exemplo de verificação de formato de email
    IF NEW.email NOT LIKE '%@%' THEN
        RAISE EXCEPTION 'Formato de email inválido para funcionário: %', NEW.email;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER verificar_contato_funcionario
BEFORE INSERT OR UPDATE ON funcionario
FOR EACH ROW EXECUTE FUNCTION verificar_atualizar_contato_funcionario();

COMMENT ON FUNCTION verificar_atualizar_contato_funcionario() IS $$
Esta trigger é usada para garantir que os dados de contato dos funcionários, 
como telefone e e-mail, estejam em formatos válidos antes de serem inseridos ou atualizados na tabela de funcionários.
A função impede a inserção ou atualização de dados inválidos, lançando uma exceção se os formatos não atenderem aos critérios especificados. $$;

-- TRIGGER 04

CREATE OR REPLACE FUNCTION permissao_venda() RETURNS TRIGGER AS $$
DECLARE
	func RECORD;
BEGIN
	SELECT * INTO func FROM funcionario WHERE id = new.id_funcionario;
	IF func.cargo = 'Faxineira' THEN
		raise notice 'Uma faxineira não pode realizar as vendas da farmácia';
		RETURN NULL;
	ELSE
		RETURN NEW;
	END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_permissao_venda
BEFORE INSERT ON venda
FOR EACH ROW
EXECUTE FUNCTION permissao_venda();

COMMENT ON FUNCTION permissao_venda() IS $$
Esta trigger verifica o cargo do funcionário antes de permitir que uma venda seja registrada. 
Se o funcionário tiver um cargo não autorizado a realizar vendas, como 'Faxineira', a venda será
bloqueada e um aviso será emitido. A venda prossegue normalmente para cargos autorizados, como 
vendedores e farmacêuticos. $$;

-- TRIGGER 05

CREATE OR REPLACE FUNCTION verificar_atualizar_contato_cliente()
RETURNS TRIGGER AS $$
BEGIN
    -- Verificação de formato de telefone
    IF NEW.telefone !~ '^\d{11}$' THEN
        RAISE EXCEPTION 'Formato de telefone inválido para cliente: %', NEW.telefone;
    END IF;

    -- Verificação de formato de email
    IF NEW.email NOT LIKE '%@%' THEN
        RAISE EXCEPTION 'Formato de email inválido para cliente: %', NEW.email;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER verificar_contato_cliente
BEFORE INSERT OR UPDATE ON cliente
FOR EACH ROW EXECUTE FUNCTION verificar_atualizar_contato_cliente();

COMMENT ON FUNCTION verificar_atualizar_contato_cliente() IS $$
Esta trigger é utilizada para garantir que os dados de contato dos clientes, como telefone e e-mail, estejam
em formatos válidos antes de serem inseridos ou atualizados na tabela de clientes. A função impede a inserção
ou atualização de dados inválidos, lançando uma exceção se os formatos não atenderem aos critérios especificados. $$;

-- TRIGGER 06

CREATE OR REPLACE FUNCTION verifica_validade_produto()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se a data de despacho é posterior à data de validade do produto
    IF NEW.data_despacho > (SELECT data_validade FROM produto WHERE id = NEW.id_produto) THEN
        RAISE EXCEPTION 'Não é possível inserir lote com produtos vencidos.';
    END IF;
    RETURN NEW; -- Retorna o novo registro para ser inserido
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER verifica_validade_antes_inserir_lote
BEFORE INSERT ON lote
FOR EACH ROW
EXECUTE FUNCTION verifica_validade_produto();

COMMENT ON FUNCTION verifica_validade_produto() IS $$
Esta trigger é acionada antes de inserir um novo lote na tabela de lotes.
Ela verifica se a data de despacho do lote é anterior à data de validade do produto associado.
Caso a data de despacho seja posterior à data de validade, a inserção é bloqueada e uma exceção
é lançada para prevenir o armazenamento de produtos vencidos. $$;

----------------------------------------- Functions ---------------------------------------------------------

-- FUNCTION 01

CREATE OR REPLACE FUNCTION atualizar_salario_mensal_funcionarios()
RETURNS VOID AS $$
DECLARE
    funcionario_record RECORD;
BEGIN
    FOR funcionario_record IN SELECT id, salario_fixo, comissao FROM funcionario LOOP
        DECLARE
            total_vendas DECIMAL(10,2) DEFAULT 0;
            comissao_total DECIMAL(10,2);
        BEGIN
            -- Calcula o total de vendas do funcionário no mês atual
            SELECT COALESCE(SUM(valor_total), 0) INTO total_vendas
            FROM venda
            WHERE id_funcionario = funcionario_record.id
            AND EXTRACT(MONTH FROM data_venda) = EXTRACT(MONTH FROM CURRENT_DATE)
            AND EXTRACT(YEAR FROM data_venda) = EXTRACT(YEAR FROM CURRENT_DATE);

            -- Calcula o total da comissão
            comissao_total := total_vendas * funcionario_record.comissao / 100;

            -- Atualiza o salário mensal do funcionário
            UPDATE funcionario
            SET salario_mensal = funcionario_record.salario_fixo + comissao_total
            WHERE id = funcionario_record.id;
        END;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION atualizar_salario_mensal_funcionarios() IS $$
Esta função calcula e atualiza automaticamente o salário mensal dos funcionários 
com base nas comissões obtidas das vendas do mês anterior. É ideal executar esta 
função no início de cada mês para assegurar que os salários sejam ajustados 
conforme o desempenho de vendas. $$;

-- FUNCTION 02

CREATE OR REPLACE FUNCTION setar_status_aniversario()
RETURNS VOID AS $$

BEGIN
    -- Atualiza status_aniversario para TRUE para clientes que fazem aniversário hoje
    UPDATE cliente
    SET status_aniversario = TRUE
    WHERE EXTRACT(MONTH FROM data_nascimento) = EXTRACT(MONTH FROM CURRENT_DATE)
      AND EXTRACT(DAY FROM data_nascimento) = EXTRACT(DAY FROM CURRENT_DATE);
END;

$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION setar_status_aniversario() IS $$
Atualiza o status_aniversario para TRUE para todos os clientes que fazem 
aniversário na data atual. Isso permite que descontos de aniversário sejam 
aplicados automaticamente na primeira compra do cliente no seu dia de aniversário. $$;

-- FUNCTION 03

CREATE OR REPLACE FUNCTION resetar_status_aniversario_ano_novo()
RETURNS VOID AS $$

BEGIN
    -- Atualiza status_aniversario para NULL (ou FALSE) para todos os clientes
    UPDATE cliente
    SET status_aniversario = FALSE; 
END;

$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION resetar_status_aniversario_ano_novo() IS $$
Esta função zera o status_aniversario de todos os clientes no primeiro dia de cada 
ano novo. Garante que todos os clientes sejam elegíveis para receber descontos de
aniversário novamente no próximo ano. $$;

-- FUNCTION 04 

CREATE OR REPLACE FUNCTION descartar_produtolote_vencimento()
    RETURNS VOID AS $$
    BEGIN
        UPDATE produto SET preco = preco * 0.7 
        WHERE data_validade BETWEEN CURRENT_DATE + INTERVAL '1 day' AND CURRENT_DATE + INTERVAL '45 days';
    END;
    $$ LANGUAGE plpgsql;

COMMENT ON FUNCTION descartar_produtolote_vencimento() IS $$
Esta função atualiza o preço dos produtos que estão entre 1 e 45 dias
antes da data de validade, aplicando um desconto de 30%. Destina-se a
incentivar a venda de produtos próximos ao vencimento e minimizar
perdas. $$;

-- FUNCTION 05

CREATE OR REPLACE FUNCTION descartar_completamente_produtolote_vencimento()
    RETURNS VOID AS $$
    BEGIN
        -- Primeiro, exclui os lotes dos produtos que serão descartados
        DELETE FROM lote
        WHERE id_produto IN (
            SELECT id FROM produto
            WHERE data_validade BETWEEN CURRENT_DATE + INTERVAL '1 day' 
            AND CURRENT_DATE + INTERVAL '30 days'
        );
        
        -- Em seguida, exclui os produtos próximos do vencimento
        DELETE FROM produto
        WHERE data_validade BETWEEN CURRENT_DATE + INTERVAL '1 day' 
        AND CURRENT_DATE + INTERVAL '30 days';
    END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION descartar_produtolote_vencimento() IS $$
Esta função exclui produtos e lotes que estão entre 1 e 30 dias antes
da data de validade. A função é usada para garantir que produtos
expirados sejam removidos do estoque e não sejam vendidos aos
consumidores. $$;

----------------------------------------- Views ---------------------------------------------------------

-- VIEW 01

CREATE VIEW detalhes_cliente AS
SELECT 
    c.id, 
    c.nome, 
    c.email, 
    c.telefone, 
    SUM(v.valor_total) AS valor_total
FROM 
    cliente c
LEFT JOIN 
    venda v ON c.id = v.id_cliente
GROUP BY 
    c.id, c.nome, c.email, c.telefone;

COMMENT ON VIEW detalhes_cliente IS $$
Esta view combina informações de clientes com detalhes de suas compras para fornecer um panorama completo de cada cliente. Inclui dados pessoais e a soma total das vendas, facilitando análises detalhadas de comportamento do cliente e histórico de compras. Útil para análises financeiras e de marketing.
$$;

-- VIEW 02  

CREATE VIEW estoque_produto_validade AS
SELECT 
    p.nome, 
    p.marca, 
    p.data_validade, 
    SUM(l.quantidade) AS quantidade_estoque
FROM 
    produto p
JOIN 
    lote l ON p.id = l.id_produto
WHERE 
    p.data_validade > CURRENT_DATE
GROUP BY 
    p.id, p.nome, p.marca, p.data_validade;

COMMENT ON VIEW estoque_produto_validade IS $$
Esta view facilita a visualização de produtos próximos da data de validade e seus níveis de estoque, permitindo melhor gestão de inventário e redução de perdas por expiração de produtos. Útil para departamentos de controle de qualidade e operações de estoque.
$$;

----------------------------------------- Materialized Views ---------------------------------------------------------

-- MATERIALIZED VIEW 01

CREATE MATERIALIZED VIEW vendas_mensais AS
SELECT 
    EXTRACT(MONTH FROM data_venda) AS mes, 
    EXTRACT(YEAR FROM data_venda) AS ano, 
    SUM(valor_total) AS total_vendas
FROM 
    venda
GROUP BY 
    EXTRACT(MONTH FROM data_venda), EXTRACT(YEAR FROM data_venda);

COMMENT ON MATERIALIZED VIEW vendas_mensais IS $$
Esta materialized view armazena os totais de vendas mensais, organizados por mês e ano, permitindo consultas rápidas e eficientes sobre dados históricos de vendas sem sobrecarregar a operação normal com cálculos repetitivos. Ideal para análise financeira e acompanhamento de tendências de vendas ao longo do tempo.
$$;

-- MATERIALIZED VIEW 02 

CREATE MATERIALIZED VIEW desempenho_funcionario AS
SELECT 
    f.id, 
    f.nome, 
    COUNT(v.id) AS total_vendas, 
    SUM(v.valor_total) AS valor_vendas
FROM 
    funcionario f
JOIN 
    venda v ON f.id = v.id_funcionario
GROUP BY 
    f.id, f.nome;

COMMENT ON MATERIALIZED VIEW desempenho_funcionario IS $$
Esta materialized view agrega informações sobre as vendas realizadas por cada funcionário, incluindo o número total de vendas e o valor total vendido, facilitando a avaliação de desempenho e a identificação de top performers na equipe de vendas. Essencial para gestão de recursos humanos e planejamento de incentivos.
$$;


----------------------------------------- Insert Data ---------------------------------------------------------

INSERT INTO filial (cnpj, site, telefone, endereco) VALUES ('123456780001', 'site1.com', '11987654321', 'Endereço da Filial 1');
INSERT INTO filial (cnpj, site, telefone, endereco) VALUES ('123456780002', 'site2.com', '21987654321', 'Endereço da Filial 2');
INSERT INTO filial (cnpj, site, telefone, endereco) VALUES ('123456780003', 'site3.com', '31987654321', 'Endereço da Filial 3');
INSERT INTO filial (cnpj, site, telefone, endereco) VALUES ('123456780004', 'site4.com', '41987654321', 'Endereço da Filial 4');
INSERT INTO filial (cnpj, site, telefone, endereco) VALUES ('123456780005', 'site5.com', '51987654321', 'Endereço da Filial 5');
INSERT INTO filial (cnpj, site, telefone, endereco) VALUES ('123456780006', 'site6.com', '61987654321', 'Endereço da Filial 6');
INSERT INTO filial (cnpj, site, telefone, endereco) VALUES ('123456780007', 'site7.com', '71987654321', 'Endereço da Filial 7');
INSERT INTO filial (cnpj, site, telefone, endereco) VALUES ('123456780008', 'site8.com', '81987654321', 'Endereço da Filial 8');
INSERT INTO filial (cnpj, site, telefone, endereco) VALUES ('123456780009', 'site9.com', '91987654321', 'Endereço da Filial 9');
INSERT INTO filial (cnpj, site, telefone, endereco) VALUES ('123456780010', 'site10.com', '101987654321', 'Endereço da Filial 10');

INSERT INTO fornecedor (cnpj, nome, telefone, endereco, portfolio) VALUES ('87456321000189', 'LAB. bate bem', '11987654321', 'Rua das Tecnologias, 500, São Paulo, SP', 'Coracao bem.');
INSERT INTO fornecedor (cnpj, nome, telefone, endereco, portfolio) VALUES ('76849531000155', 'LAB. PRINCIPA', '21987654322', 'Estrada dos Agricultores, 120, Campinas, SP', 'Nos temos a solucao.');
INSERT INTO fornecedor (cnpj, nome, telefone, endereco, portfolio) VALUES ('65849321000122', 'VIVABEM LAB.', '31987654323', 'Avenida dos Construtores, 750, Belo Horizonte, MG', 'menos dor');
INSERT INTO fornecedor (cnpj, nome, telefone, endereco, portfolio) VALUES ('54938210001299', 'BioHealth Equipamentos', '41987654324', 'Rua dos Médicos, 200, Rio de Janeiro, RJ', 'Equipamentos médicos e hospitalares.');
INSERT INTO fornecedor (cnpj, nome, telefone, endereco, portfolio) VALUES ('43021198000188', 'LAB. VIVA', '51987654325', 'Rua da Moda, 450, Fortaleza, CE', ' viva bem ');
INSERT INTO fornecedor (cnpj, nome, telefone, endereco, portfolio) VALUES ('32109876000199', 'LAB. dorme bem', '61987654326', 'Parque Tecnológico, 1080, Salvador, BA', 'Solucoes para o sono');
INSERT INTO fornecedor (cnpj, nome, telefone, endereco, portfolio) VALUES ('21098765000177', 'FARMALEV', '71987654327', 'Boulevard Gourmet, 330, Porto Alegre, RS', 'FARMA');
INSERT INTO fornecedor (cnpj, nome, telefone, endereco, portfolio) VALUES ('21098765000173', 'Fini brazil', '11387654321', 'Rua das lagrimas , 230, Porto Alegre, RS', 'Suprimento de doces');
INSERT INTO fornecedor (cnpj, nome, telefone, endereco, portfolio) VALUES ('23231942388322', 'Come bem', '51287154331', 'Rua das Parques , 130, Mato-Groso, MT', 'Doces & bebidas');
INSERT INTO fornecedor (cnpj, nome, telefone, endereco, portfolio) VALUES ('34573236842233', 'LAB. sobreviva', '33112496954', 'Rua das Parques , 131, Mato-Groso, MT', 'SEM DOR');

INSERT INTO funcionario (cpf, rg, nome, email, telefone, certificado, cargo, comissao, salario_fixo, salario_mensal, id_filial, endereco) 
VALUES
('12345678901', '987654321', 'João Silva', 'joao.silva@email.com', '11987654321', TRUE, 'Farmaceutico', 5.00, 3000.00, 3050.00, 1, 'Endereço 1'),
('23456789012', '876543219', 'Maria Oliveira', 'maria.oliveira@email.com', '21987654321', TRUE, 'Gerente', 10.00, 5000.00, 5500.00, 1, 'Endereço 2'),
('34567890123', '765432198', 'Ana Costa', 'ana.costa@email.com', '31987654321', FALSE, 'Faxineira', 0.00, 1200.00, 1200.00, 1, 'Endereço 3'),
('45678901234', '654321987', 'Carlos Dias', 'carlos.dias@email.com', '41987654321', FALSE, 'Atendente', 2.00, 2000.00, 2040.00, 1, 'Endereço 4'),
('56789012345', '543219876', 'Teresa Gonçalves', 'teresa.goncalves@email.com', '51987654321', FALSE, 'Atendente', 2.00, 2000.00, 2040.00, 1, 'Endereço 5'),
('56789012145', '543219176', 'Teresa', 'teresa.@email.com', '51987654321', FALSE, 'Atendente', 2.00, 2000.00, 2040.00, 2, 'Endereço 5'),
('45678901134', '654321187', 'Carlos ', 'carlos.@email.com', '41987654321', FALSE, 'Atendente', 2.00, 2000.00, 2040.00, 2, 'Endereço 4'),
('34567890223', '765432298', 'Ana ', 'ana.@email.com', '31987654321', FALSE, 'Faxineira', 0.00, 1200.00, 1200.00, 2, 'Endereço 3'),
('23456789312', '876543119', 'Maria ', 'maria.@email.com', '21987654321', TRUE, 'Gerente', 10.00, 5000.00, 5500.00, 2, 'Endereço 2'),
('12345678301', '987654121', 'João ', 'joao.@email.com', '11987654321', TRUE, 'Farmaceutico', 5.00, 3000.00, 3050.00, 2, 'Endereço 1'),
('50789012145', '513219176', 'Teresa dias', 'teresa.dias@email.com', '51980650121', FALSE, 'Atendente', 2.00, 2000.00, 2040.00, 4, 'Endereço 5'),
('45678911134', '611321187', 'Carlos dias ', 'carlos.diaSs@email.com', '41087014321', FALSE, 'Atendente', 2.00, 2000.00, 2040.00, 4, 'Endereço 4'),
('34560090123', '715432218', 'Ana dias', 'ana.dias@email.com', '31987604021', FALSE, 'Faxineira', 0.00, 1200.00, 1200.00, 4, 'Endereço 3'),
('23456080312', '176543119', 'Maria dias', 'maria.dias@email.com', '21081043211', TRUE, 'Gerente', 10.00, 5000.00, 5500.00, 4, 'Endereço 2'),
('1234071301', '917154121', 'João dias', 'joao.dias@email.com', '11907604321', TRUE, 'Farmaceutico', 5.00, 3000.00, 3050.00, 4, 'Endereço 1'),
('56789011145', '541219176', 'Teresa triz', 'teresa.triz@email.com', '51917654321', FALSE, 'Atendente', 2.00, 2000.00, 2040.00, 3, 'Endereço 5'),
('45678902134', '651321187', 'Carlos triz', 'carlos.triz@email.com', '41917654321', FALSE, 'Atendente', 2.00, 2000.00, 2040.00, 3, 'Endereço 4'),
('34567892223', '761432298', 'Ana triz', 'ana.triz@email.com', '31987654311', FALSE, 'Faxineira', 0.00, 1200.00, 1200.00, 3, 'Endereço 3'),
('23456782312', '871543119', 'Maria triz', 'maria.triz@email.com', '21987154321', TRUE, 'Gerente', 10.00, 5000.00, 5500.00, 3, 'Endereço 2'),
('12345672301', '981654121', 'João triz', 'joao.triz@email.com', '11987651321', TRUE, 'Farmaceutico', 5.00, 3000.00, 3050.00, 3, 'Endereço 1'),
('56789712145', '503219176', 'vitor', 'vitor.@email.com', '51987614321', FALSE, 'Atendente', 2.00, 2000.00, 2040.00, 5, 'Endereço 5'),
('45678701134', '604321187', 'gabriel ', 'gabriel.@email.com', '41982654321', FALSE, 'Atendente', 2.00, 2000.00, 2040.00, 5, 'Endereço 4'),
('34567790223', '705432298', 'vitoria ', 'vitoria.@email.com', '31982654321', FALSE, 'Faxineira', 0.00, 1200.00, 1200.00, 5, 'Endereço 3'),
('23456779312', '806543119', 'jucelino ', 'jucelino.@email.com', '21927654321', TRUE, 'Gerente', 10.00, 5000.00, 5500.00, 5, 'Endereço 2'),
('10345678301', '907654121', 'junior ', 'junior.@email.com', '11987624321', TRUE, 'Farmaceutico', 5.00, 3000.00, 3050.00, 5, 'Endereço 1'),
('56389712145', '303239176', 'vitor dias', 'vitor.dias@email.com', '51987614321', FALSE, 'Atendente', 2.00, 2000.00, 2040.00, 5, 'Endereço 5'),
('45373701134', '634323187', 'gabriel dias', 'gabriel.dias@email.com', '41912614321', FALSE, 'Atendente', 2.00, 2000.00, 2040.00, 5, 'Endereço 4'),
('34563790223', '735433298', 'vitoria dias', 'vitoria.dias@email.com', '31982154321', FALSE, 'Faxineira', 0.00, 1200.00, 1200.00, 5, 'Endereço 3'),
('23453779312', '836543119', 'jucelino dias', 'jucelino.dias@email.com', '21127154321', TRUE, 'Gerente', 10.00, 5000.00, 5500.00, 5, 'Endereço 2'),
('11145678301', '903634121', 'junior dias', 'junior.dias@email.com', '11987624121', TRUE, 'Farmaceutico', 5.00, 3000.00, 3050.00, 5, 'Endereço 1'),
('56789412145', '540009176', 'vitor santos', 'vitor.santos@email.com', '51987614421', FALSE, 'Atendente', 2.00, 2000.00, 2040.00, 6, 'Endereço 5'),
('45674701134', '644321187', 'gabriel santos', 'gabriel.santos@email.com', '41984654321', FALSE, 'Atendente', 2.00, 2000.00, 2040.00, 6, 'Endereço 4'),
('34567490223', '704432298', 'vitoria santos', 'vitoria.santos@email.com', '31984654321', FALSE, 'Faxineira', 0.00, 1200.00, 1200.00, 6, 'Endereço 3'),
('23454779312', '806543149', 'jucelino santos', 'jucelino.santos@email.com', '21427654321', TRUE, 'Gerente', 10.00, 5000.00, 5500.00, 6, 'Endereço 2'),
('12344678301', '907644121', 'junior santos', 'junior.santos@email.com', '14987424321', TRUE, 'Farmaceutico', 5.00, 3000.00, 3050.00, 6, 'Endereço 1'),
('56789717145', '503719176', 'isabela', 'isabela.@email.com', '51987614321', FALSE, 'Atendente', 2.00, 2000.00, 2040.00, 7, 'Endereço 5'),
('45678707134', '607321187', 'davi ', 'davi.@email.com', '41982657321', FALSE, 'Atendente', 2.00, 2000.00, 2040.00, 7, 'Endereço 4'),
('34567797223', '707432298', 'giovanna ', 'giovanna.@email.com', '31972654321', FALSE, 'Faxineira', 0.00, 1200.00, 1200.00, 7, 'Endereço 3'),
('23456777312', '807543119', 'fernanda ', 'fernanda.@email.com', '21977654321', TRUE, 'Gerente', 10.00, 5000.00, 5500.00, 7, 'Endereço 2'),
('12345677301', '002654121', 'caio ', 'caio.@email.com', '11987724321', TRUE, 'Farmaceutico', 5.00, 3000.00, 3050.00, 7, 'Endereço 1'),
('56789787145', '503719876', 'isabela santos', 'isabela.santos@email.com', '51988614321', FALSE, 'Atendente', 2.00, 2000.00, 2040.00, 8, 'Endereço 5'),
('45678807134', '607821187', 'davi santos', 'davi.santos@email.com', '41982658321', FALSE, 'Atendente', 2.00, 2000.00, 2040.00, 8, 'Endereço 4'),
('34567798223', '708482298', 'giovanna santos', 'giovanna.santos@email.com', '31982654321', FALSE, 'Faxineira', 0.00, 1200.00, 1200.00, 8, 'Endereço 3'),
('23456778312', '808543119', 'fernanda santos', 'fernanda.santos@email.com', '21987654321', TRUE, 'Gerente', 10.00, 5000.00, 5500.00, 8, 'Endereço 2'),
('01345678301', '908654121', 'caio santos', 'caio.santos@email.com', '11988724321', TRUE, 'Farmaceutico', 5.00, 3000.00, 3050.00, 8, 'Endereço 1'),
('56789717115', '544419176', 'isabela dias', 'isabela.dias@email.com', '51997614321', FALSE, 'Atendente', 2.00, 2000.00, 2040.00, 9, 'Endereço 5'),
('45678709134', '607441197', 'davi dias', 'davi.dias@email.com', '41982657391', FALSE, 'Atendente', 2.00, 2000.00, 2040.00, 9, 'Endereço 4'),
('34567797213', '707442298', 'giovanna dias', 'giovannadias.@email.com', '31926543211', FALSE, 'Faxineira', 0.00, 1200.00, 1200.00, 9, 'Endereço 3'),
('23456793111', '804493119', 'fernanda dias', 'fernanda.dias@email.com', '21976543211', TRUE, 'Gerente', 10.00, 5000.00, 5500.00, 9, 'Endereço 2'),
('12345679301', '904459121', 'caio dias', 'caio.dias@email.com', '19877243211', TRUE, 'Farmaceutico', 5.00, 3000.00, 3050.00, 9, 'Endereço 1'),
('56789713145', '303719176', 'isabela dias C', 'isabela.diasC@email.com', '51997634321', FALSE, 'Atendente', 2.00, 2000.00, 2040.00, 10, 'Endereço 5'),
('45678703134', '307321197', 'davi dias C', 'davi.diasC@email.com', '41982637391', FALSE, 'Atendente', 2.00, 2000.00, 2040.00, 10, 'Endereço 4'),
('34567793223', '307932298', 'giovanna dias C', 'giovannadias.C@email.com', '31923543211', FALSE, 'Faxineira', 0.00, 1200.00, 1200.00, 10, 'Endereço 3'),
('2345679312', '307593119', 'fernanda dias C', 'fernanda.diasC@email.com', '21936543211', TRUE, 'Gerente', 10.00, 5000.00, 5500.00, 10, 'Endereço 2'),
('12345673301', '307659121', 'caio dias C', 'caio.diasC@email.com', '19873243211', TRUE, 'Farmaceutico', 5.00, 3000.00, 3050.00, 10, 'Endereço 1');
 
INSERT INTO cliente (cpf, email, nome, data_nascimento, telefone, endereco, status_aniversario) VALUES
('12345678901', 'cliente1@email.com', 'Cliente Um', '1985-01-01', '11987654321', 'Endereço Cliente 1', False),
('23456789012', 'cliente2@email.com', 'Cliente Dois', '1990-02-02', '21987654322', 'Endereço Cliente 2', False),
('34567890123', 'cliente3@email.com', 'Cliente Três', '1995-03-03', '31987654323', 'Endereço Cliente 3', False),
('45678901234', 'cliente4@email.com', 'Cliente Quatro', '2000-04-04', '41987654324', 'Endereço Cliente 4', False),
('56789012345', 'cliente5@email.com', 'Cliente Cinco', '2005-05-05', '51987654325', 'Endereço Cliente 5', False),

('1234567213', 'cliente13@email.com', 'Cliente Um', '19850101', '11987654211', 'Endereço Cliente 2', False),
('2345672822', 'cliente66@email.com', 'Cliente Dois', '19900202', '21987643221', 'Endereço Cliente 2', False),
('3456789232', 'client11@email.com', 'Cliente Três', '19950303', '31198765323', 'Endereço Cliente 2', False),
('4567891242', 'cliente22@email.com', 'Cliente Quatro', '20000404', '41986543214', 'Endereço Cliente 2', False),
('5678912252', 'cliente21@email.com', 'Cliente Cinco', '20050505', '51987514325', 'Endereço Cliente 2', False),

('1234563213', 'cliente113@email.com', 'Cliente 11', '1985-10-23', '11987165421', 'Endereço Cliente 2', False),
('2345372822', 'cliente616@email.com', 'Cliente 11', '1993-02-22', '12198764322', 'Endereço Cliente 2', False),
('3156789232', 'client111@email.com', 'Cliente 11', '1995-03-23', '11981765323', 'Endereço Cliente 2', False),
('4167391242', 'cliente221@email.com', 'Cliente 11', '2004-03-24', '41986543124', 'Endereço Cliente 2', False),
('5178312252', 'cliente211@email.com', 'Cliente 11', '2005-02-05', '51987543125', 'Endereço Cliente 2', False),

('1244563214', 'cliente112@email.com', 'Cliente 31', '1985-04-23', '11947654121', 'Endereço Cliente 2', False),
('2445372824', 'cliente612@email.com', 'Cliente 31', '1993-04-22', '21947643122', 'Endereço Cliente 2', False),
('3146789242', 'client121@email.com', 'Cliente 31', '1995-04-23', '11947653123', 'Endereço Cliente 2', False),
('4147391242', 'cliente222@email.com', 'Cliente 31', '2004-04-24', '41946541324', 'Endereço Cliente 2', False),
('5478312254', 'cliente212@email.com', 'Cliente 31', '2005-12-05', '51947543125', 'Endereço Cliente 2', False),

('7234563213', 'cliente11w@email.com', 'Cliente 113', '1985-10-23', '11981765421', 'Endereço Cliente 11', False),
('7345372822', 'cliente61w@email.com', 'Cliente 616', '1993-02-22', '21987641322', 'Endereço Cliente 616', False),
('7456789232', 'client11w@email.com', 'Cliente 111', '1995-03-23', '13198765323', 'Endereço Cliente 111', False),
('7567391242', 'cliente22w@email.com', 'Cliente 221', '2004-03-02', '14198654324', 'Endereço Cliente 221', False),
('7678312252', 'cliente21w@email.com', 'Cliente 211', '2003-10-25', '15198754325', 'Endereço Cliente 211', False),

('7234663213', 'clientetaew@email.com', 'Cliente 113', '1985-10-23', '11987651421', 'Endereço Cliente 11', False),
('7346372822', 'clientetdwe@email.com', 'Cliente 616', '1993-02-22', '21987164322', 'Endereço Cliente 616', False),
('7456789632', 'client1tsew@email.com', 'Cliente 111', '1995-03-23', '31987653231', 'Endereço Cliente 111', False),
('7567391642', 'clientetwewd@email.com', 'Cliente 221', '2004-03-02', '41986543241', 'Endereço Cliente 221', False),
('7668612252', 'clientetaww@email.com', 'Cliente 211', '2003-10-25', '51987543251', 'Endereço Cliente 211', False),

('7274673213', 'clientetaesw@email.com', 'Cliente 113', '1985-10-23', '11947644121', 'Endereço Cliente 11', False),
('7347372722', 'clientetdwse@email.com', 'Cliente 616', '1993-02-22', '21984643122', 'Endereço Cliente 616', False),
('7457789732', 'client1tsesw@email.com', 'Cliente 111', '1995-03-23', '31947614323', 'Endereço Cliente 111', False),
('7577391742', 'clientetweswd@email.com', 'Cliente 221', '2004-03-02', '41486544124', 'Endereço Cliente 221', False),
('7678672272', 'clientetawsw@email.com', 'Cliente 211', '2003-10-25', '51987441425', 'Endereço Cliente 211', False),

('7234863283', 'clienteta8djw@email.com', 'Cliente 113', '1985-10-23', '11987651821', 'Endereço Cliente 11', False),
('7386872822', 'clientetd8dde@email.com', 'Cliente 616', '1993-02-22', '21918864322', 'Endereço Cliente 616', False),
('7456889832', 'client1t8hewd@email.com', 'Cliente 111', '1995-03-23', '31987165823', 'Endereço Cliente 111', False),
('7567381842', 'clientetw8ehswd@email.com', 'Cliente 221', '2004-03-02', '41881684324', 'Endereço Cliente 221', False),
('7668612852', 'clientetaa8w@email.com', 'Cliente 211', '2003-10-25', '51981758325', 'Endereço Cliente 211', False),

('7294669213', 'cliente9ew@email.com', 'Cliente 113', '1985-10-23', '11997169421', 'Endereço Cliente 11', False),
('734697922', 'clientet9we@email.com', 'Cliente 616', '1993-02-22', '21991769322', 'Endereço Cliente 616', False),
('7496789632', 'client19s9w@email.com', 'Cliente 111', '1995-03-23', '31981965923', 'Endereço Cliente 111', False),
('75693942', 'clientetw9d@email.com', 'Cliente 221', '2004-03-02', '41981954324', 'Endereço Cliente 221', False),
('7968912952', 'cliente9w@email.com', 'Cliente 211', '2003-10-25', '51997159325', 'Endereço Cliente 211', False),

('7294339313', 'cliente9ew3@email.com', 'Cliente 113', '1985-10-23', '11913991421', 'Endereço Cliente 11', False),
('7334637322', 'clientet9w3e@email.com', 'Cliente 616', '1993-02-22', '21936932112', 'Endereço Cliente 616', False),
('7496738332', 'client193s9w@email.com', 'Cliente 111', '1995-03-23', '31983311923', 'Endereço Cliente 111', False),
('7536939342', 'clientetw93d@email.com', 'Cliente 221', '2004-03-02', '41931134324', 'Endereço Cliente 221', False),
('7968932352', 'cliente39w@email.com', 'Cliente 211', '2003-10-25', '51199715325', 'Endereço Cliente 211', False);
 
INSERT INTO venda (id_funcionario, id_cliente, data_venda, valor_total, nota_fiscal, id_filial) VALUES 
(1, 1, '2024-03-23', 299.99, 'NF123156', 1),
(1, 2, '2024-03-23', 299.99, 'NF113456', 1),
(1, 3, '2024-03-23', 299.99, 'NF123416', 1),
(1, 4, '2024-03-23', 299.99, 'NF123156', 1),
(1, 5, '2024-03-23', 299.99, 'NF113456', 1),
(2, 6, '2024-03-23', 299.99, 'NF123451', 1),
(2, 7, '2024-03-23', 299.99, 'NF121456', 1),
(2, 8, '2024-03-23', 299.99, 'NF123456', 1),
(2, 9, '2024-03-23', 299.99, 'NF113456', 1),
(2, 10, '2024-03-23', 299.99, 'NF123156', 1),
(2, 11, '2024-03-23', 299.99, 'NF123156', 1),
(3, 12, '2024-03-23', 299.99, 'NF113416', 1),
(3, 13, '2024-03-23', 299.99, 'NF113456', 1),
(3, 14, '2024-03-23', 299.99, 'NF123156', 1),
(3, 15, '2024-03-23', 299.99, 'NF123456', 1),
(3, 16, '2024-03-23', 299.99, 'NF121456', 1),
(3, 17, '2024-03-23', 299.99, 'NF123156', 1),
(4, 18, '2024-03-23', 299.99, 'NF121456', 1),
(4, 19, '2024-03-23', 299.99, 'NF123456', 1),
(4, 20, '2024-03-23', 299.99, 'NF123451', 1),
(2, 21, '2025-03-23', 299.99, 'NF123456', 2),
(2, 22, '2025-03-13', 299.99, 'NF113156', 2),
(2, 23, '2025-03-23', 299.99, 'NF121456', 2),
(2, 24, '2025-03-13', 299.99, 'NF123456', 2),
(3, 25, '2025-01-23', 299.99, 'NF113456', 3),
(3, 26, '2025-01-23', 299.99, 'NF123156', 3),
(3, 27, '2025-01-23', 299.99, 'NF123156', 3),
(4, 18, '2024-03-23', 299.99, 'NF121456', 4),
(4, 19, '2024-03-23', 299.99, 'NF123456', 4),
(4, 20, '2024-03-23', 299.99, 'NF123451', 4),
(2, 21, '2025-03-23', 299.99, 'NF123456', 4),
(2, 22, '2025-03-13', 299.99, 'NF113156', 4),
(2, 23, '2025-03-23', 299.99, 'NF121456', 4),
(2, 24, '2025-03-13', 299.99, 'NF123456', 4),
(3, 25, '2025-01-23', 299.99, 'NF113456', 4),
(3, 26, '2025-01-23', 299.99, 'NF123156', 4),
(3, 26, '2025-04-24', 299.99, 'NF123136', 4),
(3, 26, '2025-04-24', 299.99, 'NF123126', 4),
(3, 26, '2025-04-24', 299.99, 'NF123116', 4),
(1, 1, '2024-04-02', 299.99, 'NF122056', 1),
(1, 2, '2024-04-02', 299.99, 'NF111056', 1),
(1, 3, '2024-04-02', 299.99, 'NF124016', 1),
(1, 4, '2024-04-02', 299.99, 'NF121056', 1),
(3, 27, '2025-01-23', 299.99, 'NF123156', 4);

INSERT INTO produto (nome, preco, marca, tipo_remedio, prescricao_medica, tipo_tarja, forma_de_administracao, composicao_remedio, data_validade, data_fabricacao, secao) VALUES 
 ('Hidratante Corporal', 29.90, 'Dove', NULL, FALSE, NULL, NULL, 'Glycerin, Paraffinum Liquidum', '2025-12-31', '2023-01-01', 'Cuidados Pessoais'),
 ('Amoxicilina', 25.90, 'Eurofarma', 'Antibiótico', TRUE, 'Tarja Vermelha', 'Oral', 'Amoxicilina Triidratada 500mg', '2026-02-01', '2023-02-01', 'Medicamentos'),
 
 ('Omeprazol', 18.50, 'Aché', 'Antiulceroso', FALSE, 'Sem Tarja', 'Oral', 'Omeprazol 20mg', '2026-03-01', '2023-03-01', 'Medicamentos'),
 ('Paracetamol', 10.00, 'Cimed', 'Analgésico', FALSE, 'Sem Tarja', 'Oral', 'Paracetamol 500mg', '2026-04-01', '2023-04-01', 'Medicamentos'),
 ('Losartana Potássica', 22.90, 'Sandoz', 'Anti-hipertensivo', FALSE, 'Sem Tarja', 'Oral', 'Losartana Potássica 50mg', '2026-05-01', '2023-05-01', 'Medicamentos'),
 ('Shampoo Anticaspa', 25.90, 'ClearMen', NULL, FALSE, NULL, NULL, 'Zinco Piritiona', '2025-12-31', '2023-01-01', 'Higiene'),
 ('Creme Dental', 12.50, 'Colgate', NULL, FALSE, NULL, NULL, 'Fluoreto de Sódio', '2025-12-31', '2023-01-01', 'Higiene'),
 ('Desodorante Roll-On', 15.00, 'Rexona', NULL, FALSE, NULL, NULL, 'Aqua, Aluminum Chlorohydrate', '2025-12-31', '2023-01-01', 'Higiene'),
 ('Protetor Solar FPS 50', 49.90, 'Nivea', NULL, FALSE, NULL, NULL, 'Avobenzone, Octocrylene', '2025-12-31', '2023-01-01', 'Cuidados Pessoais'),
 ('Hidratante Corporal', 29.90, 'Dove', NULL, FALSE, NULL, NULL, 'Glycerin, Paraffinum Liquidum', '2025-12-31', '2023-01-01', 'Cuidados Pessoais'),
 ('Dipirona', 15.00, 'Medley', 'Analgésico', FALSE, 'Sem Tarja', 'Oral', 'Dipirona Sódica 500mg', '2026-01-01', '2023-01-01', 'Medicamentos'),

 ('Hidratante Corporal', 29.90, 'Dove', NULL, FALSE, NULL, NULL, 'Glycerin, Paraffinum Liquidum', '2025-12-31', '2023-01-01', 'Cuidados Pessoais'),
 ('Amoxicilina', 25.90, 'Eurofarma', 'Antibiótico', TRUE, 'Tarja Vermelha', 'Oral', 'Amoxicilina Triidratada 500mg', '2026-02-01', '2023-02-01', 'Medicamentos'),
 ('Omeprazol', 18.50, 'Aché', 'Antiulceroso', FALSE, 'Sem Tarja', 'Oral', 'Omeprazol 20mg', '2026-03-01', '2023-03-01', 'Medicamentos'),
 ('Paracetamol', 10.00, 'Cimed', 'Analgésico', FALSE, 'Sem Tarja', 'Oral', 'Paracetamol 500mg', '2026-04-01', '2023-04-01', 'Medicamentos'),
 ('Losartana Potássica', 22.90, 'Sandoz', 'Anti-hipertensivo', FALSE, 'Sem Tarja', 'Oral', 'Losartana Potássica 50mg', '2026-05-01', '2023-05-01', 'Medicamentos'),
 ('Shampoo Anticaspa', 25.90, 'ClearMen', NULL, FALSE, NULL, NULL, 'Zinco Piritiona', '2025-12-31', '2023-01-01', 'Higiene'),
 ('Creme Dental', 12.50, 'Colgate', NULL, FALSE, NULL, NULL, 'Fluoreto de Sódio', '2025-12-31', '2023-01-01', 'Higiene'),
 ('Desodorante Roll-On', 15.00, 'Rexona', NULL, FALSE, NULL, NULL, 'Aqua, Aluminum Chlorohydrate', '2025-12-31', '2023-01-01', 'Higiene'),
 ('Protetor Solar FPS 50', 49.90, 'Nivea', NULL, FALSE, NULL, NULL, 'Avobenzone, Octocrylene', '2025-12-31', '2023-01-01', 'Cuidados Pessoais'),
 ('Hidratante Corporal', 29.90, 'Dove', NULL, FALSE, NULL, NULL, 'Glycerin, Paraffinum Liquidum', '2025-12-31', '2023-01-01', 'Cuidados Pessoais'),
 ('Dipirona', 15.00, 'Medley', 'Analgésico', FALSE, 'Sem Tarja', 'Oral', 'Dipirona Sódica 500mg', '2026-01-01', '2023-01-01', 'Medicamentos'),

 ('Hidratante Corporal', 29.90, 'Dove', NULL, FALSE, NULL, NULL, 'Glycerin, Paraffinum Liquidum', '2025-12-31', '2023-01-01', 'Cuidados Pessoais'),
 ('Amoxicilina', 25.90, 'Eurofarma', 'Antibiótico', TRUE, 'Tarja Vermelha', 'Oral', 'Amoxicilina Triidratada 500mg', '2026-02-01', '2023-02-01', 'Medicamentos'),
 ('Omeprazol', 18.50, 'Aché', 'Antiulceroso', FALSE, 'Sem Tarja', 'Oral', 'Omeprazol 20mg', '2026-03-01', '2023-03-01', 'Medicamentos'),
 ('Paracetamol', 10.00, 'Cimed', 'Analgésico', FALSE, 'Sem Tarja', 'Oral', 'Paracetamol 500mg', '2026-04-01', '2023-04-01', 'Medicamentos'),
 ('Losartana Potássica', 22.90, 'Sandoz', 'Anti-hipertensivo', FALSE, 'Sem Tarja', 'Oral', 'Losartana Potássica 50mg', '2026-05-01', '2023-05-01', 'Medicamentos'),
 ('Shampoo Anticaspa', 25.90, 'ClearMen', NULL, FALSE, NULL, NULL, 'Zinco Piritiona', '2025-12-31', '2023-01-01', 'Higiene'),
 ('Creme Dental', 12.50, 'Colgate', NULL, FALSE, NULL, NULL, 'Fluoreto de Sódio', '2025-12-31', '2023-01-01', 'Higiene'),
 ('Desodorante Roll-On', 15.00, 'Rexona', NULL, FALSE, NULL, NULL, 'Aqua, Aluminum Chlorohydrate', '2025-12-31', '2023-01-01', 'Higiene'),
 ('Protetor Solar FPS 50', 49.90, 'Nivea', NULL, FALSE, NULL, NULL, 'Avobenzone, Octocrylene', '2025-12-31', '2023-01-01', 'Cuidados Pessoais'),
 ('Hidratante Corporal', 29.90, 'Dove', NULL, FALSE, NULL, NULL, 'Glycerin, Paraffinum Liquidum', '2025-12-31', '2023-01-01', 'Cuidados Pessoais'),
 ('Dipirona', 15.00, 'Medley', 'Analgésico', FALSE, 'Sem Tarja', 'Oral', 'Dipirona Sódica 500mg', '2026-01-01', '2023-01-01', 'Medicamentos'),
 
 ('Hidratante Corporal', 29.90, 'Dove', NULL, FALSE, NULL, NULL, 'Glycerin, Paraffinum Liquidum', '2025-12-31', '2023-01-01', 'Cuidados Pessoais'),
 ('Amoxicilina', 25.90, 'Eurofarma', 'Antibiótico', TRUE, 'Tarja Vermelha', 'Oral', 'Amoxicilina Triidratada 500mg', '2026-02-01', '2023-02-01', 'Medicamentos'),
 ('Omeprazol', 18.50, 'Aché', 'Antiulceroso', FALSE, 'Sem Tarja', 'Oral', 'Omeprazol 20mg', '2026-03-01', '2023-03-01', 'Medicamentos'),
 ('Paracetamol', 10.00, 'Cimed', 'Analgésico', FALSE, 'Sem Tarja', 'Oral', 'Paracetamol 500mg', '2026-04-01', '2023-04-01', 'Medicamentos'),
 ('Losartana Potássica', 22.90, 'Sandoz', 'Anti-hipertensivo', FALSE, 'Sem Tarja', 'Oral', 'Losartana Potássica 50mg', '2026-05-01', '2023-05-01', 'Medicamentos'),
 ('Shampoo Anticaspa', 25.90, 'ClearMen', NULL, FALSE, NULL, NULL, 'Zinco Piritiona', '2025-12-31', '2023-01-01', 'Higiene'),
 ('Creme Dental', 12.50, 'Colgate', NULL, FALSE, NULL, NULL, 'Fluoreto de Sódio', '2025-12-31', '2023-01-01', 'Higiene'),
 ('Desodorante Roll-On', 15.00, 'Rexona', NULL, FALSE, NULL, NULL, 'Aqua, Aluminum Chlorohydrate', '2025-12-31', '2023-01-01', 'Higiene'),
 ('Protetor Solar FPS 50', 49.90, 'Nivea', NULL, FALSE, NULL, NULL, 'Avobenzone, Octocrylene', '2025-12-31', '2023-01-01', 'Cuidados Pessoais'),
 ('Hidratante Corporal', 29.90, 'Dove', NULL, FALSE, NULL, NULL, 'Glycerin, Paraffinum Liquidum', '2025-12-31', '2023-01-01', 'Cuidados Pessoais'),
 ('Dipirona', 15.00, 'Medley', 'Analgésico', FALSE, 'Sem Tarja', 'Oral', 'Dipirona Sódica 500mg', '2026-01-01', '2023-01-01', 'Medicamentos');
 
 
INSERT INTO lote (id_produto, nome, quantidade, data_despacho, id_filial) 
VALUES
(1, 'Lote A1', 100, '2024-03-23', 1),
(2, 'Lote B2', 150, '2024-03-24', 1),
(3, 'Lote C3', 200, '2024-03-25', 1),
(4, 'Lote D4', 250, '2024-03-26', 1),
(5, 'Lote E5', 300, '2024-03-27', 1),
(6, 'Lote F6', 350, '2024-03-28', 1),
(7, 'Lote G7', 400, '2024-03-29', 1),
(8, 'Lote A1', 100, '2024-03-23', 1),
(9, 'Lote B2', 150, '2024-03-24', 1),
(10, 'Lote C3', 200, '2024-03-25', 1),
(11, 'Lote D4', 250, '2024-03-26', 1),
(12, 'Lote A1T', 100, '2024-03-23', 2),
(13, 'Lote B2T', 150, '2024-03-24', 2),
(14, 'Lote C3T', 200, '2024-03-25', 2),
(15, 'Lote D4T', 250, '2024-03-26', 2),
(16, 'Lote E5T', 300, '2024-03-27', 2),
(17, 'Lote F6T', 350, '2024-03-28', 2),
(18, 'Lote G7T', 400, '2024-03-29', 2),
(19, 'Lote A1T', 100, '2024-03-23', 2),
(20, 'Lote B2T', 150, '2024-03-24', 2),
(21, 'Lote C3T', 200, '2024-03-25', 2),
(22, 'Lote D4T', 250, '2024-03-26', 2),
(23, 'Lote A1R', 100, '2024-03-23', 3),
(24, 'Lote B2R', 150, '2024-03-24', 3),
(25, 'Lote C3R', 200, '2024-03-25', 3),
(26, 'Lote D4R', 250, '2024-03-26', 3),
(27, 'Lote E5R', 300, '2024-03-27', 3),
(28, 'Lote F6R', 350, '2024-03-28', 3),
(29, 'Lote G7R', 400, '2024-03-29', 3),
(30, 'Lote A1R', 100, '2024-03-23', 3),
(31, 'Lote B2R', 150, '2024-03-24', 3),
(32, 'Lote C3R', 200, '2024-03-25', 3),
(33, 'Lote D4R', 250, '2024-03-26', 3),
(34, 'Lote A1W', 100, '2024-03-23', 4),
(35, 'Lote B2W', 150, '2024-03-24', 4);

INSERT INTO principio_ativo (nome) VALUES
('Paracetamol'),
('Amoxicilina'),
('Zinco Piritiona'),
('Fluoreto de Sódio'),
('Aluminum Chlorohydrate');																				  						

INSERT INTO tem_venda (id_produto, id_venda, quantidade, preco, desconto) 
VALUES 
(1, 1, 2, 25.90, 0.00), 
(2, 2, 1, 12.50, 1.00),
(3, 3, 3, 15.00, 0.00),
(4, 4, 1, 49.90, 5.00),
(5, 5, 2, 29.90, 2.00),
(6, 6, 3, 15.00, 0.00),
(7, 7, 1, 49.90, 5.00),
(8, 8, 7, 29.90, 2.00),
(9, 9, 2, 29.90, 2.00),
(10, 10, 7, 29.90, 2.00),
(11, 11, 2, 29.90, 2.00),
(30, 30, 2, 25.90, 0.00), 
(18, 18, 7, 29.90, 2.00),
(19, 19, 7, 29.90, 2.00),
(20, 20, 7, 29.90, 2.00),
(21, 21, 7, 29.90, 2.00),
(31, 31, 2, 25.90, 0.00), 
(32, 32, 1, 12.50, 1.00),
(33, 33, 3, 15.00, 0.00),
(34, 34, 7, 49.90, 5.00),
(28, 28, 71, 29.90, 2.00),
(29, 29, 17, 29.90, 2.00),
(24, 20, 8, 29.90, 2.00),
(25, 21, 8, 29.90, 2.00),
(1, 41, 3, 30.00, 0),
(2, 40, 1, 40.00, 5.00),
(2, 42, 5, 25.90, 0.00), 
(3, 43, 5, 12.50, 1.00);

INSERT INTO fornece (id_fornecedor, id_produto, id_lote) VALUES 
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(1, 8, 8),
(2, 9, 9),
(3,10,10),
(4,11,11),
(5,12,12),
(6,13,13),
(7,14,14),
(1,15,15),
(2,16,16),
(3,17,17),
(4,18,18),
(5,19,19),
(6,20,20),
(7,21,21),
(1,25,25),
(2,26,26),
(3,27,27),
(4,28,28),
(5,29,29),
(6,30,30),
(7,31,31),
(1,35,35);

INSERT INTO produto_tem_principio (id_produto, id_principio) VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,1),
(7,2),
(8,3),
(9,4),
(10,5),
(11,1),
(12,2),
(13,3),
(14,4),
(15,5),
(16,1),
(17,2),
(18,3),
(19,4),
(20,5),
(21,1),
(22,2),
(23,3),
(24,4),
(25,5),
(26,1),
(27,2),
(28,3),
(29,4),
(30,5),
(31,1),
(32,2),
(33,3),
(34,4),
(35,5),
(36,1);

INSERT INTO classe (nome) VALUES 
('inotrópicos'),
('vasodilatadores'),
('anticoagulantes'),
('antipiréticos'),
('analgésicos'),
('paracetamol'),
('Higiene Pessoal'),
('Cuidados com a Pele');

INSERT INTO tem_classe (id_produto, id_classe) VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,1),
(10,2),
(11,3),
(12,4),
(13,5),
(14,6),
(15,7),
(16,8),
(17,1),
(18,2),
(19,3),
(20,4),
(21,5),
(22,6),
(23,7),
(24,8),
(25,1),
(26,2),
(27,3),
(28,4),
(29,5),
(30,6),
(31,7),
(32,8),
(33,1),
(34,2),
(35,3),
(36,4);