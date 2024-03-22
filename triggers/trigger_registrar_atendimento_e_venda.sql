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