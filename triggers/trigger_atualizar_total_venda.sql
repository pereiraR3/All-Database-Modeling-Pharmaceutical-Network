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