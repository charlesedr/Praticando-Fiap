/*
Charles Eduardo dos Santos - RM 553653
*/

/* 1) Supondo que, com 55 anos de idade, uma pessoa se aposente. Quais são os profissionais que estarão aposentados em 2025 ? */
SELECT 
    UPPER(NM_FUNCIONARIO)                                                               AS NOME_FUNC,
    DT_NASCIMENTO                                                                       AS DT_NASC,
    TRUNC(MONTHS_BETWEEN(TO_DATE('2025-01-01', 'YYYY-MM-DD'), DT_NASCIMENTO) / 12)      AS IDADE_EM_2025
FROM DB_FUNCIONARIO
    WHERE TRUNC(MONTHS_BETWEEN(TO_DATE('2025-01-01', 'YYYY-MM-DD'), DT_NASCIMENTO) / 12) >= 55
    ORDER BY IDADE_EM_2025 DESC;


/* 2) Quais funcionários não estarão aposentados em 2025 e quanto anos faltarão para se aposentarem ? */
SELECT 
    UPPER(NM_FUNCIONARIO)                                                                   AS NOME_FUNC, 
    DT_NASCIMENTO                                                                           AS DT_NASC,
    TRUNC(MONTHS_BETWEEN(TO_DATE('2025-01-01', 'YYYY-MM-DD'), DT_NASCIMENTO) / 12)          AS IDADE_EM_2025,
    CASE
        WHEN TRUNC(MONTHS_BETWEEN(TO_DATE('2025-01-01', 'YYYY-MM-DD'), DT_NASCIMENTO) / 12) >= 55 THEN 'SIM'
        ELSE 'NÃO'
    END                                                                                     AS APOSENTADO_EM_2025,
    CASE
        WHEN TRUNC(MONTHS_BETWEEN(TO_DATE('2025-01-01', 'YYYY-MM-DD'), DT_NASCIMENTO) / 12) >= 55 THEN 0
        ELSE 55 - TRUNC(MONTHS_BETWEEN(TO_DATE('2025-01-01', 'YYYY-MM-DD'), DT_NASCIMENTO) / 12)
    END                                                                                     AS ANOS_PARA_APOSENTAR
FROM DB_FUNCIONARIO
    WHERE TRUNC(MONTHS_BETWEEN(TO_DATE('2025-01-01', 'YYYY-MM-DD'), DT_NASCIMENTO) / 12) < 55
    ORDER BY ANOS_PARA_APOSENTAR ASC;


/* 3) Supondo que, após se aposentar, o funcionaio passe a receber 70% do valor de seu salário atual, quanto ele recebera ? */
SELECT 
    UPPER(NM_FUNCIONARIO)                               AS NOME_FUNC,
    TRUNC(MONTHS_BETWEEN(SYSDATE, DT_NASCIMENTO) / 12)  AS IDADE,
    ROUND(VL_SALARIO_BRUTO, 2)                          AS SALARIO_ATUAL,
    ROUND((VL_SALARIO_BRUTO * 0.7), 2)                  AS SALARIO_APOSENTADO
FROM DB_FUNCIONARIO
    ORDER BY SALARIO_ATUAL DESC;


/* 4) Faça uma consulta que demonstre a quantidade de lojas que temos por UF. */
SELECT 
    est.SG_ESTADO, 
    COUNT(loj.NR_LOJA) AS QTD_LOJAS
FROM DB_LOJA loj
    JOIN DB_END_LOJA el         ON loj.NR_LOJA = el.NR_LOJA
    JOIN DB_LOGRADOURO log      ON el.CD_LOGRADOURO = log.CD_LOGRADOURO
    JOIN DB_BAIRRO bai          ON log.CD_BAIRRO = bai.CD_BAIRRO
    JOIN DB_CIDADE cid          ON bai.CD_CIDADE = cid.CD_CIDADE
    JOIN DB_ESTADO est          ON cid.SG_ESTADO = est.SG_ESTADO
        GROUP BY est.SG_ESTADO
        ORDER BY QTD_LOJAS DESC;


/* 5) Faça uma consulta que demostre a quantidade de pedidos que tivemos por loja e ano. */
SELECT
    loj.NR_LOJA || ' - ' ||UPPER(loj.NM_LOJA)               AS LOJA,
    TO_CHAR(ped.DT_PEDIDO, 'YYYY')                          AS ANO_PEDIDO,
    COUNT(ped.NR_PEDIDO)                                    AS QTD_PEDIDOS
FROM DB_PEDIDO ped
JOIN DB_LOJA loj       ON ped.NR_LOJA = loj.NR_LOJA
    GROUP BY loj.NR_LOJA, loj.NM_LOJA, TO_CHAR(ped.DT_PEDIDO, 'YYYY')
    ORDER BY LOJA, ANO_PEDIDO;


/* 6) Faça uma consulta que demonstre o valor total vendido (VL_UNITARIO * QTD_PEDIDO) por categoria de produtos, nas lojas da cidade de São Paulo, no ano de 2019. */

-- verificando com as lojas e suas cidades
/*
SELECT
->    loj.NR_LOJA,
->    loj.NM_LOJA,
    TO_CHAR(ped.DT_PEDIDO, 'YYYY')         AS ANO,
    cid.NM_CIDADE                          AS CIDADE,
    cat.DS_CATEGORIA_PROD                  AS CAT_PROD,
    SUM(iped.VL_UNITARIO * iped.QT_PEDIDO) AS VLR_TT_VENDIDO
FROM DB_PEDIDO ped
    JOIN DB_ITEM_PEDIDO iped             ON ped.NR_PEDIDO = iped.NR_PEDIDO AND ped.NR_LOJA = iped.NR_LOJA
    JOIN DB_PRODUTO_LOJA ploj            ON iped.CD_PRODUTO_LOJA = ploj.CD_PRODUTO_LOJA
    JOIN DB_PRODUTO prod                 ON ploj.CD_PRODUTO = prod.CD_PRODUTO
    JOIN DB_SUB_CATEGORIA_PROD scat      ON prod.CD_SUB_CATEGORIA_PROD = scat.CD_SUB_CATEGORIA_PROD
    JOIN DB_CATEGORIA_PROD cat           ON scat.CD_CATEGORIA_PROD = cat.CD_CATEGORIA_PROD
    JOIN DB_LOJA loj                     ON ped.NR_LOJA = loj.NR_LOJA
    JOIN DB_END_LOJA eloj                ON loj.NR_LOJA = eloj.NR_LOJA
    JOIN DB_LOGRADOURO log               ON eloj.CD_LOGRADOURO = log.CD_LOGRADOURO
    JOIN DB_BAIRRO bai                   ON log.CD_BAIRRO = bai.CD_BAIRRO
    JOIN DB_CIDADE cid                   ON bai.CD_CIDADE = cid.CD_CIDADE 
        WHERE cid.NM_CIDADE = 'São Paulo' AND TO_CHAR(ped.DT_PEDIDO, 'YYYY') = '2019'
        GROUP BY TO_CHAR(ped.DT_PEDIDO, 'YYYY'), cid.NM_CIDADE, cat.DS_CATEGORIA_PROD, loj.NR_LOJA, loj.NM_LOJA
        ORDER BY VLR_TT_VENDIDO DESC;
*/

SELECT
    TO_CHAR(ped.DT_PEDIDO, 'YYYY')              AS ANO,
    cid.NM_CIDADE                               AS CIDADE,
    cat.DS_CATEGORIA_PROD                       AS CAT_PROD,
    SUM(iped.VL_UNITARIO * iped.QT_PEDIDO)      AS VLR_TT_VENDIDO
FROM DB_PEDIDO ped
    JOIN DB_ITEM_PEDIDO iped             ON ped.NR_PEDIDO = iped.NR_PEDIDO AND ped.NR_LOJA = iped.NR_LOJA
    JOIN DB_PRODUTO_LOJA ploj            ON iped.CD_PRODUTO_LOJA = ploj.CD_PRODUTO_LOJA
    JOIN DB_PRODUTO prod                 ON ploj.CD_PRODUTO = prod.CD_PRODUTO
    JOIN DB_SUB_CATEGORIA_PROD scat      ON prod.CD_SUB_CATEGORIA_PROD = scat.CD_SUB_CATEGORIA_PROD
    JOIN DB_CATEGORIA_PROD cat           ON scat.CD_CATEGORIA_PROD = cat.CD_CATEGORIA_PROD
    JOIN DB_LOJA loj                     ON ped.NR_LOJA = loj.NR_LOJA
    JOIN DB_END_LOJA eloj                ON loj.NR_LOJA = eloj.NR_LOJA
    JOIN DB_LOGRADOURO log               ON eloj.CD_LOGRADOURO = log.CD_LOGRADOURO
    JOIN DB_BAIRRO bai                   ON log.CD_BAIRRO = bai.CD_BAIRRO
    JOIN DB_CIDADE cid                   ON bai.CD_CIDADE = cid.CD_CIDADE 
        WHERE cid.NM_CIDADE = 'São Paulo' AND TO_CHAR(ped.DT_PEDIDO, 'YYYY') = '2019'
        GROUP BY TO_CHAR(ped.DT_PEDIDO, 'YYYY'), cid.NM_CIDADE, cat.DS_CATEGORIA_PROD
        ORDER BY VLR_TT_VENDIDO DESC;

/* 7) Faça uam consulta que demonstre as 3 lojas que mais venderam em 2018. */
SELECT
    loj.NR_LOJA,
    loj.NM_LOJA,
    SUM(VL_UNITARIO * QT_PEDIDO) AS VLR_TT_VENDIDO
FROM DB_PEDIDO ped
    JOIN DB_ITEM_PEDIDO iped            ON ped.NR_PEDIDO = iped.NR_PEDIDO AND ped.NR_LOJA = iped.NR_LOJA
    JOIN DB_LOJA loj                    ON ped.NR_LOJA = loj.NR_LOJA
        WHERE TO_CHAR(ped.DT_PEDIDO, 'YYYY') = '2018'
        GROUP BY loj.NR_LOJA, loj.NM_LOJA
        ORDER BY VLR_TT_VENDIDO DESC
        FETCH FIRST 3 ROWS ONLY;


/* 8) Demonstre o ranque dos 20 produtos mais vendidos em 2019, no Estado do RJ. */
SELECT 
    TO_CHAR(PED.DT_PEDIDO, 'YYYY')      AS ANO,
    cid.SG_ESTADO,
    prod.DS_PRODUTO,
    SUM(iped.QT_PEDIDO)                 AS TOTAL_QT_PEDIDO
FROM DB_PEDIDO ped
    JOIN DB_ITEM_PEDIDO iped            ON ped.NR_PEDIDO = iped.NR_PEDIDO
    JOIN DB_LOJA loj                    ON ped.NR_LOJA = loj.NR_LOJA
    JOIN DB_PRODUTO_LOJA ploj           ON iped.CD_PRODUTO_LOJA = ploj.CD_PRODUTO_LOJA
    JOIN DB_PRODUTO prod                ON ploj.CD_PRODUTO = prod.CD_PRODUTO
    JOIN DB_END_LOJA eloj               ON loj.NR_LOJA = eloj.NR_LOJA
    JOIN DB_LOGRADOURO log              ON eloj.CD_LOGRADOURO = log.CD_LOGRADOURO
    JOIN DB_BAIRRO bai                  ON log.CD_BAIRRO = bai.CD_BAIRRO
    JOIN DB_CIDADE cid                  ON bai.CD_CIDADE = cid.CD_CIDADE
        WHERE TO_CHAR(PED.DT_PEDIDO, 'YYYY') = '2019' AND CID.SG_ESTADO = 'RJ'
        GROUP BY TO_CHAR(PED.DT_PEDIDO, 'YYYY'), cid.SG_ESTADO, prod.DS_PRODUTO
        ORDER BY TOTAL_QT_PEDIDO DESC
        FETCH FIRST 20 ROWS ONLY;

