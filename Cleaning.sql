SELECT * FROM company_layoff.layoffs;

select * from layoff_staging;

create table layoff_staging 
like layoffs;

insert layoff_staging
select * from layoffs;

with CTE_duplicate as
(
	select * ,
    row_number() over( partition by company, location, industry, total_laid_off, `date`, stage, country, funds_raised_millions) as Row_num
    from layoff_staging
) 

select * from CTE_duplicate
where Row_num >1;

CREATE TABLE `layoff_staging1` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from layoff_staging1;

insert into layoff_staging1
select * ,
row_number() over( partition by company, location, industry, total_laid_off, `date`, stage, country, funds_raised_millions) as Row_num
from layoff_staging;

delete from layoff_staging1
where row_num >1;

select * from layoff_staging1;

update layoff_staging1
set company = trim(company);

select distinct company from layoff_staging1;


update layoff_staging1
set country = 'United States'
where country like '%United States%';


with fingerprint as 
(
	select country, lower(replace(replace(replace(replace(country,' ', ''),'-',''),'.',''), "_", '')) as F_print
    from layoff_staging1
)

select F_print, count(distinct country) as variable_count
from fingerprint
group by F_print
having count(distinct country) >1;


select distinct country from layoff_staging1
order by 1;


select `date`, str_to_date(`date`, '%m/%d/%Y')
from layoff_staging1;


update layoff_staging1
set `date` = str_to_date(`date`, '%m/%d/%Y');

alter table layoff_staging1
modify column `date` Date;


select * from layoff_staging1
where industry = '' or industry is null;

update layoff_staging1
set industry = null
where industry = '';

select * from layoff_staging1 t1
join layoff_staging1 t2 
on t1.company = t2.company
and t1.location = t2.location
where t1.industry is null and t2.industry is not null;


update layoff_staging1 t1
join layoff_staging1 t2 
on t1.company = t2.company
and t1.location = t2.location
set t1.industry = t2.industry
where t1.industry is null and t2.industry is not null;


select * from layoff_staging1 
where total_laid_off is null and percentage_laid_off is null;

delete from layoff_staging1 
where total_laid_off is null and percentage_laid_off is null;


alter table layoff_staging1
drop row_num;