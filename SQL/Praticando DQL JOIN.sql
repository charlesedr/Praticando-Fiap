/* _____________________________________________________________________________
1) Trazer todos os funcionarios listando nome, data de nascimento e a descricao do cargo.
Na duvida fiz com Inner e com Left da Tabela Funcionarios, ambos trouxeram o mesmo resultado (306 registros) e se fosse para escolher, escolheria a LEFT. 
Mas com isso podemos ver que nao tem funcionario sem cargo cadastrado.

SELECT
    NM_FUNCIONARIO  AS Nome_Funcionario,
    DT_NASCIMENTO   AS Data_Nascimento,
    DS_CARGO        AS Descricao_Cargo
FROM 
    DB_FUNCIONARIO f, DB_CARGO c
WHERE f.CD_CARGO = c.CD_CARGO
ORDER BY NM_FUNCIONARIO;
*/

SELECT
    NM_FUNCIONARIO  AS Nome_Funcionario,
    DT_NASCIMENTO   AS Data_Nascimento,
    DS_CARGO        AS Descricao_Cargo
FROM DB_FUNCIONARIO f
LEFT JOIN DB_CARGO c
ON f.CD_CARGO = c.CD_CARGO
ORDER BY NM_FUNCIONARIO;


/* _____________________________________________________________________________
2) Selecionar todos os clientes pessoa fisica, listando: 
codigo, nome, CPF e endereco completo (independente se o cliente possuir endereco cadastrado).*/
SELECT
    cli.NR_CLIENTE          AS Cod_cliente,
    cli.NM_CLIENTE          AS Nome_Cliente,
    clf.NR_CPF              AS Num_CPF,
    end.CD_LOGRADOURO_CLI   AS Cod_Endereco,
    log.NM_LOGRADOURO       AS Endereco,
    end.NR_END              AS Num_Endereco,
    log.NR_CEP              AS Cep,
    bai.NM_BAIRRO           AS Bairro,
    cid.NM_CIDADE           AS Cidade,
    est.NM_ESTADO           AS Estado
FROM DB_CLI_FISICA clf 
LEFT JOIN DB_CLIENTE cli       ON cli.NR_CLIENTE = clf.NR_CLIENTE
LEFT JOIN DB_END_CLI end       ON cli.NR_CLIENTE = end.NR_CLIENTE
LEFT JOIN DB_LOGRADOURO log    ON end.CD_LOGRADOURO_CLI = log.CD_LOGRADOURO
LEFT JOIN DB_BAIRRO bai        ON log.CD_BAIRRO = bai.CD_BAIRRO
LEFT JOIN DB_CIDADE cid        ON bai.CD_CIDADE = cid.CD_CIDADE 
LEFT JOIN DB_ESTADO est        ON cid.SG_ESTADO = est.SG_ESTADO
ORDER BY clf.NR_CLIENTE DESC;

/* _____________________________________________________________________________
3) Selecionar todos os pedidos realizados em 2019 listando
o numero de pedido, o nome do motoboy, descricao do cargo (do motoboy) e o nome do cliente. */
SELECT 
    ped.DT_PEDIDO           AS Data_Pedido,
    ped.NR_PEDIDO           AS Num_Pedido,
    ped.CD_FUNC_MOTOBOY     AS Cod_Motoboy,
    fun.NM_FUNCIONARIO      AS Nome_Motoboy,
    car.DS_CARGO            AS Cargo_Motoboy,
    cli.NM_CLIENTE          AS Nome_Cliente
FROM DB_PEDIDO ped 
LEFT JOIN DB_FUNCIONARIO fun        ON ped.CD_FUNC_MOTOBOY = fun.CD_FUNCIONARIO 
INNER JOIN DB_CARGO car             ON fun.CD_CARGO = car.CD_CARGO
INNER JOIN DB_END_CLI end           ON ped.NR_CLIENTE = end.NR_CLIENTE 
INNER JOIN DB_CLIENTE cli           ON end.NR_CLIENTE = cli.NR_CLIENTE 
WHERE car.DS_CARGO = 'Entregador Delivery' 
AND ped.DT_PEDIDO >= '01-01-2019' AND ped.DT_PEDIDO <= '31-12-2019'
ORDER BY ped.DT_PEDIDO DESC;

/* _____________________________________________________________________________
4) Selecionar todos os pedidos realizados pela atendente Juliana Moribe, listando: 
o numero do pedido, a data do pedido e a data prevista de entrega. Ordenando pela data do pedido. */
SELECT
    p.NR_PEDIDO         AS Num_Pedido,
    p.DT_PEDIDO         AS Data_Pedido,
    p.DT_PREV_ENTREGA   AS Data_Prevista,
    f.NM_FUNCIONARIO    AS Nome_Funcionario,
    p.DT_PEDIDO - p.DT_PREV_ENTREGA AS SLA_Entrega -- (tudo zerado, indica que o recurso pode nao estar sendo utilizado)
FROM DB_PEDIDO p
INNER JOIN DB_FUNCIONARIO f     ON p.CD_FUNC_ATD = f.CD_FUNCIONARIO 
INNER JOIN DB_CARGO c           ON f.CD_CARGO = c.CD_CARGO 
WHERE f.NM_FUNCIONARIO = 'Juliana Moribe' 
ORDER BY p.DT_PEDIDO DESC;

/* _____________________________________________________________________________
5) Listar todas as lojas do Estado da Bahia, trazendo: 
numero da loja, nome da loja, nome da cidade e sigla da UF. */
SELECT
    l.NR_LOJA,
    l.NM_LOJA,
    c.NM_CIDADE,
    e.SG_ESTADO
FROM DB_LOJA l
INNER JOIN DB_END_LOJA el       ON l.NR_LOJA = el.NR_LOJA
INNER JOIN DB_LOGRADOURO ll     ON el.CD_LOGRADOURO = ll.CD_LOGRADOURO
INNER JOIN DB_BAIRRO b          ON ll.CD_BAIRRO = b.CD_BAIRRO 
INNER JOIN DB_CIDADE c          ON b.CD_CIDADE = c.CD_CIDADE 
INNER JOIN DB_ESTADO e          ON c.SG_ESTADO = e.SG_ESTADO 
WHERE e.SG_ESTADO = 'BA';

/* _____________________________________________________________________________
6) Listar todos os funcionarios com o cargo de "Chapeiro". 
Trazer o nome do funcionario, data de cadastro, nome do departamento e cargo. */
SELECT
    f.NM_FUNCIONARIO        AS Nome_Funcionario,
    f.DT_CADASTRAMENTO      AS Data_Cadastro,
    d.NM_DEPTO              AS Departamento,
    c.DS_CARGO              AS Cargo
FROM DB_FUNCIONARIO f
INNER JOIN DB_CARGO c   ON f.CD_CARGO = c.CD_CARGO
INNER JOIN DB_DEPTO d   ON c.CD_DEPTO = d.CD_DEPTO
WHERE c.DS_CARGO = 'Chapeiro'
ORDER BY f.DT_CADASTRAMENTO DESC;
        






