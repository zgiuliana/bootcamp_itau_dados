--Exercicio 1 - Usando a database estados_cidades (criada na aula 01):
--Letra A - Faça um relatório que traga o número de cidades por estado (nome por extenso) e ordene:
--	Letra a - Ordem alfabética por nome do estado;
SELECT B.nome as estados, COUNT(A.nome) AS qtd_cidades
from tb_cidades as A
	left join tb_estados as B on(A.estado=B.id)
group by 1
ORDER BY 1 ASC;
--	Letra b - Do maior para o menor número de municípios.
SELECT B.nome as estados, COUNT(A.nome) AS qtd_cidades
from tb_cidades as A
	left join tb_estados as B on(A.estado=B.id)
group by 1
ORDER BY 2 DESC;
--Letra B - Uma lista com que as cidades (nome por extenso) que tem municipíos 
--																	com nomes repetidos.
--lista com as cidades que tem os mesmos nomes
SELECT nome, COUNT(nome) AS qtd_cidades
from tb_cidades as A
group by 1
HAVING COUNT(nome)>1
order by 2 desc;
--Letra C - Uma lista com que os estados e as cidades (nome por extenso) que 
--														tem municipíos com nomes repetidos.
SELECT B.nome as estados,A.nome as cidades, COUNT(A.nome) AS qtd_cidades
from tb_cidades as A
	left join tb_estados as B on(A.estado=B.id)
group by 1,2
HAVING COUNT(A.nome)>1
ORDER BY 3 desc;
--	Letra a - Por que o resultado é diferente?
--Um estado não deve ter duas cidades com o mesmo nome, mas se não consideramos os estados
-- podemos ter esses casos.


--Exercicio 2 - No banco de dados do Northwind, obtenha:
--Letra a - Uma lista dos 10 clientes que realizaram o maior número de pedidos,
--												bem como o número de pedidos de cada, 
--												ordenados em ordem decrescente de nº de pedidos.
SELECT A.*,
	   COUNT(B.order_id) AS qtd_pedidos
from customers as A
	left join orders as B on (A.customer_id=B.customer_id)
group by A.customer_id
order by COUNT(B.order_id) desc
LIMIT 10;
--Letra b - Uma tabela com o valor médio das vendas em cada mês, ordenando do mês 
--												com mais vendas ao mês com menos vendas.
SELECT DATE_PART('year',A.order_date),
	   DATE_PART('MONTH',A.order_date),
	   round((avg((B.quantity*B.unit_price)*(1-B.discount)))::numeric,2) AS media_vlr_c_desconto,
	   round((avg((B.quantity*B.unit_price)))::numeric,2) AS media_vlr_s_desconto
FROM orders AS A
	LEFT JOIN order_details AS B ON (A.order_id=B.order_id)
GROUP BY 1,2
ORDER BY SUM(B.quantity);