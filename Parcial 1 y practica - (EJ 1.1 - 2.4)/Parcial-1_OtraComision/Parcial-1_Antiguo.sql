use MODELOPARCIAL2_PUNTO2

/*
A) El ganador del torneo es aquel que haya capturado el pez m�s pesado entre todos los
peces siempre y cuando se trate de un pez no descartado. Puede haber m�s de un ganador
del torneo. Listar Apellido y nombre, especie de pez que captur� y el pesaje del mismo.
select top 1 with ties PA.APELLIDO, PA.NOMBRE, ESP.ESPECIE, max(PE.PESO) 
from PESCA as PE
join ESPECIES as ESP on ESP.IDESPECIE=PE.IDESPECIE
join PARTICIPANTES as PA on PA.IDPARTICIPANTE=PE.IDPARTICIPANTE
group by PA.APELLIDO,PA.NOMBRE, ESP.ESPECIE
order by max(PE.PESO) desc

/*
B) Listar todos los participantes que no hayan pescado ning�n tipo de bagre. (ninguna
especie cuyo nombre contenga la palabra "bagre"). Listar apellido y nombre.
select AUX.APELLIDO, AUX.NOMBRE from(
	select PA.APELLIDO, PA.NOMBRE,
	(
		select count(*) from ESPECIES as E
		join PESCA as PE on PE.IDESPECIE=E.IDESPECIE
		where E.ESPECIE like '%bagre%' and PE.IDPARTICIPANTE=PA.IDPARTICIPANTE
	) as cantBagres
	from PARTICIPANTES as PA
) as AUX
where AUX.cantBagres=0


/*
C) Listar los participantes cuyo promedio de pesca (en kilos) sea mayor a 30. Listar apellido,
nombre y promedio de kilos. ATENCI�N: No tener en cuenta los peces descartados.
durante la noche. (Se tiene en cuenta a la noche como el horario de la competencia entre las
21pm y las 5am -ambas inclusive-).
cantidad de peces descartados que captur�.
Si alguna especie de pez no ha sido pescado nunca entonces deber� aperecer en el listado de todas formas pero sin datos de pescador. 
El listado debe aparecer ordenado por nombre de especie de manera creciente. La combinaci�n apellido,