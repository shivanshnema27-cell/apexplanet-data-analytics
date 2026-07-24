select * from "superstore";

SELECT "Product Name", "Sales", "Category"
FROM superstore;

SELECT *
FROM superstore
WHERE "Category" = 'Furniture';


SELECT "Product Name", "Sales"
FROM superstore
ORDER BY "Sales" DESC;

SELECT "Product Name", "Sales"
FROM superstore
ORDER BY "Sales" DESC
LIMIT 5;

SELECT "Category",
       SUM("Sales") AS Total_Sales
FROM superstore
GROUP BY "Category"
;


SELECT "Category",
       SUM("Sales") AS Total_Sales
FROM superstore
GROUP BY "Category"
HAVING SUM("Sales") > 450000;



CREATE TABLE customers AS
SELECT DISTINCT
    "Customer ID",
    "Customer Name",
    "Segment",
    "Region"
FROM superstore;


SELECT
    s."Order ID",
    s."Product Name",
    s."Sales",
    c."Customer Name",
    c."Segment"
FROM superstore s
INNER JOIN customers c
ON s."Customer ID" = c."Customer ID";


--Subqueries

SELECT "Product Name", "Sales"
FROM superstore
WHERE "Sales" >
(
    SELECT AVG("Sales")
    FROM superstore
);

SELECT "Customer Name",
       SUM("Sales") AS Total_Sales
FROM superstore
GROUP BY "Customer Name"
HAVING SUM("Sales") >
(
    SELECT AVG(total_sales)
    FROM
    (
        SELECT SUM("Sales") AS total_sales
        FROM superstore
        GROUP BY "Customer Name"
    ) AS avg_sales
);


SELECT *
FROM superstore s
WHERE "Sales" =
(
    SELECT MAX("Sales")
    FROM superstore
    WHERE "Category" = s."Category"
);


--CTE's

WITH CategorySales AS
(
    SELECT "Category",
           SUM("Sales") AS Total_Sales
    FROM superstore
    GROUP BY "Category"
)

SELECT *
FROM CategorySales
ORDER BY Total_Sales DESC;


WITH CustomerSales AS
(
    SELECT "Customer Name",
           SUM("Sales") AS Total_Sales
    FROM superstore
    GROUP BY "Customer Name"
)

SELECT *
FROM CustomerSales
ORDER BY Total_Sales DESC
LIMIT 10;


WITH RegionSales AS
(
    SELECT "Region",
           SUM("Sales") AS Total_Sales
    FROM superstore
    GROUP BY "Region"
)

SELECT *
FROM RegionSales;


--Windows Function 

SELECT
    "Product Name",
    "Sales",
    ROW_NUMBER() OVER (ORDER BY "Sales" DESC) AS Row_Number
FROM superstore;



SELECT
    "Product Name",
    "Sales",
    DENSE_RANK() OVER (ORDER BY "Sales" DESC) AS Dense_Rank
FROM superstore;


SELECT
    "Category",
    "Product Name",
    "Sales",
    ROW_NUMBER() OVER
    (
        PARTITION BY "Category"
        ORDER BY "Sales" DESC
    ) AS Rank_In_Category
FROM superstore;




SELECT
    "Order Date",
    "Sales",
    LAG("Sales") OVER
    (
        ORDER BY TO_DATE("Order Date",'MM/DD/YYYY')
    ) AS Previous_Sales
FROM superstore;


SELECT
    "Order Date",
    "Sales",
    LEAD("Sales") OVER
    (
        ORDER BY TO_DATE("Order Date",'MM/DD/YYYY')
    ) AS Next_Sales
FROM superstore;

CREATE VIEW HighSales AS

SELECT
    "Product Name",
    "Sales",
    "Category"
FROM superstore
WHERE "Sales" > 1000;

CREATE VIEW CustomerSales AS

SELECT
    "Customer Name",
    SUM("Sales") AS Total_Sales
FROM superstore
GROUP BY "Customer Name";











