--Exercicio 1 - Encontre o resultado da sessão de 4.1 SELF JOIN usando o CROSS JOIN 
--																	ao invés do LEFT JOIN.
SELECT  em1.first_name as colaborador, em2.first_name gestor
FROM employees em1 CROSS JOIN employees em2;

--Exercicio 2 - Para as tabelas da base estados_cidades:
--Letra a - Identifique as chaves primária e estrangeira;
--Tabelas:
	--tb_cidades: 
		--Chave Primaria: id
		--Chave Estrangeira: estado
	--tb_estados:
		--Chave Primaria: id
		--Chave Estrangeira: -		
--Letra b - Faça um EDR: Enviado em anexo (ex2_letrab_estados_cidades.png)

--Exercicio 3 - Para as tabelas da base northwind:
--Letra a - Identifique as chaves primária e estrangeira;
	--categories:
		--Chave Primaria: category_id
		--Chave Estrangeira: -	
	--customers:
		--Chave Primaria: customer_id
		--Chave Estrangeira: -	
	--employee_territories:
		--Chave Primaria: 
		--Chave Estrangeira: employee_id, territory_id
	--employees:
		--Chave Primaria: employee_id
		--Chave Estrangeira: reports_to
	--order_details:
		--Chave Primaria: 
		--Chave Estrangeira: product_id, order_id	
	--orders:
		--Chave Primaria: order_id
		--Chave Estrangeira: customer_id,employee_id,ship_via
	--products:
		--Chave Primaria: product_id
		--Chave Estrangeira: supplier_id,category_id	
	--region:
		--Chave Primaria: region_id
		--Chave Estrangeira: -	
	--shippers:
		--Chave Primaria: shipper_id
		--Chave Estrangeira: -	
	--suppliers:
		--Chave Primaria: supplier_id
		--Chave Estrangeira: -	
	--territories:
		--Chave Primaria: territory_id
		--Chave Estrangeira: region_id	
	--us_states:
		--Chave Primaria: state_id
		--Chave Estrangeira: -	
	--customer_customer_demo:
		--Chave Primaria: -
		--Chave Estrangeira: customer_id, customer_type_id
	--customer_demographics:
		--Chave Primaria: customer_type_id
		--Chave Estrangeira: -
--Letra b - Faça um EDR (chaves primária e estrangeira + uma coluna): Enviado em anexo (ex3_letrab_northwind.png) 

--Exercicio 4 - Suponha que o task envolva combinar informações da tablea categories com a tabela orders. Faça um esboço da query (importante fazer os joins certos).
--Enviado em anexo (ex4_northwind_categories_orders.png) 

--Exercicio 5 - Suponha que o task envolva combinar informações da tablea supliers com a tabela customers_demographics. Faça um esboço da query (importante fazer os joins certos).
--Enviado em anexo (ex5_northwind_suppliers_customer_demografics.png) 

--Desafio: Quantas ordens de compra há para cada categoria de produto?
select C.category_id, C.category_name, count(distinct(A.order_id)) as qtd_orders
from order_details AS A
LEFT JOIN products AS B ON (A.product_id=B.product_id)
LEFT JOIN categories AS C ON (B.category_id=C.category_id)
GROUP BY 1,2;