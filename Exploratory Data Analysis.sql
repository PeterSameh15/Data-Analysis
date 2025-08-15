-- Exploratory Data Analysis

select * 
from layoffs_staging2;



select max(total_laid_off),min(total_laid_off),max(percentage_laid_off),min(percentage_laid_off),count(company)
from layoffs_staging2;


select*
from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions desc;


select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by sum(total_laid_off) desc;


select max(`date`),min(`date`)
from layoffs_staging2;


select industry, sum(total_laid_off)
from layoffs_staging2
group by industry
order by sum(total_laid_off) desc;


select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by sum(total_laid_off) desc;

select `date`, sum(total_laid_off)
from layoffs_staging2
group by `date`
order by sum(total_laid_off) desc;

select year(`date`), sum(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 1 desc;

select stage, sum(total_laid_off)
from layoffs_staging2
group by stage
order by 1 asc;

select company, sum(percentage_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select substring(`date`,1,7) as `MONTH`,sum(total_laid_off) AS Total_Laid_off
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `MONTH`
order by 1 asc;

with Rolling_Total as
(
select substring(`date`,1,7) as `MONTH`,sum(total_laid_off) AS Total_off
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `MONTH`
order by 1 asc
)
select `month` ,total_off, sum(total_off) over(order by `month`) as rolling_total
from  Rolling_Total;

select company , year(`date`),sum(total_laid_off)
from layoffs_staging2
group by  company , year(`date`)
;


with company_year (Company , `Year`,Total_Laid_Off) as
( 
select company , year(`date`),sum(total_laid_off)
from layoffs_staging2
group by  company , year(`date`)
) , company_year_rank as
(select*, dense_rank() over(partition by year order by total_laid_off desc) as Ranking
from company_year
where year is not null
)
select*
from company_year_rank
where Ranking <=5;


with industry_year (industry , `Year`,Total_Laid_Off) as
( 
select industry , year(`date`),sum(total_laid_off)
from layoffs_staging2
group by  industry , year(`date`)
) , industry_year_rank as
(select*, dense_rank() over(partition by year order by total_laid_off desc) as Ranking
from industry_year
where year is not null
)
select*
from industry_year_rank
where Ranking <=5;












