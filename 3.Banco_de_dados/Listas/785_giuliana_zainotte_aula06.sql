--Resolva o problema da base northwind abaixo usando as três técnicas aprendidas na
--								aula (exceto para o 5, que pode ser feito uma única vez,
--								com a técnica de sua preferência):
--A. Select from select
--Exercicio 1 - Quantos clientes fizeram mais de 10 pedidos?
select count(*) from (
	select customer_id, count(order_id) as qtd_ordem
	from orders
	group by 1
	having COUNT(order_id)>10)
as tb_qtd_cli;
--Exercicio 2 - Quantos vendedores tiveram menos de 70 pedidos?
select count(*) from (
	select employee_id, count(order_id) as qtd_ordem
	from orders
	group by 1
	having COUNT(order_id)<70)
as tb_qtd_cli;
--Exercicio 3 - Qual a média dos valores por pedido de cada vendedor?
select round((avg(vlr_total_c_desconto)::numeric),2) as vlr_total_c_desconto,
	   round((avg(vlr_total_s_desconto)::numeric),2) as vlr_total_s_desconto
from(
	select A.employee_id, 
	AVG((B.quantity*B.unit_price)*(1-B.discount)) AS vlr_total_c_desconto,
	AVG(B.quantity*B.unit_price)AS vlr_total_s_desconto
	FROM orders as A
	LEFT JOIN order_details AS B ON (A.order_id=B.order_id)
	GROUP BY 1)
as tb_avg_vlr;

--Exercicio 4 - Quantos vendedores tiveram menos de 300 pedidos e média superior a 700 por pedido?
select count(*) from (
select A.employee_id, 
	count(distinct(a.order_id)) as ordem,
	AVG(B.quantity*B.unit_price)AS vlr_total_s_desconto
	FROM orders as A
	LEFT JOIN order_details AS B ON (A.order_id=B.order_id)
	GROUP BY 1
	having count(distinct(a.order_id))<300 and AVG(B.quantity*B.unit_price)>700)
as tb_qtd_vend;

--B. WITH
--Exercicio 1 - Quantos clientes fizeram mais de 10 pedidos?
with tabela_tmp_with as (
	select customer_id, count(order_id) as qtd_ordem
	from orders
	group by 1
	having COUNT(order_id)>10
)
select count(*) from tabela_tmp_with;

--Exercicio 2 - Quantos vendedores tiveram menos de 70 pedidos?
with tabela_tmp_with as (
	select employee_id, count(order_id) as qtd_ordem
	from orders
	group by 1
	having COUNT(order_id)<70)
select count(*) from tabela_tmp_with;
--Exercicio 3 - Qual a média dos valores por pedido de cada vendedor?
with tabela_tmp_with as (
	select A.employee_id, 
	AVG((B.quantity*B.unit_price)*(1-B.discount)) AS vlr_total_c_desconto,
	AVG(B.quantity*B.unit_price)AS vlr_total_s_desconto
	FROM orders as A
	LEFT JOIN order_details AS B ON (A.order_id=B.order_id)
	GROUP BY 1)
select round((avg(vlr_total_c_desconto)::numeric),2) as vlr_total_c_desconto,
	   round((avg(vlr_total_s_desconto)::numeric),2) as vlr_total_s_desconto
from tabela_tmp_with;
	
--Exercicio 4 - Quantos vendedores tiveram menos de 300 pedidos e média superior a 700 por pedido?
with tabela_tmp_with as (
	select A.employee_id, 
	count(distinct(a.order_id)) as ordem,
	AVG(B.quantity*B.unit_price)AS vlr_total_s_desconto
	FROM orders as A
	LEFT JOIN order_details AS B ON (A.order_id=B.order_id)
	GROUP BY 1
	having count(distinct(a.order_id))<300 and AVG(B.quantity*B.unit_price)>700)
select count(*) from tabela_tmp_with;	

--C. VIEW

--Exercicio 1 - Quantos clientes fizeram mais de 10 pedidos?
create view qtd_clientes_10_pedidos as (
	select customer_id, count(order_id) as qtd_ordem
	from orders
	group by 1
	having COUNT(order_id)>10
);

select count(*) from qtd_clientes_10_pedidos;

--Exercicio 2 - Quantos vendedores tiveram menos de 70 pedidos?
create view qtd_vends_70_pedidos as (
	select employee_id, count(order_id) as qtd_ordem
	from orders
	group by 1
	having COUNT(order_id)<70
);

select count(*) from qtd_vends_70_pedidos;

--Exercicio 3 - Qual a média dos valores por pedido de cada vendedor?
create view qtd_media_vend as (
	select A.employee_id, 
	AVG((B.quantity*B.unit_price)*(1-B.discount)) AS vlr_total_c_desconto,
	AVG(B.quantity*B.unit_price)AS vlr_total_s_desconto
	FROM orders as A
	LEFT JOIN order_details AS B ON (A.order_id=B.order_id)
	GROUP BY 1
);

select round((avg(vlr_total_c_desconto)::numeric),2) as vlr_total_c_desconto,
	   round((avg(vlr_total_s_desconto)::numeric),2) as vlr_total_s_desconto
from qtd_media_vend;
	


--Exercicio 4 - Quantos vendedores tiveram menos de 300 pedidos e média superior a 700 por pedido?
create view qtd_vend_par as (
	select A.employee_id, 
	count(distinct(a.order_id)) as ordem,
	AVG(B.quantity*B.unit_price)AS vlr_total_s_desconto
	FROM orders as A
	LEFT JOIN order_details AS B ON (A.order_id=B.order_id)
	GROUP BY 1
	having count(distinct(a.order_id))<300 and AVG(B.quantity*B.unit_price)>700
);

select count(*) from qtd_vend_par;
drop view qtd_vend_par,qtd_media_vend,qtd_vends_70_pedidos,qtd_clientes_10_pedidos;
----------------------------------
--Ex 5 - Criar uma tabela com: categoria|numero_de_pedidos|valor_total|media_de_valores
--Dica: Categorizar as ordens de acordo com o preço total (incluindo frete) em:

--Gold: valor_total >= 5.000
--Silver: 1.000 <= valor_total < 5.000
--Bronze: valor_total < 1000

with tabela_tmp_with as (
	SELECT 
	A.order_id,
	CASE WHEN SUM(((B.quantity*B.unit_price)*(1-B.discount))+freight)>5000 then 'Gold'
		 WHEN SUM(((B.quantity*B.unit_price)*(1-B.discount))+freight)<1000 then 'Bronze'
		 ELSE 'Silver' end as categoria,
	SUM(((B.quantity*B.unit_price)*(1-B.discount))+freight) as valor_total
	FROM orders as A
	LEFT JOIN order_details AS B ON (A.order_id=B.order_id)
	GROUP BY 1
)
select categoria, COUNT(DISTINCT(order_id)) as num_pedidos, 
		round((sum(valor_total)::numeric),2) as valor_total, round((AVG(valor_total)::numeric),2) as media_valor_total
from tabela_tmp_with
Group by 1;	

