DECLARE @Prices TABLE
(product_id INT, [start_date] DATE, end_date DATE, price INT)
INSERT INTO @Prices
VALUES
(1, '2019-02-17', '2019-02-28', 5),
(1, '2019-03-01', '2019-03-22', 20),
(2, '2019-02-01', '2019-02-20', 15),
(2, '2019-02-21', '2019-03-31', 30),
(3, '2019-02-21', '2019-03-31', 30)

DECLARE @UnitsSold TABLE
(product_id INT, purchase_date DATE, units INT)
 INSERT INTO @UnitsSold
 VALUES
(1, '2019-02-25', 100),  
(1, '2019-03-01', 15),   
(2, '2019-02-10', 200),
(2, '2019-03-22', 30)

SELECT P.product_id AS product_id, ISNULL(CAST(CAST(SUM(US.units * P.price) AS FLOAT) / SUM(US.units) AS DECIMAL(10,2)), 0) AS average_price
FROM @Prices P LEFT JOIN @UnitsSold US ON P.product_id = US.product_id
AND US.purchase_date BETWEEN P.[start_date] AND P.end_date
GROUP BY P.product_id