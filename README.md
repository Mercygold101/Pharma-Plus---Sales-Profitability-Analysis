# Pharma Plus -Sales & Profitability-Analysis
## Project Background
Pharma Plus is an European pharmacy chain distributor operating in eight European countries - Germany, France, Italy, Belgiun, Netherland, Spain, Poland and Austria. The company utilizes Excel to record daily transactions, including geographic, pharmacy and products category information.

This report presents a comprehensive analysis of the company dataset to help stakeholder understand sales and profitability, products and categories, pharmacy dynamics  across countries and regions from  2024  to 2025.
### The analysis delivers insights and strategic recommendations across the following key areas:
### Revenue Trend Analysis: 
Year-over-Year performance evaluation covering Revenue, Unit Sold, Profit and Profit Margin with 

a focus on seasonal trends and growth patterns

### Geographic and pharmacy-level performance: 
Regional and store-level analysis highlighting where Pharma Plus is outperforming and where

performance gaps exist across markets.

### Product & Profitability Analysis: 
Detailed product performance assessment to determine which products to sell motre, promote, 

optimize, or discontinue based on revenue, margin, and volume contribution.

An interactive Power BI report can be downloaded [**here**](https://app.powerbi.com/view?r=eyJrIjoiMDgwMjFkNTYtZmIwZS00Y2IzLWI0OTctNzBhMWMyYjVhZjRkIiwidCI6IjQ2NTRiNmYxLTBlNDctNDU3OS1hOGExLTAyZmU5ZDk0M2M3YiIsImMiOjl9)

SQL query used in  cleaning and creating the tables can be found [here](https://github.com/Mercygold101/Pharma-Plus---Sales-Profitability-Analysis/blob/main/Phaemacy%20sales%20analysis.sql)

Targeted SQL queries used in answering variuos business questions can be found [here](https://github.com/Mercygold101/Pharma-Plus---Sales-Profitability-Analysis/blob/main/Phaemacy%20sales%20analysis.sql)

### Data Structure
Pharma Plus database consist of four tables - Sales, Pharmacy, Products & Dates a total row count of 62,140 records.
<img width="1282" height="940" alt="ERD Pharma Plus data" src="https://github.com/user-attachments/assets/0a58a88b-c6fc-47f1-ac08-86c9630588b2" />
### Excecutive Summary
Overview of findings

The company sales revenue incresead with a significant growth of 19% in 2025. Year over Year comparison trends show a positive profitability of +0.07 percentage points in 2025 compared to 2024. This improvement represents meaningful value when applied to overall revenue. Seasonal analysis reveals strong sales momentum from the mid-year through last quarter, with the Average monthly revenue of 
€719,18K in 2025.
![pharma overview1](https://github.com/user-attachments/assets/0ffbf11b-dd69-4b5b-bb1e-0f3de5864ad9)
- The business generated €4.41M in sales revenue in 2025, up from €4.22M in 2024, reflecting steady year-over-year growth.
- Units sold increased by approximately 10,000 in 2025, indicating rising customer demand and improved market penetration.
- Despite strong revenue growth, profit levels remained relatively flat. Further analysis shows that promotional activities had minimal impact on sales volume, indicating that discounts did not generate incremental demand. Instead, promotions reduced effective prices, contributing to margin pressure and limiting profit expansion
- Seasonal analysis reveals strong sales momentum from the mid-year through last quarter, with the average monthly revenue of approximately €367,6K in 2025.
- Highest sales were recorded in May & December with €393k and €384K consecutively
- During peak period, profit margin remained stable around 28%, indicating effective cost control and pricing discipline despite increased sales volume.
- The ability to sustain margin during peak period shows that business can handle higher volume without losing profitabilty

### Country-level Performance Insights
![Country Pharma](https://github.com/user-attachments/assets/14ebee9c-da7c-4499-b61f-6249d8f1176b)
- Germany, France, and Italy lead in sales volume, with Germany emerging as the top contributor, generating the highest share of total revenue and selling approximately 599K units.
- Spain, Poland, and Austria lag behind in sales performance, with Austria contributing only around 8% of total revenue and selling approximately 6K units.
- Leading countries show strong demand in the prescription drugs category. While higher unit sales continue to drive revenue growth, profit levels remain relatively flat, indicating margin pressure and limited operating leverage.

### Region & Pharmacy-level Insights
<img width="887" height="325" alt="image" src="https://github.com/user-attachments/assets/8eae3b72-af90-4595-87c1-c912fa013149" />
- Lombardy, Hamburg & Utretch region outperformed other regions with Lombardy emarging as the strongest market generating approximately €507K in revenue. These regions also show high demand for Antidepressant medications and AntiBioX ACE products
- 
- The top 4 performing regions maintained the average revenue of arond €200K while other regions fell slightly below this bentchmark, highlighting moderate regional performance disparities.


- Gilderland, Netherlands lagged behind generating aproximately 4% of total revenue selling only 1.8k products
  
- In Germany’s Bavaria region, Munich HealthPoint #097 emerged as a top performer, contributing 1.88% of global revenue with a strong profit margin of 27.83%.
  
- In contrast, Vienna HealthPoint #115 in Austria underperformed, generating only 0.02% of global revenue and selling just 93 units
  
- Urban pharmacies lead performance, generating approximately €2.1M in revenue, followed by suburban locations with around €1.6M. Rural pharmacies lag behind, contributing about €716K, indicating lower customer traffic and demand density outside major urban areas.
  
- Medium-sized stores emerged as the top performers, generating approximately €1.99M in revenue, followed by large stores at around €1.6M. Small stores underperformed, with revenue of about €826K, suggesting limited scale and lower sales capacity.
  
### Product & Profitability
![Product insight pharma](https://github.com/user-attachments/assets/4bdeab63-6d3d-4bcc-b854-87099460a4e3)
- AntiBioX ACE Inhibitor 400 mg emerged as the highest-selling drugs with over €100K in revenue and 1,607 units sold. However, its relatively low profit margin of 24.94% indicates high volume but limited profitability.
- Dermasoft Shampoo Repair and NatureFit Omega-3 Max delivered the strongest margins at 39.07% and 38.04%, respectively. Despite their high profitability, both products recorded relatively low sales volumes.
- Out of 220 products,17% were inactive in 2025 and generated no revenue, suggesting opportunity for inventory optimization
- Around 20% of products underperformed against the margin benchmark, while approximately 60% maintained healthy profitability levels, indicating a generally resilient but uneven product mix.

### Recommendations 
- Although revenue growth is evident, flat profit levels indicate margin pressure driven largely by ineffective promotional strategies. The business should transition from broad discounting to targeted, ROI-driven promotions, optimize margins on high-volume products, and rebalance the product mix toward higher-margin offerings
- The business should replicate high-performing market strategies in Gilderland, Netherlands  regions while reassessing pricing and cost structures in Lombardy, Hamburg & Utretch region
- Reviewing pricing strategy for AntiBioX ACE Inhibitor 400 mg or supplier renegotiation and actively promoting and upselling Dermasoft Shampoo Repair and NatureFit Omega-3 Max
- Streamline products by eliminating 17% of inactive drugs and reviewing underperforming products like AntibioX Costcostereoid cream 100 mg, reallocating resources toward high-performing and high-margin items to improve margin efficiency and working capital utilization.
