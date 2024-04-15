-- Trigger Insert em produto

-- Criação da função do trigger
CREATE OR REPLACE FUNCTION produto_after_insert()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria_log (Tabela_Afetada, Tipo_Operacao, Usuario, Dados_Novos)
    VALUES ('produto', 'CREATE', CURRENT_USER, CONCAT(NEW.ID, ', ', NEW.nome));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Comentário sobre a função do trigger
COMMENT ON FUNCTION produto_after_insert() IS $$
Função trigger que captura eventos de inserção na tabela Produto. Registra detalhes da operação de criação na tabela de auditoria, incluindo o usuário que realizou a operação e os dados inseridos.
$$;

-- Criação do trigger
CREATE TRIGGER produto_log_insert
AFTER INSERT ON produto
FOR EACH ROW
EXECUTE FUNCTION produto_after_insert();

-- Trigger Update em produto 

-- Criação da função do trigger para atualizações
CREATE OR REPLACE FUNCTION produto_after_update()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO meu_schema.auditoria_log (
        Tabela_Afetada, 
        Tipo_Operacao, 
        Usuario, 
        Dados_Antigos, 
        Dados_Novos
    ) VALUES (
        'produto', 
        'UPDATE', 
        CURRENT_USER, 
        CONCAT(OLD.ID, ', ', OLD.nome), 
        CONCAT(NEW.ID, ', ', NEW.nome)
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Comentário sobre a função do trigger
COMMENT ON FUNCTION produto_after_update() IS $$
Esta função trigger é acionada após cada atualização na tabela Produto. Ela registra detalhes da operação de atualização na tabela de auditoria, incluindo o usuário que realizou a operação e uma comparação dos dados antigos e novos.
$$;

-- Criação do trigger para atualizações
CREATE TRIGGER Produto_After_Update
AFTER UPDATE ON produto
FOR EACH ROW
EXECUTE FUNCTION produto_after_update();

-- Trigger Delete em produto

-- Criação da função do trigger para exclusões
CREATE OR REPLACE FUNCTION produto_after_delete()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria_log (
        Tabela_Afetada, 
        Tipo_Operacao, 
        Usuario, 
        Dados_Antigos
    ) VALUES (
        'produto', 
        'DELETE', 
        CURRENT_USER, 
        CONCAT(OLD.ID, ', ', OLD.nome)
    );
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Comentário sobre a função do trigger
COMMENT ON FUNCTION produto_after_delete() IS $$
Esta função trigger é acionada após cada exclusão na tabela Produto. Ela registra detalhes da operação de exclusão na tabela de auditoria, incluindo o usuário que realizou a operação e os dados que foram excluídos.
$$;

-- Criação do trigger para exclusões
CREATE TRIGGER Produto_After_Delete
AFTER DELETE ON produto
FOR EACH ROW
EXECUTE FUNCTION produto_after_delete();