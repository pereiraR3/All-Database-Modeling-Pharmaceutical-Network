CREATE OR REPLACE FUNCTION atualizar_salario_mensal()
RETURNS TRIGGER AS $$
DECLARE
    total_vendas DECIMAL(10,2);
    taxa_comissao DECIMAL(5,2);
    comissao_total DECIMAL(10,2);
BEGIN
    -- Busca a comissão do funcionário
    SELECT comissao INTO taxa_comissao FROM funcionario WHERE id = NEW.id_funcionario;

    -- Calcula o total de vendas do funcionário no mês
    SELECT SUM(valor_total) INTO total_vendas
    FROM venda
    WHERE id_funcionario = NEW.id_funcionario
    AND EXTRACT(MONTH FROM data_venda) = EXTRACT(MONTH FROM CURRENT_DATE)
    AND EXTRACT(YEAR FROM data_venda) = EXTRACT(YEAR FROM CURRENT_DATE);

    -- Calcula o total da comissão
    comissao_total := total_vendas * taxa_comissao / 100;

    -- Atualiza o salário mensal do funcionário
    UPDATE funcionario
    SET salario_mensal = salario + comissao_total
    WHERE id = NEW.id_funcionario;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER atualizar_salario_mensal_trigger
AFTER INSERT OR UPDATE ON venda
FOR EACH ROW
EXECUTE FUNCTION atualizar_salario_mensal();