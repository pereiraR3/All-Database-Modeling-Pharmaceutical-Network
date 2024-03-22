
-- [TRIGGER 01]

CREATE OR REPLACE FUNCTION diminuir_quantidade_no_lote()
RETURNS TRIGGER AS $$
DECLARE 
    loteRecente DATE; 
BEGIN
    -- Verifica se a quantidade atual no lote é suficiente
    
    IF (SELECT quantidade FROM lote WHERE id_produto = NEW.id_produto ORDER BY data DESC LIMIT 1) >= NEW.quantidade THEN

        -- Obtendo o id
        SELECT data FROM lote WHERE id_produto = NEW.id_produto ORDER BY data DESC LIMIT 1 INTO loteRecente;
        
        -- Diminui a quantidade do lote
        UPDATE lote
        SET quantidade = quantidade - NEW.quantidade
        WHERE id_produto = NEW.id_produto AND data = loteRecente;
		
    ELSE
        -- Lança um erro se a venda exceder a quantidade disponível
        RAISE EXCEPTION 'Quantidade insuficiente no lote para o produto %', NEW.id_produto;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_diminuir_quantidade_no_lote
BEFORE INSERT ON tem_venda
FOR EACH ROW
EXECUTE FUNCTION diminuir_quantidade_no_lote();

-- [TRIGGER 02]

CREATE OR REPLACE FUNCTION atualizar_valor_total_venda()
RETURNS TRIGGER AS $$
DECLARE
    valorProduto DECIMAL(10,2);
    valorDesconto DECIMAL(10,2);
    novoValorTotal DECIMAL(10,2);
BEGIN
    -- Calcula o valor do produto vendido multiplicado pela quantidade e aplica o desconto
    SELECT preco INTO valorProduto FROM produto WHERE id = NEW.id_produto;
    valorDesconto = NEW.desconto;
    novoValorTotal = (valorProduto * NEW.quantidade) -  (valorProduto * NEW.quantidade)*valorDesconto;

    -- Atualiza o valor total na venda
    UPDATE venda
    SET valor_total = valor_total + novoValorTotal
    WHERE id = NEW.id_venda;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_atualizar_valor_total_venda
AFTER INSERT ON tem_venda
FOR EACH ROW
EXECUTE FUNCTION atualizar_valor_total_venda();

INSERT INTO venda(id_funcionario, id_cliente, data_venda, valor_total, nfe)
VALUES (1, 1, '2024-02-06', 0.00, 'NFe123456');

INSERT INTO tem_venda(id_produto, id_venda, quantidade, desconto)
VALUES (1, 13, 2, 0.10);

-- [TRIGGER 03]

CREATE OR REPLACE FUNCTION registrar_atendimento_venda()
RETURNS TRIGGER AS $$
BEGIN
    -- Insere um novo registro na tabela atende associando o funcionário ao cliente da venda
    INSERT INTO atende(id_cliente, id_funcionario)
    VALUES (NEW.id_cliente, NEW.id_funcionario);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_registrar_atendimento_venda
AFTER INSERT ON venda
FOR EACH ROW
EXECUTE FUNCTION registrar_atendimento_venda();

-- [TRIGGER 04]

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
EXECUTE FUNCTION permissao_venda()

