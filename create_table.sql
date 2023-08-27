-- Создание таблицы-измения "Товары".
CREATE TABLE IF NOT EXISTS public.products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    price NUMERIC NOT NULL CHECK (price >0)
)
DISTRIBUTED BY (product_id);-- Разделяем таблицу на сегменты по полю 'product_id'.

-- Создание таблицы-фактов "Продажи". 
CREATE TABLE IF NOT EXISTS public.sales(
    sale_id BIGSERIAL,
    date DATE NOT NULL,
    product_id INT NOT NULL,
    sales_cnt SMALLINT NOT NULL CHECK (sales_cnt >=0)
)
DISTRIBUTED BY (sale_id)  -- Разделяем таблицу на сегменты по полю 'sale_id'. 
PARTITION BY RANGE (date) -- Полe для создания партиции - 'date'. 
(
    START (DATE '2023-04-01') INCLUSIVE -- Разделяем на партиции с 23-04-01 (первая запись) до конца 2023 года помесячно ВКЛЮЧИТЕЛЬНО.
    END (DATE '2023-12-31') INCLUSIVE 
    EVERY (INTERVAL '1 month')
);