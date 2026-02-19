--Creating Sales table
CREATE TABLE Sales (
			sales_id INT PRIMARY KEY,
			date_key INT,
			pharmacy_id VARCHAR (10),
			product_id VARCHAR (10),
			unit_sold  INT,
			revenue_eur TEXT,
			cost_eur TEXT,
			margin_eur TEXT,
			promo_flag TEXT);
			
--Updating Sales table with new records
ALTER TABLE Sales
ALTER COLUMN date_key TYPE INTEGER
USING date_key::INTEGER;

ALTER TABLE Sales
ALTER COLUMN date_key TYPE VARCHAR (50);

ALTER TABLE Sales
ALTER COLUMN revenue_eur TYPE NUMERIC (10,2)
USING CAST(REPLACE(revenue_eur,',','.') AS NUMERIC (10,2));

ALTER TABLE Sales
ALTER COLUMN cost_eur TYPE NUMERIC (10,2)
USING CAST(REPLACE(cost_eur,',','.') AS NUMERIC (10,2));

ALTER TABLE Sales
ALTER COLUMN margin_eur TYPE NUMERIC (10,2)
USING CAST(REPLACE(margin_eur,',','.') AS NUMERIC (10,2));

Select * FROM Dates;
--Creating Pharmacy Table
CREATE TABLE Pharmacy(
			pharmacy_id VARCHAR (10)PRIMARY KEY,
			parmacy_name VARCHAR (50),
			country TEXT,
			region TEXT,
			city TEXT,
			pharmacy_type VARCHAR (20),
			open_date DATE,
			store_size VARCHAR (5),
			latitude INT,
			longitude INT);

--Changing Datatype from text to numeric 
ALTER TABLE Pharmacy
ALTER COLUMN latitude TYPE TEXT;

ALTER TABLE Pharmacy
ALTER COLUMN longitude TYPE  TEXT;

--creating Product table		
CREATE TABLE Products(
			product_id VARCHAR (10) PRIMARY KEY,
			product_name VARCHAR (100),
			category VARCHAR (100),
			brand VARCHAR (20),
			is_generic TEXT,
			pack_size VARCHAR (30),
			list_price_eur TEXT,
			standard_cost_eur TEXT,
			launch_date DATE,
			is_discontinued TEXT,
			discontinued_date DATE
--changing data type
ALTER TABLE Products
ALTER COLUMN standard_cost_eur TYPE NUMERIC (10,2)
USING CAST(REPLACE(standard_cost_eur,',','.') AS NUMERIC (10,2));

ALTER TABLE Products
ALTER COLUMN list_price_eur TYPE NUMERIC (10,2)
USING CAST(REPLACE(list_price_eur,',','.') AS NUMERIC (10,2));

--creating Date table
CREATE TABLE Dates(
			date_key INT PRIMARY KEY,
			date_yr DATE,
			year INT,
			quarter INT,
			month_number INT,
			month_name TEXT,
			year_month VARCHAR (10));
			
--Key Business Questions:
--How do revenue, units sold, and margin change over time, and are there clear seasonal patterns?
--this query retrievs the total sales revenue, unitsold, margin & margin% from 2024-2025, showing seasonañ patterns in months
SELECT d.year,
		d.month_name,
		s.date_key,
		SUM(s.revenue_eur) AS total_revenue,
		SUM(s.unit_sold) AS total_unit_sold,
		SUM(s.margin_eur) AS total_profit,
--calculating margin% to see if there is any seasonal partterns 
		ROUND((SUM(s.margin_eur)/NULLIF(SUM(s.revenue_eur),0))* 100,2) AS Margin_percentage
FROM Sales AS s
LEFT JOIN Dates AS d
ON s.date_key = d.date_key
GROUP BY d.year,d.month_name, s.date_key
ORDER BY d.year,MIN(s.date_key) ASC;

--YoY% growth, comparing previous year
SELECT year,
		month_name,
		total_revenue,
LAG(total_revenue) OVER(PARTITION BY month_name ORDER BY year) AS YoY_growth
FROM(
	SELECT d.year,
		d.month_name,
		s.date_key,
		SUM(s.revenue_eur) AS total_revenue,
		SUM(s.unit_sold) AS total_unit_sold,
		SUM(s.margin_eur) AS total_profit,
--calculate margin% to see if there is any seasonal partterns 
		ROUND((SUM(s.margin_eur)/NULLIF(SUM(s.revenue_eur),0))* 100,2) AS Margin_percentage
	FROM Sales AS s
	LEFT JOIN Dates AS d
	ON s.date_key = d.date_key
	GROUP BY d.year,d.month_name, s.date_key
	ORDER BY d.year,MIN(s.date_key) ASC) Sub;



		
SELECT * FROM Products;


SELECT s.sales_id,d.year, 
		SUM(revenue_eur) AS total_revenue,
		SUM(cost_eur) AS total_cost,
		SUM(margin_eur) AS total_profit
		FROM Sales AS s
		LEFT JOIN Dates AS d
		ON s.date_key = d.date_key
		GROUP BY s.sales_id,d.year
		ORDER BY total_revenue DESC;
		
SELECT SUM(revenue_eur) AS total_revenue
FROM Sales;

--Which countries and regions contribute the most to total revenue and margin?
SELECT p.country,p.region, 
		SUM(revenue_eur) AS total_revenue,
		SUM(margin_eur) AS total_profit
FROM Pharmacy AS p
INNER JOIN Sales AS s
ON p.pharmacy_id = s.pharmacy_id
GROUP BY p.country, p.region
ORDER BY total_revenue DESC;

--Which pharmacies outperform or underperform compared to others in the same region?
-- Best performed pharmacy 
SELECT p.parmacy_name, p.region,p.country,p.pharmacy_type,
		SUM(revenue_eur) AS total_revenue,
		SUM(margin_eur) AS total_profit
FROM Pharmacy AS p
JOIN Sales s 
ON p.pharmacy_id = s.pharmacy_id
WHERE country = 'Germany'
GROUP BY p.parmacy_name, p.region, p.country,p.pharmacy_type
ORDER BY total_revenue DESC,total_profit DESC;

--Underperformed pharmacy - Vienna HealthPoint#115 with total profit of 391.34
SELECT p.parmacy_name, p.region,p.country,p.pharmacy_type,
		SUM(unit_sold)AS total_unit_sold,
		SUM(revenue_eur) AS total_revenue,
		SUM(margin_eur) AS total_profit
FROM Pharmacy AS p
LEFT JOIN Sales s 
ON p.pharmacy_id = s.pharmacy_id
LEFT JOIN Products AS pr
ON s.product_id = pr.product_id
WHERE country = 'Austria'
GROUP BY p.parmacy_name, p.region, p.country,p.pharmacy_type
ORDER BY total_revenue ASC,total_profit ASC;

--How do Urban, Suburban, and Rural pharmacies differ in sales volume and profitability?
SELECT pharmacy_type, 
		SUM(unit_sold) AS unit_sold,
		SUM(margin_eur) AS total_margin,
		SUM(revenue_eur) AS total_revenue
FROM Pharmacy AS p
LEFT JOIN Sales AS s
On p.pharmacy_id = s.pharmacy_id
GROUP BY pharmacy_type;

SELECT p.pharmacy_type,
		s.unit_sold,
		p.region,
NTILE(3) Over(Partition By pharmacy_type order by unit_sold DESC) AS unit_sold_loc
From Sales AS s
Left Join Pharmacy AS p
ON s.pharmacy_id = p.pharmacy_id
Order By unit_sold;
		
--Are there products with high volume but low margin, or low volume but high margin?
WITH sales_Perfo AS (
	SELECT p.product_name,
		SUM(s.unit_sold) AS total_unit_sold,
		SUM(s.revenue_eur) AS total_revenue,
		ROUND((SUM(s.margin_eur)/NULLIF(SUM(s.revenue_eur),0))* 100,2) AS Margin_percentage
	FROM Sales AS s
	LEFT JOIN Dates AS d
	ON s.date_key = d.date_key
	LEFT JOIN Products AS p
	ON s.product_id = p.product_id
	WHERE year = 2025
	GROUP BY p.product_name)
SELECT product_name, 
		total_unit_sold,
		total_revenue,
		Margin_percentage
	FROM sales_Perfo
	ORDER BY  Margin_percentage DESC;
	
--Inactive products	
SELECT DISTINCT p.product_name,
 		SUM(s.unit_sold) AS total_unit_sold,
		SUM(s.revenue_eur) AS total_revenue
FROM Products AS p
LEFT JOIN Sales AS s
ON p.product_id = s.product_id
Group BY p.product_name


--How do promoted sales compare to non-promoted sales in terms of volume and margin?
SELECT promo_flag,
		SUM(unit_sold) AS total_unit_sold,
		SUM(revenue_eur) AS total_revenue
FROM Sales
GROUP BY promo_flag

--How does regional performance contribute to overall business results?
SELECT p.country,
		p.region,
		SUM(s.unit_sold) AS total_unit_sold,
			SUM(s.revenue_eur) AS total_revenue,
				ROUND((SUM(s.margin_eur)/NULLIF(SUM(s.revenue_eur),0))* 100,2) AS Margin_percentage
FROM Pharmacy AS p
LEFT JOIN Sales AS s
ON p.pharmacy_id = s.pharmacy_id
GROUP BY p.region,p.country 
ORDER BY total_revenue DESC;

--Using window function
--How does regional performance contribute to overall business results?
SELECT
    p.region,
    SUM(s.revenue_eur) AS total_revenue,
    SUM(s.unit_sold) AS total_units_sold,
    SUM(s.margin_eur) AS total_profit,
	ROUND((SUM(s.margin_eur)/NULLIF(SUM(s.revenue_eur),0))* 100,2) AS Margin_percentage,
    
	ROUND(
        SUM(s.revenue_eur) * 100.0 / SUM(SUM(s.revenue_eur)) OVER (),
        2
    ) AS revenue_contribution_pct,

    ROUND(
        SUM(s.margin_eur) * 100.0 / SUM(SUM(s.margin_eur)) OVER (),
        2
    ) AS profit_contribution_pct

FROM pharmacy p
JOIN sales s
    ON p.pharmacy_id = s.pharmacy_id
GROUP BY p.region
ORDER BY total_revenue DESC;
