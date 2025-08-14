# 📊 Layoffs Data Cleaning & Exploratory Data Analysis (EDA) – MySQL

## 📌 Overview
This project focuses on cleaning and analyzing a global **layoffs dataset** using **MySQL**.  
The workflow covers **data preparation, standardization, handling missing values, removing duplicates, and conducting in-depth EDA** to identify patterns in layoffs by company, industry, geography, and time.

The main goal was to transform a raw, messy dataset into a **clean, reliable, and analysis-ready format**, followed by uncovering insights into global layoff trends.

---

## 🗂 Dataset
The dataset contains the following key fields:
- **company** – Name of the company.
- **location** – Company location.
- **industry** – Industry type.
- **total_laid_off** – Number of employees laid off.
- **percentage_laid_off** – Proportion of workforce laid off.
- **date** – Date of layoff announcement.
- **stage** – Business stage of the company (e.g., Post-IPO, Series A, etc.).
- **country** – Country of operations.
- **funds_raised_millions** – Funds raised by the company in millions.

---

## ⚙️ Steps Performed

### 1️⃣ Data Preparation
- Created **staging tables** to avoid modifying the raw dataset.
- Imported the raw data into a new staging table (`layoffs_staging` → `layoffs_staging2`) for cleaning.

---

### 2️⃣ Data Cleaning Process

#### 🔹 Removing Duplicates
- Used **`ROW_NUMBER()` window function** to identify duplicate rows based on:

- Removed duplicate entries to ensure data integrity.

#### 🔹 Standardizing Data
- Trimmed leading/trailing spaces in **company names**.
- Unified inconsistent values:
- Example: All `Crypto%` industries changed to **"Crypto"**.
- Fixed country naming inconsistencies (e.g., "United States." → "United States").
- Converted **date** column from `TEXT` to proper `DATE` format using `STR_TO_DATE()`.

#### 🔹 Handling Missing Values
- Converted blank industry values to `NULL`.
- Used **self-join updates** to fill missing industries based on other rows from the same company and location.
- Deleted rows where both `total_laid_off` and `percentage_laid_off` were NULL.

#### 🔹 Column Adjustments
- Dropped temporary helper columns (e.g., `row_num`) after cleaning.

---

### 3️⃣ Exploratory Data Analysis (EDA)

#### 📅 Time-based Trends
- Identified earliest and latest layoff dates.
- Grouped layoffs by **year** and **month-year**.
- Calculated **rolling totals** of layoffs over time.

#### 🏢 Company Analysis
- Ranked companies by total layoffs.
- Identified top companies per year using **`DENSE_RANK()`**.

#### 🏭 Industry Analysis
- Aggregated layoffs by industry to find the most affected sectors.

#### 🌍 Geographic Analysis
- Summarized layoffs by country to highlight regions most impacted.

#### 💰 Funding & Layoffs
- Analyzed cases where **percentage_laid_off = 100%** and ranked by highest funds raised.

---

## 📊 Example Insights
- Certain companies had **complete workforce layoffs** despite raising significant funds.
- The **technology and crypto sectors** were among the most affected.
- The **United States** had the highest layoffs in the dataset.
- Layoff waves were observed in specific months, indicating possible **economic or seasonal triggers**.

---

## 🛠 Tools & Technologies Used
- **SQL (MySQL)** – Data cleaning, transformation, and EDA.
- **Window Functions** – For duplicate detection, ranking, and rolling totals.
- **String Functions** – For trimming, standardizing, and cleaning textual data.
- **Date Functions** – For parsing and grouping dates.

---


---

## 🚀 How to Run
1. Import the raw dataset into a MySQL database.
2. Run `data_cleaning.sql` to clean and standardize the data.
3. Run `eda_queries.sql` to generate insights and summaries.
4. Optionally, export cleaned data for visualization in **Power BI / Tableau**.

---

## 📅 Project Timeline
- **Data Cleaning** – Removal of duplicates, standardization, null handling.
- **EDA** – Trend analysis, ranking, and aggregated statistics.

---

## 📌 Key Learnings
- Efficient use of **window functions** for cleaning and ranking.
- Practical handling of **missing data** using self-joins.
- Real-world experience in **data standardization** for better analytical outcomes.
- Ability to connect SQL outputs to BI tools for visual storytelling.

---

## 📎 References
- MySQL Official Documentation  
- SQL Functions & Window Functions Tutorials  
- Public Layoffs Dataset Source

---
