CREATE TABLE auditoria_log (
    ID BIGSERIAL PRIMARY KEY,
    Tabela_Afetada VARCHAR(255),
    Tipo_Operacao VARCHAR(255) CHECK (Tipo_Operacao IN ('CREATE', 'READ', 'UPDATE', 'DELETE')),
    Timestamp_Operacao TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    Usuario VARCHAR(255),
    Dados_Antigos TEXT,
    Dados_Novos TEXT
);

