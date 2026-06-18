select * from layoff_staging1;

select company, sum(total_laid_off) from layoff_staging1
group by company  
order by sum(total_laid_off) DESC;

select country, sum(total_laid_off) from layoff_staging1
group by country
order by sum(total_laid_off) DESC;

select stage, sum(total_laid_off)
from layoff_staging1
group by stage
order by sum(total_laid_off) desc;

select country, company, sum(total_laid_off) from layoff_staging1
group by country, company
order by sum(total_laid_off) DESC;

select country, location, sum(total_laid_off) from layoff_staging1
group by country, location
order by sum(total_laid_off) DESC;

select country, company, industry, sum(total_laid_off) from layoff_staging1
group by country, company, industry
order by sum(total_laid_off) DESC;

WITH Company_Totals AS (
    SELECT 
        company,
        SUM(total_laid_off) AS combined_laid_off,
        DENSE_RANK() OVER(ORDER BY SUM(total_laid_off) DESC) AS company_rank
    FROM layoff_staging1
    GROUP BY company
)
SELECT company, combined_laid_off, company_rank
FROM Company_Totals
WHERE company_rank <= 5;

WITH Industry_Totals AS (
    SELECT 
        industry,
        SUM(total_laid_off) AS combined_laid_off,
        DENSE_RANK() OVER(ORDER BY SUM(total_laid_off) DESC) AS industry_rank
    FROM layoff_staging1
    GROUP BY industry
)
SELECT industry, combined_laid_off, industry_rank
FROM Industry_Totals
WHERE industry_rank <= 5;

select max(`date`) , min(`date`)
from layoff_staging1;

select year(`date`) date_year, sum(total_laid_off)
from layoff_staging1
where `date` is not null
group by date_year
order by date_year;

WITH year_total AS (
    SELECT 
        year(`date`) year_date,
        company,
        SUM(total_laid_off) AS combined_laid_off,
        DENSE_RANK() OVER(ORDER BY SUM(total_laid_off) DESC) AS year_rank
    FROM layoff_staging1
    GROUP BY year_date,company
)
SELECT year_date, company,combined_laid_off, year_rank
FROM year_total
WHERE year_rank <= 5; 


WITH Yearly_Totals AS (
    SELECT 
        YEAR(`date`) AS year_date,
        SUM(total_laid_off) AS year_sum
    FROM layoff_staging1
    GROUP BY YEAR(`date`)
)
SELECT 
    year_date,
    year_sum,
    SUM(year_sum) OVER(ORDER BY year_date) AS rolling_total
FROM Yearly_Totals
ORDER BY year_date;


WITH Company_Yearly_Totals AS (
    SELECT 
        YEAR(`date`) AS layoff_year,
        company,
        SUM(total_laid_off) AS total_laid_off,
        DENSE_RANK() OVER(
            PARTITION BY YEAR(`date`) 
            ORDER BY SUM(total_laid_off) DESC
        ) AS yearly_rank
    FROM layoff_staging1
    WHERE `date` IS NOT NULL 
    GROUP BY YEAR(`date`), company
)
SELECT 
    layoff_year,
    company,
    total_laid_off,
    yearly_rank
FROM Company_Yearly_Totals
WHERE yearly_rank <= 5
ORDER BY layoff_year DESC, yearly_rank ASC;

with cte_daily_layoff as
(
select `date` layoff_date, sum(total_laid_off) daily_layoff
from layoff_staging1
group by `date`
)
select layoff_date, daily_layoff, sum(daily_layoff) over (order by layoff_date) running_total
from cte_daily_layoff;


