--Ex 1 -Faça uma lista com o ranque das ordens, por valor total (incluindo frete e desconto).
Select A.order_id,
	round(((sum((B.quantity*B.unit_price)*(1-B.discount)))+A.freight)::numeric,2) AS vlr_c_desconto,
	RANK() OVER (order BY ((sum((B.quantity*B.unit_price)*(1-B.discount)))+A.freight) DESC)
FROM orders AS A
	LEFT JOIN order_details AS B ON (A.order_id=B.order_id)
GROUP BY 1;
--Ex 2 - Compare o valor de cada ordem com o valor total de vendas.
Select A.order_id, round(((sum((B.quantity*B.unit_price)*(1-B.discount)))+A.freight)::numeric,2) AS vlr_c_desconto,
sum(round(((sum((B.quantity*B.unit_price)*(1-B.discount)))+A.freight)::numeric,2)) OVER () as vlr_total_vendas
FROM orders AS A
LEFT JOIN order_details AS B ON (A.order_id=B.order_id)
group by 1;
--	Letra a - Crie um ranque da participação das ordens no valor total vendido.
--só precisa ordenar, tentar fazer com subquery (with)
WITH temp_table as (
	Select A.order_id, round(((sum((B.quantity*B.unit_price)*(1-B.discount)))+A.freight)::numeric,2) AS vlr_c_desconto,
	sum(round(((sum((B.quantity*B.unit_price)*(1-B.discount)))+A.freight)::numeric,2)) OVER () as vlr_total_vendas
	FROM orders AS A
	LEFT JOIN order_details AS B ON (A.order_id=B.order_id)
	group by 1
	)
select order_id, 
	   round(100*(vlr_c_desconto/vlr_total_vendas)::numeric,6) as perc_participacao,
	   RANK() OVER (order BY (vlr_c_desconto/vlr_total_vendas) DESC)
from temp_table;

--Exercicio 3 - Crie um relatório que traga o número de pedidos e o valor total deles, 
--											bem como seus valores acumulados, por mês para cada vendedor.
SELECT A.employee_id,
		to_char(A.order_date, 'YYYY-MM') as mes,
		COUNT(A.order_id) as numero_pedidos,
		round(((sum((B.quantity*B.unit_price)*(1-B.discount)))+sum(A.freight))::numeric,2) AS vlr_c_desconto,
		SUM(COUNT(A.order_id)) OVER (partition by A.employee_id 
                        			order by A.employee_id, to_char(A.order_date, 'YYYY-MM')) as pedidos_acum_por_mes_para_vend,
		SUM(round(((sum((B.quantity*B.unit_price)*(1-B.discount)))+sum(A.freight))::numeric,2)) 
									OVER (partition by A.employee_id 
                        			order by A.employee_id, to_char(A.order_date, 'YYYY-MM')) as vlr_acum_por_mes_para_vend
FROM orders AS A
LEFT JOIN order_details AS B ON (A.order_id=B.order_id)
GROUP BY 1,2
ORDER BY 1,2;





