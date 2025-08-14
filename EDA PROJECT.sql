-- EDA 
SELECT *
FROM layoffs_staging2;

SELECT MAX(total_laid_off),MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off=1
ORDER BY funds_raised_millions DESC;

SELECT company,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT industry,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT MIN(`date`),MAX(`date`)
FROM layoffs_staging2;

SELECT country,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT YEAR(`date`),SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

SELECT stage,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;


SELECT SUBSTRING(`date`,1,7) AS month_year,SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY month_year
ORDER BY 1 ASC;

WITH rolling_total AS 
(
SELECT SUBSTRING(`date`,1,7) AS month_year,SUM(total_laid_off) as total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY month_year
ORDER BY 1 ASC
)
SELECT month_year,total_off,
SUM(total_off) OVER(ORDER BY month_year) AS rolling_laid_off_total
FROM rolling_total;

SELECT company,YEAR(`date`),SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company,YEAR(`date`)
ORDER BY SUM(total_laid_off) DESC;

WITH Company_year AS 
(SELECT company,YEAR(`date`) as years,SUM(total_laid_off) as total_off
FROM layoffs_staging2
GROUP BY company,YEAR(`date`)
),Company_ranking AS
(SELECT *,DENSE_RANK() OVER(PARTITION BY years ORDER BY total_off DESC) Ranking
FROM Company_year
WHERE years IS NOT NULL
)
SELECT *
FROM Company_ranking
WHERE Ranking <=5;