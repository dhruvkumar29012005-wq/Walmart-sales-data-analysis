Altering Questions:
1.	Can we categorize the transaction time into Morning, Afternoon, and Evening to analyze the time of day when most sales occur?
ALTER TABLE walmartsalesdata
ADD time_of_day VARCHAR(20);

UPDATE walmartsalesdata
SET time_of_day = CASE
    WHEN CAST(Time AS TIME) < '12:00:00' THEN 'Morning'
    WHEN CAST(Time AS TIME) < '16:00:00' THEN 'Afternoon'
    ELSE 'Evening'
END;

SELECT time_of_day, COUNT(*) AS total_sales
FROM walmartsalesdata
GROUP BY time_of_day;
2.	On which day of the week did each transaction take place to understand daily sales trends?
ALTER TABLE walmartsalesdata
ADD day_name VARCHAR(20)

UPDATE walmartsalesdata
SET day_name = DATENAME(WEEKDAY, Date)

SELECT day_name, COUNT(*) AS total_sales
FROM walmartsalesdata
GROUP BY day_name;

3.	In which month did each transaction occur to determine monthly sales and profit performance?
ALTER TABLE walmartsalesdata
ADD month_name VARCHAR(20)

UPDATE walmartsalesdata
SET month_name = DATENAME(MONTH, Date);

SELECT month_name, COUNT(*) AS total_sales
FROM walmartsalesdata
GROUP BY month_name;
Generic Questions
1.	How many unique cities are present in the dataset?
SELECT COUNT(DISTINCT City) AS unique_cities
FROM walmartsalesdata;

2.	Which city is associated with each store branch?
SELECT DISTINCT City, Branch
FROM walmartsalesdata
ORDER BY City;

Product Analysis Questions
1.	How many unique product lines are available in the dataset?
SELECT COUNT(DISTINCT Product_line) AS unique_product_line
FROM walmartsalesdata;

2.	What is the most commonly used payment method?
SELECT Payment, COUNT(*) AS total_count
FROM walmartsalesdata
GROUP BY Payment
ORDER BY total_count DESC;

3.	Which product line has the highest number of units sold?
SELECT Product_line, COUNT(*) AS total_sales
FROM walmartsalesdata
GROUP BY Product_line
ORDER BY total_sales DESC;

4.	What is the total revenue generated in each month?
SELECT month_name, SUM(Total) AS total_revenue
FROM walmartsalesdata
GROUP BY month_name
ORDER BY total_revenue DESC;

5.	In which month was the cost of goods sold (COGS) the highest?
SELECT month_name, SUM(cogs) AS total_cogs
FROM walmartsalesdata
GROUP BY month_name
ORDER BY total_cogs DESC;

6.	Which product line generated the most revenue?
SELECT Product_line, SUM(Total) AS total_revenue
FROM walmartsalesdata
GROUP BY Product_line
ORDER BY total_revenue DESC;

7.	Which city recorded the highest total revenue?
SELECT City, Branch, SUM(Total) AS total_revenue
FROM walmartsalesdata
GROUP BY City, Branch
ORDER BY total_revenue DESC;

8.	Which product line had the highest average VAT percentage?
SELECT Product_line, SUM(`Tax 5%`) AS total_vat
FROM walmartsalesdata
GROUP BY Product_line
ORDER BY total_vat DESC;

9.	Can we classify each product line as “Good” or “Bad” based on whether its sales volume is above or below the average?
SELECT Product_line, 
AVG(Total) AS avg_sales,
CASE 
  WHEN AVG(Total) > (SELECT AVG(Total) FROM walmartsalesdata) 
  THEN 'Good' 
  ELSE 'Bad' 
END AS quality
FROM walmartsalesdata
GROUP BY Product_line;

10.	Which branch sold more products than the overall average number of products sold?
SELECT Branch, SUM(Quantity) AS total_qty
FROM walmartsalesdata
GROUP BY Branch
HAVING SUM(Quantity) > (SELECT AVG(Quantity) 
FROM WALMARTSALESDATA

11.	For each gender, which product line is purchased the most?
SELECT Gender, Product_line, COUNT(*) AS total_count
FROM walmartsalesdata
GROUP BY Gender, Product_line
ORDER BY Gender, total_count DESC;

12.	What is the average customer rating for each product line?
SELECT Product_line, AVG(Rating) AS avg_rating
FROM walmartsalesdata
GROUP BY Product_line
ORDER BY avg_rating DESC;

Sales Analysis Questions
1.	How many sales were made during each time of day (Morning, Afternoon, Evening) for every day of the week?
SELECT Day_name, Time_of_day, COUNT(*) AS total_sales
FROM walmartsalesdata
GROUP BY Day_name, Time_of_day
ORDER BY Day_name, total_sales DESC;

2.	Which customer type contributes the most to the company’s total revenue?
SELECT Customer_type, SUM(Total) AS total_revenue
FROM walmartsalesdata
GROUP BY Customer_type
ORDER BY total_revenue DESC;

3.	Which city has the highest average VAT percentage?
SELECT City, AVG([Tax 5%]) AS avg_vat
FROM walmartsalesdata
GROUP BY City
ORDER BY avg_vat DESC;

4.	Which customer type pays the most VAT on average?
SELECT Customer_type, AVG([Tax 5%]) AS avg_vat
FROM walmartsalesdata
GROUP BY Customer_type
ORDER BY avg_vat DESC;

Customer Analysis Questions
1.	How many unique customer types are present in the dataset?
SELECT DISTINCT Customer_type
FROM walmartsalesdata;
SELECT COUNT(DISTINCT Customer_type) AS unique_customer_types
FROM walmartsalesdata;
2. How many different payment methods are used by customers?
SELECT COUNT(DISTINCT Payment) AS unique_payment_methods
FROM walmartsalesdata;
3.	What is the most common customer type?
SELECT Customer_type, COUNT(*) AS total_count
FROM walmartsalesdata
GROUP BY Customer_type
ORDER BY total_count DESC;

4.	Which customer type makes the most purchases?
SELECT Customer_type, COUNT(*) AS total_purchases
FROM walmartsalesdata
GROUP BY Customer_type
ORDER BY total_purchases DESC;
5.	What is the gender distribution among the customers?
SELECT Gender, COUNT(*) AS total_count
FROM walmartsalesdata
GROUP BY Gender
ORDER BY total_count DESC;
6.	How does the gender distribution vary across different store branches?
SELECT Branch, Gender, COUNT(*) AS total_count
FROM walmartsalesdata
GROUP BY Branch, Gender
ORDER BY Branch, total_count DESC;
7.	During which time of the day do customers give the highest average ratings?
SELECT [Time_of_day], COUNT(*) AS total_ratings
FROM walmartsalesdata
GROUP BY [Time_of_day]
ORDER BY total_ratings DESC;

8.	During which time of the day do customers in each branch give the best ratings?
SELECT Branch, [Time_of_day], COUNT(*) AS total_ratings
FROM walmartsalesdata
GROUP BY Branch, [Time_of_day]
ORDER BY Branch, total_ratings DESC;

9. On which day of the week do customers provide the best average ratings?
SELECT [Day_name], AVG(Rating) AS avg_rating
FROM walmartsalesdata
GROUP BY [Day_name]
ORDER BY avg_rating DESC;

10.	For each branch, which day of the week receives the highest number of sales?
SELECT Branch, [Day_name], AVG(Rating) AS avg_rating
FROM walmartsalesdata
GROUP BY Branch, [Day_name]
ORDER BY Branch, avg_rating DESC;