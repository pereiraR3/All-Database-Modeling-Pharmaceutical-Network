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

DROP TRIGGER tr_diminuir_quantidade_no_lote ON tem_venda;