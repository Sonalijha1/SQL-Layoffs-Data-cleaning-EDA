# SQL-Layoffs-Data-cleaning-EDA
Data cleaning and exploratory data analysis on global layoffs data using MySQL

# Tech Layoffs Exploratory Data Analysis (EDA) in SQL

## 📌 Project Overview
This project involves a comprehensive Exploratory Data Analysis (EDA) of global tech layoffs spanning from 2020 to early 2023. The goal was to clean a raw dataset using MySQL and uncover actionable insights regarding which companies, industries, locations, and stages of business were hit hardest by workforce reductions.

## 🛠️ Tools & Technologies
* **Database:** MySQL
* **Techniques:** CTEs, Window Functions (`ROW_NUMBER`, `DENSE_RANK`), String Manipulation, Date Formatting, Aggregations, and Joins.

## 📂 Dataset
The original dataset used for this project can be found here: [Tech Layoffs Dataset (CSV)](https://github.com/AlexTheAnalyst/MySQL-YouTube-Series/blob/main/layoffs.csv)

## 🧹 Step 1: Data Cleaning
Before analyzing the data, the dataset required rigorous cleaning to ensure accuracy. The `Cleaning.sql` script performs the following:
1. **Removing Duplicates:** Utilized CTEs and the `ROW_NUMBER()` window function to identify and delete duplicate entries based on unique company, location, industry, and date partitions.
2. **Standardizing Data:** Formatted text by trimming whitespace and standardizing categorical variables (e.g., merging variations of "United States").
3. **Date Formatting:** Converted raw string dates into standard SQL `DATE` formats using `STR_TO_DATE()`.
4. **Handling Nulls/Blanks:** Populated missing `industry` values by joining the table to itself and matching known industries for the same company and location. Removed records where both `total_laid_off` and `percentage_laid_off` were null, as they provided no analytical value.

## 📊 Step 2: Exploratory Data Analysis & Key Insights
The `EDA-layoff.sql` script dives deep into the cleaned dataset. Here are the primary findings:

### 1. Most Impacted Companies
* **Amazon** leads the overall layoffs with **18,150** employees let go, followed closely by Google (12,000) and Meta (11,000). 
* When diving deeper into Amazon's data, the layoffs were heavily concentrated within their **Retail** division.

### 2. Industry & Stage Breakdown
* The **Consumer** (45,182) and **Retail** (43,613) industries suffered the highest number of overall layoffs. 
* Layoffs overwhelmingly occurred in **Post-IPO** companies (204,132 total), showcasing that established "Big Tech" giants drove the majority of these numbers, rather than early-stage startups.

### 3. Geographical Impact
* **Country:** The **United States** accounts for the vast majority of layoffs (256,559), followed distantly by India (35,993) and the Netherlands (17,220).
* **Location:** The **SF Bay Area** alone saw a staggering **125,601** layoffs, cementing it as the epicenter of the tech downturn.

### 4. Yearly Trends & Timeline
While the dataset covers 2020 through early 2023, the timeline reveals a massive acceleration in layoffs:
* **2022 vs. 2023:** 2022 saw the highest full-year layoffs (160,661). However, in just the first three months of 2023, layoffs already reached **125,677**, suggesting that 2023 was on pace to vastly exceed 2022.
* **Top Layoffs by Year:**
  * **2020:** Uber (7,525)
  * **2021:** Bytedance (3,600)
  * **2022:** Meta (11,000)
  * **2023 (Q1):** Google (12,000)
* **Observation:** The major Post-IPO giants (Amazon, Google, Meta) did not begin their massive workforce reductions at the start of the economic downturn; rather, they executed their highest-volume layoffs later in the timeline (late 2022 and 2023).

---
*Feel free to explore the `SQL` scripts provided in this repository to view the queries used to extract these insights.*
