INSERT INTO filial (id, cnpj, site, telefone, endereco, unidade)
VALUES

(1, '40.641.005/0001-18', 'www.farmacialav.com', '(66) 99233-7652', 'Boa Esperança, rua 8, número 254', true),

(2, '75.211.348/0001-27', 'www.farmacialav.com', '(65) 99234-7611', 'Rio novo, rua Maceió, número 08', true),

(3, '19.980.095/0001-85', 'www.farmacialav.com', '(65) 99254-2341', 'Renascer, rua Fernancio, número 232', true),

(4, '73.749.423/0001-82', 'www.farmacialav.com', '(66) 99234-4323', 'Boa Nova, rua romana, número 102', true),

(5, '63.714.206/0001-01', 'www.farmacialav.com', '(66) 95634-1223', 'Imperial, rua lispector, número 200', false),

(6, '16.932.280/0001-06', 'www.farmacialav.com', '(66) 99334-2453', 'Campo Verde, rua urich, número 193', true);

INSERT INTO fornecedor (id, cnpj, nome, telefone, endereco, portfolio)
VALUES

(1, '71.302.216/0001-50', 'Fornecedor ISK', '(23) 992632-2398', 'Toneto, rua Pires do Rio, número 33', 'Portfólio A'),

(2, '50.136.028/0001-29', 'Fornecedor Brana', '(33) 99623-1232', 'Centro, av. Mestre Venâncio, número 204', 'Portfólio B'),

(3, '94.487.065/0001-57', 'Fornecedor SPEK', '(12) 99601-5692', 'Centro Comercial, av. Correia, número 543', 'Portfólio C'),

(4, '09.219.986/0001-60', 'Fornecedor SINFRA', '(33) 99618-9872', 'Coxipó, rua Alexandre, número 23', 'Portfólio D');

-- Funcionário 1
INSERT INTO funcionario (cpf, nome, telefone, certificado, cargo, comissao, salario, salario_mensal, id_filial)
VALUES ('589.317.614-65', 'Anthony Ricardo Rodrigues Rezende', '(69) 92950-7136', false, 'Vendedor', 4.0, 1300.00, 1300.00, 1);

-- Funcionário 2
INSERT INTO funcionario (cpf, nome, telefone, certificado, cargo, comissao, salario, salario_mensal,  id_filial)
VALUES ('200.865.585-79', 'Vinícius Padilha Vieira', '(54) 92148-6799', true, 'Farmacêutico', 4.0, 2500.00, 2500.00, 1);

-- Funcionário 3
INSERT INTO funcionario (cpf, nome, telefone, certificado, cargo, comissao, salario, salario_mensal,  id_filial)
VALUES ('966.522.470-03', 'Carla Bispo da Silva', '(97) 92412-7605', false, 'Faxineira', 0.0, 1300.00, 1300.00, 6);

-- Funcionário 4
INSERT INTO funcionario (cpf, nome, telefone, certificado, cargo, comissao, salario, salario_mensal, id_filial)
VALUES ('242.725.473-80', 'Letízia Manuella Serqueira Eugênio', '(99) 93125-2552', true, 'Farmacêutico', 4.0, 2500.00, 2500.00, 5);

-- Funcionário 5
INSERT INTO funcionario (cpf, nome, telefone, certificado, cargo, comissao, salario, salario_mensal, id_filial)
VALUES ('957.625.581-34', 'Henrique Ribeiro da Costa', '(95) 92734-2453', true, 'Vendedor', 4.0, 1300.00, 1300.00,  2);

-- Funcionário 6
INSERT INTO funcionario (cpf, nome, telefone, certificado, cargo, comissao, salario, salario_mensal, id_filial)
VALUES ('842.925.226-69', 'Fernando Gonçalves de Oliveira', '(53) 92559-1297', false, 'Vendedor', 4.0, 1300.00, 1300.00, 2);

-- Funcionário 7
INSERT INTO funcionario (cpf, nome, telefone, certificado, cargo, comissao, salario, salario_mensal, id_filial)
VALUES ('747.538.788-72','Maria Silva Borges', '(81) 93646-8723', false, 'Faxineira', 0.1, 1300.00, 1300.00, 2);

-- Funcionário 8
INSERT INTO funcionario (cpf, nome, telefone, certificado, cargo, comissao, salario, salario_mensal,  id_filial)
VALUES ('318.647.529-88', 'Juliana Moraes', '(67) 92836-5723', true, 'Gerente', 5.0, 3500.00, 3500.00, 4);

-- Funcionário 9
INSERT INTO funcionario (cpf, nome, telefone, certificado, cargo, comissao, salario, salario_mensal, id_filial)
VALUES ('487.529.316-44', 'Marco Túlio Cícero', '(61) 93428-7621', true, 'Farmacêutico', 4.0, 2500.00, 2500.00, 3);

-- Funcionário 10
INSERT INTO funcionario (cpf, nome, telefone, certificado, cargo, comissao, salario, salario_mensal, id_filial)
VALUES ('576.948.231-77', 'Lívia Santos', '(51) 93745-6732', false, 'Atendente', 3.0, 1200.00, 1200.00, 3);

INSERT INTO cliente (cpf, nome, telefone)
VALUES
('426.438.026-08', 'Jorge Amado', '(67) 93578-8543'),

('717.617.281-13', 'Clarice Lispector', '(47) 93026-6254'),

('341.119.718-81', 'Machado de Assis', '(88) 93356-4845'),

('405.948.530-60', 'Dom Casmurro', '(66) 93763-6846'),

('866.983.320-46', 'Alexandre Ribeiro', '(69) 93974-8447'),

('460.488.280-04', 'Gustavo da Costa', '(98) 92485-3651'),

('361.180.570-01', 'Felipe Martins', '(68) 93896-0332'),

('344.652.250-67', 'Vanessa de Oliveira', '(83) 92381-7348'),

('512.698.347-22', 'Cecília Meireles', '(82) 94567-8321'),

('725.194.826-53', 'Carlos Drummond de Andrade', '(11) 95678-9243'),

('837.265.498-17', 'Manuel Bandeira', '(21) 94782-5634');

INSERT INTO atende (id_cliente, id_funcionario) VALUES (1, 1);
INSERT INTO atende (id_cliente, id_funcionario) VALUES (2, 2);
INSERT INTO atende (id_cliente, id_funcionario) VALUES (3, 1);
INSERT INTO atende (id_cliente, id_funcionario) VALUES (4, 3);
INSERT INTO atende (id_cliente, id_funcionario) VALUES (5, 2);
INSERT INTO atende (id_cliente, id_funcionario) VALUES (6, 3);
INSERT INTO atende (id_cliente, id_funcionario) VALUES (7, 1);
INSERT INTO atende (id_cliente, id_funcionario) VALUES (8, 2);
INSERT INTO atende (id_cliente, id_funcionario) VALUES (9, 3);
INSERT INTO atende (id_cliente, id_funcionario) VALUES (10, 1);

-- Venda 1
INSERT INTO venda (id_funcionario, id_cliente, data_venda, valor_total, nfe) VALUES (1, 1, '2023-08-01', 100.00, 'AsxT23SAA');

-- Venda 2
INSERT INTO venda (id_funcionario, id_cliente, data_venda, valor_total, nfe) VALUES (2, 2, '2023-08-02', 150.00, 'AsxT23SA31');

-- Venda 3
INSERT INTO venda (id_funcionario, id_cliente, data_venda, valor_total, nfe) VALUES (1, 3, '2023-08-03', 200.00, 'AsxT23SA1');

-- Venda 4
INSERT INTO venda (id_funcionario, id_cliente, data_venda, valor_total, nfe) VALUES (3, 4, '2023-08-04', 250.00, 'AsxT23SW3');

-- Venda 5
INSERT INTO venda (id_funcionario, id_cliente, data_venda, valor_total, nfe) VALUES (2, 5, '2023-08-05', 300.00, 'AsxT23S13');

-- Venda 6
INSERT INTO venda (id_funcionario, id_cliente, data_venda, valor_total, nfe) VALUES (3, 6, '2023-08-06', 350.00, 'AsxT23SA4');

-- Venda 7
INSERT INTO venda (id_funcionario, id_cliente, data_venda, valor_total, nfe) VALUES (1, 7, '2023-08-07', 400.00, 'AsxT23SA2');

-- Venda 8
INSERT INTO venda (id_funcionario, id_cliente, data_venda, valor_total, nfe) VALUES (2, 8, '2023-08-08', 450.00, 'AsxT23SF3');

-- Venda 9
INSERT INTO venda (id_funcionario, id_cliente, data_venda, valor_total, nfe) VALUES (1, 9, '2023-08-09', 500.00, 'AsxT23SB3');

-- Venda 10
INSERT INTO venda (id_funcionario, id_cliente, data_venda, valor_total, nfe) VALUES (3, 10, '2023-08-10', 550.00, 'AsxT23SA3');


-- Aspirina
INSERT INTO produto (nome, preco, marca, tipo_remedio, prescricao_medica, tipo_tarja, forma_de_administracao, composicao_remedio, data_validade, data_fabricacao, secao)
VALUES ('Aspirina', 5.99, 'Bayer', 'Analgésico', FALSE, 'Tarja Livre', 'Comprimido', 'Ácido Acetilsalicílico', '2023-12-31', '2023-01-15', 'Seção: Analgésico');

-- Amoxicilina
INSERT INTO produto (nome, preco, marca, tipo_remedio, prescricao_medica, tipo_tarja, forma_de_administracao, composicao_remedio, data_validade, data_fabricacao, secao)
VALUES ('Amoxicilina', 12.99, 'Genérico', 'Antibiótico', TRUE, 'Tarja Vermelha', 'Cápsula', 'Amoxicilina Tri-hidratada', '2023-11-30', '2023-02-10', 'Seção: Antibiótico');

-- Paracetamol
INSERT INTO produto (nome, preco, marca, tipo_remedio, prescricao_medica, tipo_tarja, forma_de_administracao, composicao_remedio, data_validade, data_fabricacao, secao)
VALUES ('Paracetamol', 4.49, 'Genérico', 'Analgésico', FALSE, 'Tarja Livre', 'Comprimido', 'Paracetamol', '2024-06-15', '2023-03-20', 'Seção: Analgésicos');

-- Ibuprofeno
INSERT INTO produto (nome, preco, marca, tipo_remedio, prescricao_medica, tipo_tarja, forma_de_administracao, composicao_remedio, data_validade, data_fabricacao, secao)
VALUES ('Ibuprofeno', 6.99, 'Genérico', 'Anti-inflamatório', FALSE, 'Tarja Livre', 'Comprimido', 'Ibuprofeno', '2023-12-31', '2023-01-01', 'Seção: Anti-inflamatórios');

-- Omeprazol
INSERT INTO produto (nome, preco, marca, tipo_remedio, prescricao_medica, tipo_tarja, forma_de_administracao, composicao_remedio, data_validade, data_fabricacao, secao)
VALUES ('Omeprazol', 8.99, 'Medley', 'Antiácido', FALSE, 'Tarja Livre', 'Cápsula', 'Omeprazol', '2023-10-31', '2023-04-05', 'Seção: Antiácido');

-- Xarope para Tosse
INSERT INTO produto (nome, preco, marca, tipo_remedio, prescricao_medica, tipo_tarja, forma_de_administracao, composicao_remedio, data_validade, data_fabricacao, secao)
VALUES ('Xarope para Tosse', 7.99, 'Anti-inflamatório', 'Expectorante', FALSE, 'Tarja Livre', 'Xarope', 'Guaifenesina', '2023-09-30', '2023-05-12', 'Seção: Anti-inflamatórios');

-- Rivotril
INSERT INTO produto (nome, preco, marca, tipo_remedio, prescricao_medica, tipo_tarja, forma_de_administracao, composicao_remedio, data_validade, data_fabricacao, secao)
VALUES ('Rivotril', 18.99, 'Roche', 'Ansiolítico', TRUE, 'Tarja Preta', 'Comprimido', 'Clonazepam', '2023-08-31', '2023-06-20', 'Seção: Ansiolíticos');

-- Vacina COVID-19
INSERT INTO produto (nome, preco, marca, tipo_remedio, prescricao_medica, tipo_tarja, forma_de_administracao, composicao_remedio, data_validade, data_fabricacao, secao)
VALUES ('Vacina COVID-19', 0.00, 'Governo', 'Vacina', FALSE, 'Sem Tarja', 'Injeção', 'Vírus inativado SARS-CoV-2', '2023-12-31', '2023-07-01', 'Seção: Vacinas');

-- Pomada para Queimaduras
INSERT INTO produto (nome, preco, marca, tipo_remedio, prescricao_medica, tipo_tarja, forma_de_administracao, composicao_remedio, data_validade, data_fabricacao, secao)
VALUES ('Pomada para Queimaduras', 9.99, 'Cicatrizante', 'Cicatrizante', FALSE, 'Tarja Livre', 'Pomada', 'Dexpantenol', '2023-11-30', '2023-08-10', 'Seção: Cicatrizantes');

-- Vitamina C
INSERT INTO produto (nome, preco, marca, tipo_remedio, prescricao_medica, tipo_tarja, forma_de_administracao, composicao_remedio, data_validade, data_fabricacao, secao)
VALUES ('Vitamina C', 12.49, 'Nature''s Bounty', 'Suplemento', FALSE, 'Tarja Livre', 'Comprimido', 'Ácido Ascórbico', '2023-01-31', '2022-12-01', 'Seção: Suplementos');

INSERT INTO produto (nome, preco, marca, tipo_remedio, prescricao_medica, tipo_tarja, forma_de_administracao, composicao_remedio, data_validade, data_fabricacao, secao)
VALUES ('Bolacha', 12.49, 'TRAKINAS', 'CONSUMÍVEIS', FALSE, 'Tarja Livre', 'CONSUMÍVEIS', 'CONSUMÍVEIS', '2023-01-31', '2022-12-01', 'Seção: CONSUMÍVEIS');

INSERT INTO produto (nome, preco, marca, tipo_remedio, prescricao_medica, tipo_tarja, forma_de_administracao, composicao_remedio, data_validade, data_fabricacao, secao)
VALUES ('Refrigerante', 12.49, 'Coca-cola', 'CONSUMÍVEIS', FALSE, 'Tarja Livre', 'CONSUMÍVEIS', 'CONSUMÍVEIS', '2023-01-31', '2022-12-01', 'Seção: CONSUMÍVEIS');

INSERT INTO produto (nome, preco, marca, tipo_remedio, prescricao_medica, tipo_tarja, forma_de_administracao, composicao_remedio, data_validade, data_fabricacao, secao)
VALUES ('Suco', 12.49, 'tang', 'CONSUMÍVEIS', FALSE, 'Tarja Livre', 'CONSUMÍVEIS', 'CONSUMÍVEIS', '2023-01-31', '2022-12-01', 'Seção: CONSUMÍVEIS');

-- Lote para Aspirina
INSERT INTO lote (id_produto, nome, quantidade, origem, destino, data)
VALUES (1, 'Lote_Aspirina_01', 1000, 'Fornecedor_A', 'Farmácia Geral', '2023-12-06');

-- Lote para Amoxicilina
INSERT INTO lote (id_produto, nome, quantidade, origem, destino, data)
VALUES (2, 'Lote_Amoxicilina_01', 500, 'Fornecedor_B', 'Farmácia Geral', '2023-12-10');

-- Lote para Paracetamol
INSERT INTO lote (id_produto, nome, quantidade, origem, destino, data)
VALUES (3, 'Lote_Paracetamol_01', 800, 'Fornecedor_C', 'Farmácia Geral', '2023-12-20');

-- Lote para Ibuprofeno
INSERT INTO lote (id_produto, nome, quantidade, origem, destino, data)
VALUES (4, 'Lote_Ibuprofeno_01', 700, 'Fornecedor_D', 'Farmácia Geral', '2023-12-22');

-- Lote para Omeprazol
INSERT INTO lote (id_produto, nome, quantidade, origem, destino, data)
VALUES (5, 'Lote_Omeprazol_01', 600, 'Fornecedor_E', 'Farmácia Geral', '2024-01-01');

-- Lote para Xarope para Tosse
INSERT INTO lote (id_produto, nome, quantidade, origem, destino, data)
VALUES (6, 'Lote_Xarope_Tosse_01', 300, 'Fornecedor_F', 'Farmácia Geral', '2024-01-05');

-- Lote para Rivotril
INSERT INTO lote (id_produto, nome, quantidade, origem, destino, data)
VALUES (7, 'Lote_Rivotril_01', 200, 'Fornecedor_G', 'Farmácia de Psicotrópicos', '2024-01-10');

-- Lote para Vacina COVID-19
INSERT INTO lote (id_produto, nome, quantidade, origem, destino, data)
VALUES (8, 'Lote_Vacina_Covid_01', 1000, 'Ministério da Saúde', 'Farmácia de Vacinas', '2024-01-17');

-- Lote para Pomada para Queimaduras
INSERT INTO lote (id_produto, nome, quantidade, origem, destino, data)
VALUES (9, 'Lote_Pomada_Queimaduras_01', 400, 'Fornecedor_H', 'Farmácia de Dermatologia', '2024-01-20');

-- Lote para Vitamina C
INSERT INTO lote (id_produto, nome, quantidade, origem, destino, data)
VALUES (10, 'Lote_Vitamina_C_01', 300, 'Fornecedor_I', 'Farmácia de Suplementos', '2024-02-01');

INSERT INTO lote (id_produto, nome, quantidade, origem, destino, data)
VALUES (11, 'Lote_consumiveis_C_01', 300, 'Fornecedor_I', 'Farmácia de Suplementos', '2024-02-03');

INSERT INTO lote (id_produto, nome, quantidade, origem, destino, data)
VALUES (11, 'Lote_consumiveis_C_02', 300, 'Fornecedor_I', 'Farmácia de Suplementos', '2024-02-05');

INSERT INTO lote (id_produto, nome, quantidade, origem, destino, data)
VALUES (9, 'Lote_Pomada_Queimaduras_02', 400, 'Fornecedor_H', 'Farmácia de Dermatologia', '2024-02-09');

-- Princípio Ativo 1
INSERT INTO principio_ativo (nome) VALUES ('Ácido Acetilsalicílico');

-- Princípio Ativo 2
INSERT INTO principio_ativo (nome) VALUES ('Amoxicilina Tri-hidratada');

-- Princípio Ativo 3
INSERT INTO principio_ativo (nome) VALUES ('Paracetamol');

-- Princípio Ativo 4
INSERT INTO principio_ativo (nome) VALUES ('Ibuprofeno');

-- Princípio Ativo 5
INSERT INTO principio_ativo (nome) VALUES ('Omeprazol');

-- Princípio Ativo 6
INSERT INTO principio_ativo (nome) VALUES ('Guaifenesina');

-- Princípio Ativo 7
INSERT INTO principio_ativo (nome) VALUES ('Clonazepam');

-- Princípio Ativo 8
INSERT INTO principio_ativo (nome) VALUES ('Vírus inativado SARS-CoV-2');

-- Princípio Ativo 9
INSERT INTO principio_ativo (nome) VALUES ('Dexpantenol');

-- Princípio Ativo 10
INSERT INTO principio_ativo (nome) VALUES ('Ácido Ascórbico');

-- Inserção de vendas (venda 1)
INSERT INTO tem_venda (id_produto, id_venda, quantidade, preco, desconto) VALUES (1, 1, 5, 29.95, 0.05);
INSERT INTO tem_venda (id_produto, id_venda, quantidade, preco, desconto) VALUES (2, 1, 3, 38.97, 0.10);
INSERT INTO tem_venda (id_produto, id_venda, quantidade, preco, desconto) VALUES (3, 1, 2, 8.98, 0.00);

-- Inserção de vendas (venda 2)
INSERT INTO tem_venda (id_produto, id_venda, quantidade, preco, desconto) VALUES (4, 2, 4, 27.96, 0.10);
INSERT INTO tem_venda (id_produto, id_venda, quantidade, preco, desconto) VALUES (5, 2, 2, 17.98, 0.00);

-- Inserção de vendas (venda 3)
INSERT INTO tem_venda (id_produto, id_venda, quantidade, preco, desconto) VALUES (6, 3, 3, 23.97, 0.00);

-- Inserção de vendas (venda 4)
INSERT INTO tem_venda (id_produto, id_venda, quantidade, preco, desconto) VALUES (7, 4, 1, 18.99, 0.05);

-- Inserção de vendas (venda 5)
INSERT INTO tem_venda (id_produto, id_venda, quantidade, preco, desconto) VALUES (8, 5, 2, 0.00, 0.10);

-- Inserção de vendas (venda 6)
INSERT INTO tem_venda (id_produto, id_venda, quantidade, preco, desconto) VALUES (9, 6, 1, 9.99, 0.00);

-- Inserção de vendas (venda 7)
INSERT INTO tem_venda (id_produto, id_venda, quantidade, preco, desconto) VALUES (10, 7, 4, 49.96, 0.05);

-- Fornecedor 1 fornecendo Lote 1 para Filial 1
INSERT INTO fornece (id_fornecedor, id_lote, id_filial) VALUES (1, 1, 1);

-- Fornecedor 2 fornecendo Lote 2 para Filial 1
INSERT INTO fornece (id_fornecedor, id_lote, id_filial) VALUES (2, 2, 1);

-- Fornecedor 3 fornecendo Lote 3 para Filial 1
INSERT INTO fornece (id_fornecedor, id_lote, id_filial) VALUES (3, 3, 1);

-- Fornecedor 4 fornecendo Lote 4 para Filial 2
INSERT INTO fornece (id_fornecedor, id_lote, id_filial) VALUES (4, 4, 2);

-- Fornecedor 5 fornecendo Lote 5 para Filial 2
INSERT INTO fornece (id_fornecedor, id_lote, id_filial) VALUES (4, 5, 2);

-- Fornecedor 6 fornecendo Lote 6 para Filial 2
INSERT INTO fornece (id_fornecedor, id_lote, id_filial) VALUES (3, 6, 2);

-- Fornecedor 7 fornecendo Lote 7 para Filial 2
INSERT INTO fornece (id_fornecedor, id_lote, id_filial) VALUES (2, 7, 2);

-- Fornecedor 8 fornecendo Lote 8 para Filial 2
INSERT INTO fornece (id_fornecedor, id_lote, id_filial) VALUES (1, 8, 2);

-- Fornecedor 9 fornecendo Lote 9 para Filial 3
INSERT INTO fornece (id_fornecedor, id_lote, id_filial) VALUES (2, 9, 3);

-- Fornecedor 10 fornecendo Lote 10 para Filial 3
INSERT INTO fornece (id_fornecedor, id_lote, id_filial) VALUES (4, 10, 3);

INSERT INTO fornece (id_fornecedor, id_lote, id_filial) VALUES (4, 11, 3);

INSERT INTO fornece (id_fornecedor, id_lote, id_filial) VALUES (1, 12, 2);

-- Produto 1 tem Principio Ativo 1
INSERT INTO produto_tem_principio (id_produto, id_principio) VALUES (1, 1);

-- Produto 2 tem Principio Ativo 2
INSERT INTO produto_tem_principio (id_produto, id_principio) VALUES (2, 2);

-- Produto 3 tem Principio Ativo 3
INSERT INTO produto_tem_principio (id_produto, id_principio) VALUES (3, 3);

-- Produto 4 tem Principio Ativo 4
INSERT INTO produto_tem_principio (id_produto, id_principio) VALUES (4, 4);

-- Produto 5 tem Principio Ativo 5
INSERT INTO produto_tem_principio (id_produto, id_principio) VALUES (5, 5);

-- Produto 6 tem Principio Ativo 6
INSERT INTO produto_tem_principio (id_produto, id_principio) VALUES (6, 6);

-- Produto 7 tem Principio Ativo 7
INSERT INTO produto_tem_principio (id_produto, id_principio) VALUES (7, 7);

-- Produto 8 tem Principio Ativo 8
INSERT INTO produto_tem_principio (id_produto, id_principio) VALUES (8, 8);

-- Produto 9 tem Principio Ativo 9
INSERT INTO produto_tem_principio (id_produto, id_principio) VALUES (9, 9);

-- Produto 10 tem Principio Ativo 10
INSERT INTO produto_tem_principio (id_produto, id_principio) VALUES (10, 10);

-- Produto 1 pertence à Classe 1
INSERT INTO classe (nome) VALUES ('Classe Analgésico');

-- Produto 2 pertence à Classe 2
INSERT INTO classe (nome) VALUES ('Classe Antibiótico');

-- Produto 3 pertence à Classe 3
INSERT INTO classe (nome) VALUES ('Classe Analgésicos');

-- Produto 4 pertence à Classe 1
INSERT INTO classe (nome) VALUES ('Classe Analgésico');

-- Produto 5 pertence à Classe 2
INSERT INTO classe (nome) VALUES ('Classe Anti-inflamatório');

-- Produto 6 pertence à Classe 3
INSERT INTO classe (nome) VALUES ('Classe Anti-inflamatório');

-- Produto 7 pertence à Classe 1
INSERT INTO classe (nome) VALUES ('Classe Ansiolítico');

-- Produto 8 pertence à Classe 2
INSERT INTO classe (nome) VALUES ('Classe Antiácido');

-- Produto 9 pertence à Classe 3
INSERT INTO classe (nome) VALUES ('Classe Cicatrizante');

-- Produto 10 pertence à Classe 1
INSERT INTO classe (nome) VALUES ('Classe Suplemento');

INSERT INTO classe (nome) VALUES ('Classe Consumíveis');

-- Inserir relacionamentos entre classe e produto

-- Produto 1 pertence à Classe 1
INSERT INTO tem_classe (numeroitem, id_produto, id_classe) VALUES (1, 1, 1);

INSERT INTO tem_classe (numeroitem, id_produto, id_classe) VALUES (2, 1, 3);

-- Produto 2 pertence à Classe 2
INSERT INTO tem_classe (numeroitem, id_produto, id_classe) VALUES (1, 2, 2);

INSERT INTO tem_classe (numeroitem, id_produto, id_classe) VALUES (2, 2, 4);

-- Produto 3 pertence à Classe 3
INSERT INTO tem_classe (numeroitem, id_produto, id_classe) VALUES (1, 3, 3);

-- Produto 4 pertence à Classe 1
INSERT INTO tem_classe (numeroitem, id_produto, id_classe) VALUES (1, 4, 1);

-- Produto 5 pertence à Classe 2
INSERT INTO tem_classe (numeroitem, id_produto, id_classe) VALUES (1, 5, 2);

-- Produto 6 pertence à Classe 3
INSERT INTO tem_classe (numeroitem, id_produto, id_classe) VALUES (1, 6, 3);

INSERT INTO tem_classe (numeroitem, id_produto, id_classe) VALUES (2, 6, 1);

-- Produto 7 pertence à Classe 1
INSERT INTO tem_classe (numeroitem, id_produto, id_classe) VALUES (1, 7, 1);

-- Produto 8 pertence à Classe 2
INSERT INTO tem_classe (numeroitem, id_produto, id_classe) VALUES (1, 8,  2);

-- Produto 9 pertence à Classe 3
INSERT INTO tem_classe (numeroitem, id_produto, id_classe) VALUES (1, 9, 3);

-- Produto 10 pertence à Classe 1
INSERT INTO tem_classe (numeroitem, id_produto, id_classe) VALUES (1, 10, 1);

-- Produto 11 pertence à Classe Consumíveis
INSERT INTO tem_classe (numeroitem, id_produto, id_classe) VALUES (1, 11, 4);