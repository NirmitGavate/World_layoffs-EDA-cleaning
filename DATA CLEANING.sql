-- DATA CLEANING 
SELECT *
FROM layoffs;


-- 1. DROP DUPICATES
-- 2. STANDARDIZE THE DATA
-- 3. FILL NULLS
-- 4. REMOVE ANY COLUMNS

CREATE TABLE layoffs_staging LIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;

SELECT *
FROM layoffs_staging;

# cannot access window function in where clause so we create a CTE table
# we cannot delete rows in a CTE so we create a new table 
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company,industry,total_laid_off,percentage_laid_off,`date`) as row_num
FROM layoffs_staging
WHERE row_num>1;

WITH duplicate_cte as 
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
FROM layoffs_staging
)
DELETE FROM duplicate_cte
where row_num>1;

SELECT *
FROM layoffs_staging
WHERE company="Casper";

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
FROM layoffs_staging;

DELETE
FROM layoffs_staging2
WHERE row_num>1;

SELECT *
FROM layoffs_staging2;


-- STANDARDIZING DATA
SELECT company,TRIM(company)
FROM layoffs_staging2;


UPDATE layoffs_staging2
SET company=TRIM(company);

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging2
WHERE industry LIKE "Crypto%";

UPDATE layoffs_staging2
SET industry='Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT country 
FROM layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging2
WHERE country LIKE "United States%";

SELECT DISTINCT country,TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country=TRIM(TRAILING '.' FROM country)
WHERE country LIKE "United States%";

SELECT `date`,
STR_TO_DATE(`date`,"%m/%d/%Y")
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date`=STR_TO_DATE(`date`,"%m/%d/%Y");

SELECT *
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

--  REMOVE NULLS 

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT DISTINCT industry
FROM layoffs_staging2;


SELECT *
FROM layoffs_staging2
WHERE industry=''
OR industry IS NULL;

SELECT *
FROM layoffs_staging2
WHERE company="Airbnb";

update layoffs_staging2
SET industry=NULL
WHERE industry='';


SELECT *
FROM layoffs_staging2 t1 
JOIN layoffs_staging2 t2
	ON t1.company=t2.company
WHERE (t1.industry IS NULL) 
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company=t2.company AND t1.location=t2.location
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL) 
AND t2.industry IS NOT NULL;

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL OR industry='';

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;



DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


ALTER TABLE layoffs_staging2
DROP COLUMN row_num;





 


