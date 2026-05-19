--Aula dia 19/05/2026

--subconsulta

SELECT nome
FROM produto
where id IN (
	select id_produto
    from Produto_Caracteristica
    where id_caracteristica = (
		select id
        from caracteristica
        where nome = 'Sistema Operacional'
        AND descricao = 'Android 12'
	)
);

select p.nome as pNome
from Produto p
where p.id in (
	select pc.id_produto
    from produto_caracteristica pc
    where pc.id_caracteristica in (
		select c.id
        from caracteristica c
        where c.nome = 'Tela HD'
	)
);

--com inner join para ter nomes

select p.nome as pNome, c.nome
from Produto p
inner join produto_caracteristica pc
inner join caracteristica c
on p.id = pc.id_produto
and pc.id_caracteristica = c.id
where p.id in (
	select pc.id_produto
    from produto_caracteristica pc
    where pc.id_caracteristica in (
		select c.id
        from caracteristica c
        where c.nome = 'Tela HD'
	)
);

-- opcao com innerjoin
select p.nome as pNome, c.nome
from Produto p
inner join produto_caracteristica pc
inner join caracteristica c
on p.id = pc.id_produto
and pc.id_caracteristica = c.id
where c.nome = 'Tela HD';

--case
select nome,tipo, preco,
	case
		when tipo = 'Usado' then preco * 0.10
        when tipo = 'Promocao' then preco * 0.20
        when tipo = 'Liquidacao' then preco * 0.30
        else 0.0
	end as novoDesconto
from Produto;