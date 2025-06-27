-- Gerador de Calendário Personalizado em SQL Server

SET LANGUAGE Portuguese;
SET DATEFIRST 7;  -- Domingo como primeiro dia da semana (ajusta nomes da semana corretamente)

DECLARE @AnoInicio INT = 2020;
DECLARE @AnoFim INT = 2026;
DECLARE @PeriodoFiscalInicio INT = 4;  -- Ex: ano fiscal começa em Abril
DECLARE @DATAInicio DATE = DATEFROMPARTS(@AnoInicio, 1, 1);
DECLARE @DATAFim DATE = DATEFROMPARTS(@AnoFim, 12, 31);

-- Cálculo dinâmico de recursão máxima (número de dias entre início e fim)
DECLARE @MaxRecursion INT = DATEDIFF(DAY, @DATAInicio, @DATAFim) + 1;

-- CTE Recursiva para gerar o calendário completo
WITH CALENDARIO AS (
    SELECT 
	CAST(@DATAInicio AS DATE) AS DATA
	
    UNION ALL
	
    SELECT 
	DATEADD(DAY, 1, DATA)
    FROM 
	CALENDARIO
    WHERE 
	DATA < @DATAFim
)

SELECT
    DATA					  AS DATA
    ,YEAR(DATA)					  AS ANO
    ,MONTH(DATA)				  AS MES
    ,FORMAT(DATA, 'MMMM', 'pt-BR')		  AS NOME_MES
    ,FORMAT(DATA, 'MMM-yyyy', 'pt-BR')	          AS MES_ANO
    ,RIGHT('0' + CAST(MONTH(DATA) AS VARCHAR), 2) AS MES_FORMATO
    ,FORMAT(DATA, 'dddd', 'pt-BR')		  AS NOME_DIA
    ,DATEPART(WEEKDAY, DATA)			  AS DIA_SEMANA
    ,DATEPART(DAY, DATA)			  AS DIA_MES
    ,DATEPART(DAYOFYEAR, DATA)			  AS DIA_ANO
    ,DATEPART(WEEK, DATA)			  AS SEMANA_ANO
    ,CONCAT(DATEPART(QUARTER, DATA), 'º')	  AS TRIMESTRE
    ,CEILING(MONTH(DATA) / 2.0)			  AS BIMESTRE
    ,YEAR(DATA) * 100 + MONTH(DATA)		  AS MESANO_NUM -- Para ordenação yyyyMM
    ,(YEAR(DATA) - @AnoInicio) * 12 + MONTH(DATA) AS MESNUM_CONTINUO  -- JAN-2020 = 1, JAN-2021 = 13 etc
    ,IIF(DATEPART(WEEKDAY, DATA) IN (1, 7), 1, 0) AS FINAL_SEMANA
    ,FORMAT(DATA, 'yyyy-MM-dd')		  	  AS CHAVE_DATA
    ,CASE 
	  WHEN DATA <= CAST(GETDATE() AS DATE) THEN 'SIM' 
	  WHEN DATA > CAST(GETDATE() AS DATE)  THEN 'NAO'
     END AS PASSADO
    -- Cálculo Fiscal
    ,CASE 
        WHEN MONTH(DATA) >= @PeriodoFiscalInicio THEN YEAR(DATA) + 1
        ELSE YEAR(DATA)
    END AS ANO_FISCAL
    ,CASE 
        WHEN MONTH(DATA) >= @PeriodoFiscalInicio 
        THEN MONTH(DATA) - @PeriodoFiscalInicio + 1
        ELSE MONTH(DATA) + (12 - @PeriodoFiscalInicio + 1)
    END AS MES_FISCAL
FROM 
    CALENDARIO
OPTION 
    (MAXRECURSION 0);  
