# 📅 Gerador de Calendário Personalizado em SQL Server

Este script SQL cria uma tabela de calendário completa e personalizável diretamente no SQL Server, ideal para projetos de BI e Data Warehousing (como Power BI, Analysis Services ou relatórios em SQL puro).

## 🔧 Funcionalidades

- Suporte a **Ano Fiscal** com mês de início configurável (ex: Abril = 4)
- **Nomes de meses e dias da semana em português (pt-BR)**
- Colunas auxiliares para:
  - Trimestre, bimestre
  - Semana do ano, dia do ano
  - Finais de semana (flag)
  - `MESANO_NUM` para ordenação no formato `YYYYMM`
  - `MESNUM_CONTINUO` para análise de séries temporais ao longo dos anos
- Totalmente gerado via **CTE recursiva**
- Compatível com qualquer intervalo de anos (recursão dinâmica)

## ⚙️ Como Usar

1. Defina os seguintes parâmetros no início do script:
   ```sql
   DECLARE @AnoInicio INT = 2020;
   DECLARE @AnoFim INT = 2026;
   DECLARE @PeriodoFiscalInicio INT = 4;  -- Abril
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/gustavo-barbosa-868976236/)  [![Email](https://img.shields.io/badge/Email-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:gustavobarbosa7744@gmail.com)
