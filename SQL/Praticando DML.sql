--- CONSULTAS SIMPLES

-- 1) Trazer todos os funcionários cadastrados, informando o nome e a data de admissao (data de cadastro)
SELECT
    NM_FUNCIONARIO,
    DT_CADASTRAMENTO
FROM
    DB_FUNCIONARIO

-- 2) Selecionar todos os funcionarios cadastrados, informando o nome e o salario bruto.
-- Mostrar dois campos calculados projetando um aumento salarial de 5% e de 8%.
SELECT
    NM_FUNCIONARIO,
    VL_SALARIO_BRUTO,
    VL_SALARIO_BRUTO * 0.05 AS "AUMENTO 5%",
    VL_SALARIO_BRUTO * 0.08 AS "AUMENTO 8%"
FROM
    DB_FUNCIONARIO

-- 3) Selecionar todos os clientes cadastrados, informando o nome e a quantidade de estrelas;
SELECT
    NM_CLIENTE,
    QT_ESTRELAS
FROM
    DB_CLIENTE

-- 4) Trazer todos os produtos cadastrados, mostrando o descritivo do produto e o valor unitario.
SELECT
    DS_PRODUTO,
    VL_UNITARIO
FROM
    DB_PRODUTO


--- CONSULTA COM CONDICOES
-- 1) Trazer todos os clientes que possuam 4 ou mais estrelas;
SELECT
    NM_CLIENTE,
    QT_ESTRELAS
FROM
    DB_CLIENTE
WHERE QT_ESTRELAS >= 4
ORDER BY QT_ESTRELAS DESC
    
-- 2) Selecionar todos os clientes que possuem 3 estrelas ou mais e que tenham o 
-- o valor medio de compra maior que R$ 70,00;
SELECT
    NM_CLIENTE,
    QT_ESTRELAS
FROM
    DB_CLIENTE
WHERE QT_ESTRELAS >= 4
ORDER BY QT_ESTRELAS DESC


-- 3) Trazer todos os clientes com o valor medio de compra acima de R$ 80,00
-- informando o nome e a quantidade de estrelas;
SELECT
    NM_CLIENTE,
    QT_ESTRELAS,
    VL_MEDIO_COMPRA
FROM
    DB_CLIENTE
WHERE VL_MEDIO_COMPRA > 80
ORDER BY VL_MEDIO_COMPRA DESC


-- 4) Listar todos os produtos que possuam um valor unitario maior que R$ 15,00
SELECT
    DS_PRODUTO,
    VL_UNITARIO
FROM
    DB_PRODUTO
WHERE VL_UNITARIO > 15
ORDER BY VL_UNITARIO DESC


--- DESAFIO
-- 1) Listar todos os pedidos do primeiro trimestre do ultimo ano disponivel na base;

SELECT -- Descobrindo o maior ano da base.
    DISTINCT DT_PEDIDO
FROM
    DB_PEDIDO
WHERE TO_CHAR(DT_PEDIDO, 'YYYY') > 2000
ORDER BY DT_PEDIDO DESC

SELECT * FROM DB_PEDIDO
WHERE TO_DATE(DT_PEDIDO, 'DD-MM-YY')
BETWEEN '01-01-21' AND '31-03-21'


-- 2) Selecionar todos os profissionais cadastrados nos meses de novembro e dezembro;


-- 3) Mostrar todos os pedidos realizados no ano de 2018.










