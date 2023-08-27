-- Включаем оптимизатор GP.
   SET OPTIMIZER = ON;

-- Основной запрос
SELECT  'Август 2023, итого:' AS "Продажи за период:", 
        product_name AS "Наименование товара", 
        SUM(sales_cnt) AS "Количество продаж, шт.",
        SUM(price*sales_cnt) AS "Выручка, руб."
FROM sales 
    INNER JOIN products ON sales.product_id = products.product_id
WHERE date >= '2023-08-01'
        AND product_name = 'Патефон'
GROUP BY product_name

-- План предыдущего запроса. 

EXPLAIN SELECT  'Август 2023, итого:' AS "Продажи за период:", 
                product_name AS "Наименование товара", 
                SUM(sales_cnt) AS "Количество продаж, шт.",
                SUM(price*sales_cnt) AS "Выручка, руб."
FROM sales 
    INNER JOIN products ON sales.product_id = products.product_id
WHERE date >= '2023-08-01'
        AND product_name = 'Патефон'
GROUP BY product_name