--Exercício 1 - Selecione os id's únicos de territórios da tabela employee_territories
SELECT DISTINCT territory_id 
FROM employee_territories
ORDER BY territory_id DESC;

--Exercício 2 - Selecione da tabela empolyees (não esqueça de nomear as colunas criadas):
--Letra a - O nome completo dos empregados em ordem alfabética;
SELECT concat(first_name,' ',last_name) AS full_name
FROM employees
ORDER BY full_name;
--Letra b - O nome completo dos empregados com o respectivo titulo em ordem decrescente;
SELECT concat(first_name,' ',last_name) AS full_name, title
FROM employees
ORDER BY full_name DESC;
--Letra c - Os sobrenomes distintos dos empregrados;
SELECT DISTINCT last_name
FROM employees;
--Letra d - O ano de nascimento dos empregados usando funções de tempo
SELECT DISTINCT first_name, DATE_PART('year', birth_date)
FROM employees;
--Letra e - O ano de nascimento dos empregados usando funções de string
SELECT DISTINCT first_name, SUBSTRING(cast(birth_date as varchar),1,4)
FROM employees;
--Letra f - A idade atual dos empregados em ordem decrescente
SELECT DISTINCT first_name, age(birth_date) as idade
FROM employees
Order BY idade DESC;
--Letra g - A idade que os empregados tinham quando foram contratados em ordem crescente;
SELECT DISTINCT first_name, age(hire_date,birth_date) as idade
FROM employees
Order BY idade asc;
--Letra h - Quem é e qual a idade do empregado mais velho?
SELECT DISTINCT first_name, age(birth_date) as idade
FROM employees
Order BY idade desc
limit 1;
--Letra i - Qual a pessoa mais jovem que foi contratada?
SELECT DISTINCT first_name, age(birth_date) as idade
FROM employees
Order BY idade asc
limit 1;
--Letra j - Crie uma coluna que mapeie os cargos dos empregados
--				com a posição hierárquica na lista, sendo 1 o mais alto.
SELECT *, 
CASE WHEN title='Vice President, Sales' then 1
	 WHEN title='Sales Manager' then 2
	 WHEN title='Inside Sales Coordinator' then 3
	 ELSE 4 END AS pos_hierarquica
FROM employees;
--Letra k - O tempo de empresa dos respectivos empegados.
SELECT concat(first_name,' ',last_name) AS full_name, AGE(hire_date) as tempo_contratacao
FROM employees;

--Exercicio 2 - Selecione da tabela products:
--Letra a - Os três produtos mais caros com seus respectivos preços;
SELECT product_id,product_name,unit_price
FROM products
ORDER BY unit_price DESC
LIMIT 3;
--Letra b - Os 10 produtos com estoque mais baixo (diferentes de 0) com suas respectivas quantidades;
SELECT product_id,product_name, sum(units_in_stock) as units_in_stock
FROM products
GROUP BY 1,2
HAVING units_in_stock>=1
ORDER BY units_in_stock ASC
LIMIT 10;
--Letra c - Os 5 produtos com maior valor agregado atualmente em estoque;
SELECT product_id,product_name, sum(units_in_stock) as units_in_stock, sum(unit_price) as unit_price
FROM products
GROUP BY 1,2
HAVING units_in_stock>=1
ORDER BY unit_price desc
LIMIT 5;
--Letra d - Produtos com mais de 100 unidades no estoque ou valor unitário inferior 15;
SELECT product_id,product_name, sum(units_in_stock) as units_in_stock, sum(unit_price) as unit_price
FROM products
GROUP BY 1,2
HAVING units_in_stock>=100 and unit_price<15;

--Exercicio 4 - Selecione da tabels orders:
--Letra a - O primeiro nome do destinatário da entrega (ship_name);
--			Perguntar ainda precisa refinar, pois quando só tem um nome fica vazio
SELECT ship_name,
		CASE WHEN SUBSTRING(ship_name,1,POSITION(' ' in ship_name))='' THEN ship_name
		ELSE SUBSTRING(ship_name,1,POSITION(' ' in ship_name)) END as Output1
FROM orders;
--Letra b - O tempo (em dias) entre a compra e a entrega;
SELECT *,(shipped_date-order_date) as tempo_compra_entrega
FROM orders;
--Letra c - Os cinco fretes mais caros e com maior tempo de entrega (sem dados nulos);
SELECT *,(required_date-order_date) as tempo_compra_entrega
FROM orders
GROUP BY ORDER_ID
HAVING (required_date-order_date)>1
ORDER BY freight desc,tempo_compra_entrega desc
LIMIT 5;
--Letra d - Os cinco fretes com maior tempo de entrega e mais caros (sem dados nulos); 
--															(sim, é diferente do anterior)
SELECT *,(required_date-order_date) as tempo_compra_entrega
FROM orders
GROUP BY ORDER_ID
HAVING (required_date-order_date)>1
ORDER BY tempo_compra_entrega desc, freight desc
LIMIT 5;
--Letra e - Os 3 fretes mais baratos do Brasil.
SELECT *
FROM orders
GROUP BY 1
HAVING (ship_country)='Brazil'
ORDER BY freight ASC
LIMIT 3;
--Letra f - Uma tabela com as três primeiras letras do nome do pais, 
--						o tempo de entrega e o frete ordenados em ordem crescente.
SELECT SUBSTRING(ship_country,1,3),
	   ROUND(AVG(required_date-order_date)::numeric,0) as tempo_entrega,
	   ROUND(AVG(freight)::numeric,2) AS frete
FROM orders
GROUP BY 1
ORDER BY 1 ASC, 2 ASC,3 ASC;