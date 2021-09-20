--Exercício 1 - Selecione os id's únicos de territórios da tabela employee_territories
SELECT DISTINCT territory_id 
FROM employee_territories;

--Exercício 2 - Selecione da tabela empolyees:
--Letra a - Todos os nomes dos empregados;
SELECT first_name,last_name, concat(first_name,' ',last_name) AS full_name
FROM employees;
--Letra b - Os sobrenomes distintos dos empregrados;
SELECT DISTINCT last_name
FROM employees;
--Letra c - Empregados que nasceram após 1970;
SELECT first_name,last_name, concat(first_name,' ',last_name) AS full_name
FROM employees
WHERE EXTRACT(YEAR FROM BIRTH_DATE)>1970;
--Letra d - Empregados que foram contratados em 1993;
SELECT first_name,last_name, concat(first_name,' ',last_name) AS full_name
FROM employees
WHERE EXTRACT(YEAR FROM hire_date)=1993;
--Letra e - Empregados que nasceram entre 1980 e 1985 (inclusos);
SELECT first_name,last_name, (first_name ||' ' ||last_name) AS full_name
FROM employees
WHERE EXTRACT(YEAR FROM birth_date) BETWEEN 1980 AND 1985;
--Letra f - Empregados que nasceram em 1963 e foram contratados em 1993;
SELECT first_name,last_name, concat(first_name,' ',last_name) AS full_name
FROM employees
WHERE DATE_PART('year',birth_date)=1963 and date_part('year', hire_date)=1993;
--Letra g - Todos os empregrados que reportam o chefe de id 5;
SELECT first_name,last_name, concat(first_name,' ',last_name) AS full_name
FROM employees
WHERE reports_to=5;
--Letra h - Todos os empregados que moram em Seattle ou Kirkland.
SELECT first_name,last_name, concat(first_name,' ',last_name) AS full_name
FROM employees
WHERE city IN ('Seattle','Kirkland');

--Exercício 3 - Selecione da tabela order_details:
--Letra a - Produtos (product_id) com mais de 50 unidades vendidas;
SELECT PRODUCT_ID,order_id, quantity
FROM order_details
WHERE quantity>50
ORDER BY 1;
--Letra b - Produtos com mais de 0.2 de desconto;
SELECT PRODUCT_ID,order_id,discount
FROM order_details
WHERE discount>0.2
ORDER BY 1;
--Letra c - Produtos com 0.05 ou menos de desconto;
SELECT PRODUCT_ID,order_id,discount
FROM order_details
WHERE discount<=0.05
ORDER BY 1;

--Exercício 4 - Selecione da tabels orders:
--Letra a - Ordens realizadas antes Setembro de 1996.
SELECT *
FROM orders
where order_date<'01/09/1996';
--Letra b - Ordens enviadas em Setembro de 1996.
SELECT *
FROM orders
where DATE_PART('year',order_date)=1996 and DATE_PART('month',order_date)=9;
--Letra c - Ordens que possuam o campo região preenchido.
SELECT *
FROM orders
where ship_region IS NOT NULL;
--Letra d - As primeiras 5 linhas da tabela, reescrevendo o nome das colunas de data em português.
SELECT order_id,customer_id,employee_id,
order_date AS data_pedido,
required_date as data_entrega_obrigatoria,
shipped_date as data_envio,
ship_via,freight,ship_name,ship_address,ship_city,ship_region,ship_postal_code,ship_country
FROM orders
LIMIT 5;


--Exercício 5 - Selecione da tabela suppliers:
--Letra a - Todos os contatos cujo nome comece com a letra M;
SELECT *
FROM suppliers
WHERE contact_name LIKE 'M%';
--Letra b - Todos os contatos que tenham a palavra manager no titulo;
SELECT *
FROM suppliers
WHERE UPPER(contact_title) LIKE '%MANAGER%';
--Letra c - Todos os contatos que trabalhem com vendas e morem nos países nórdicos.
--Dinamarca, Finlândia, Islândia, Noruega e Suécia
SELECT *
FROM suppliers
WHERE UPPER(country) in ('DENMARK','FINLAND','ICELAND','NORWAY','SWEDEN');