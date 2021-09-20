--Exercicio 1- Da tabela territories:
--Letra a - Quantos territórios temos ao todo?
SELECT COUNT(territory_id) as qtd_territorio
from territories;
--Letra b - Quantos territórios por região?
SELECT region_id, COUNT(territory_id) as qtd_territorio
from territories
GROUP BY 1;

--Exercicio 2- Selecione da tabela empolyees::
--Letra a - Quantos empregados reportam para cada chefe?
SELECT reports_to, COUNT(employee_id) as qtd_funcionarios
FROM employees
GROUP BY 1;
--Letra b - Quantos empregados em cada cidade?
SELECT city, COUNT(employee_id) as qtd_funcionarios
FROM employees
GROUP BY 1;

--Exercicio 3 - Selecione da tabela order_details:
--Letra a - Quantas unidades forem vendidas por ordem?
SELECT order_id, SUM(quantity) AS qtd
FROM order_details
GROUP BY 1
ORDER BY 1;
--Letra b - Qual o valor total de cada ordem?
SELECT order_id, SUM((quantity*unit_price)*(1-discount)) AS vlr_total_c_desconto,SUM(quantity*unit_price)AS vlr_total_s_desconto
FROM order_details
GROUP BY 1
ORDER BY 1;
--Letra c - Qual o produto mais vendido?
SELECT product_id, SUM(quantity) AS qtd
FROM order_details
GROUP BY 1
ORDER BY SUM(quantity) DESC
LIMIT 1;
--Letra d - Selecione ordens que tenham menos de três produtos.
SELECT order_id, COUNT(product_id) as qtd_produtos
FROM order_details
GROUP BY 1
HAVING COUNT(product_id)<3;

--Exercicio 4 - Selecione da tabels orders:
--Letra a - Qual cliente realizou mais ordens?
SELECT customer_id, COUNT (DISTINCT(order_id)) AS qtd_ordem
FROM orders
GROUP BY 1
ORDER BY 2 desc
LIMIT 1;
--Letra b - Qual cliente realizou menos ordens?
SELECT customer_id, COUNT (DISTINCT(order_id)) AS qtd_ordem
FROM orders
GROUP BY 1
ORDER BY 2 ASC
LIMIT 1;
--Letra c - Quantas ordens foram feitas por mês?
SELECT DATE_PART('year',order_date) as ano, DATE_PART('month',order_date) as mes, COUNT (DISTINCT(order_id)) AS qtd_ordem
FROM orders
GROUP BY 1,2
ORDER BY 1,2;
--Letra d - Qual o tempo de envio por cliente?
SELECT customer_id, ROUND(AVG(required_date-order_date)::numeric,0) AS qtd_dia_medio_p_envio
FROM orders
GROUP BY 1
ORDER BY 2 DESC;
--Letra e - Faça uma lista ordenada dos países que receberam mais ordens.
SELECT ship_country, COUNT(DISTINCT(order_id))
FROM orders
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
--Letra d - Qual o tempo máximo de envio por cidade?
SELECT ship_city, ROUND(MAX(required_date-order_date)::numeric,0) AS qtd_dia_medio_p_envio
FROM orders
GROUP BY 1
ORDER BY 2 DESC;
--Letra e - Quanto cada cliente gastou em frete?
SELECT employee_id, ROUND(SUM(freight)::numeric,2) AS frete
FROM orders
GROUP BY 1;
--Letra f - Qual o custo total de cada tipo de frete?
SELECT ship_via, ROUND(SUM(freight)::numeric,2) AS frete
FROM orders
GROUP BY 1;
--Letra g - Quanto cada cliente gastou em casa tipo de frete?
SELECT customer_id,ship_via, ROUND(SUM(freight)::numeric,2) AS frete
FROM orders
GROUP BY 1,2
ORDER BY 1,2;

--Exercicio 5 - Selecione da tabela suppliers:
--Uma lista com os países que mais tem fornecedores.
SELECT country, COUNT(supplier_id) as qtd_fornecedores
from suppliers
group by 1
order by 2 desc
LIMIT 5;

--Exercicio 6 - Selecione da tabela products:
--Letra a - Uma lista com o número de produtos por fornecedor.
SELECT supplier_id, COUNT(product_id) AS qtd_produtos
FROM products
GROUP BY 1;
--Letra b - Oderne a lista acima em ordem decrescente.
SELECT supplier_id, COUNT(product_id) AS qtd_produtos
FROM products
GROUP BY 1
ORDER BY 2 DESC;
--Letra c - Uma lista com o número de produtos por fornecedors por categoria.
SELECT supplier_id,category_id, COUNT(product_id) AS qtd_produtos
FROM products
GROUP BY 1,2
ORDER BY 1,2;
--Letra d - Quantos produtos foram descontinuados.
SELECT SUM(discontinued) AS qtd_prod_descontinuados
FROM products;
--Letra e - Fornecedores com estoque baixo (soma de unidades < 20).
SELECT supplier_id,SUM(units_in_stock) AS qtd_em_estoque
FROM products
GROUP BY 1
HAVING (SUM(units_in_stock))<20;
--Letra f - A média do valor total de cada categória.
SELECT category_id, ROUND(AVG(unit_price*units_in_stock)::numeric,2) AS avg_vlr_total_categ
FROM products
GROUP BY 1;
--Letra g - O valor do produto mais barato, mais caro e a média dos valores unitários 
--																por fornecedor e categoria.
SELECT supplier_id, category_id,
		MIN(unit_price) AS prod_mais_barato,
		MAX(unit_price) AS prod_mais_caro,
		ROUND(AVG(unit_price)::numeric,2) AS media_precos_prod		
FROM products
group by 1,2;
