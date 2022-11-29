WITH ultima_revision AS(
SELECT 	r.id_coche, MAX(fecha_revision) as fecha
FROM practica_ee.revisiones as r
GROUP BY r.id_coche
),

ultima_poliza AS(
SELECT p.id_coche, MAX(fecha_contratacion) as fecha_poliza
FROM practica_ee.polizas as p
GROUP BY p.id_coche
)

SELECT 	m.nombre as modelo
		,mr.nombre as marca
		,g.nombre as grupo
		,c.fecha_compra
		,c.matricula
		,clr.nombre as color
		,r.kilometros
		,a.nombre as aseguradora
		,p2.num_poliza as numero_de_poliza
FROM practica_ee.coches as c
INNER JOIN practica_ee.colores as clr
ON c.id_color = clr.id_color
INNER JOIN practica_ee.modelos as m
ON c.id_modelo = m.id_modelo
INNER JOIN practica_ee.marcas as mr
ON m.id_marca = mr.id_marca
INNER JOIN practica_ee.grupos as g
ON mr.id_grupo = g.id_grupo
LEFT JOIN ultima_revision as ur
ON c.id_coche = ur.id_coche
INNER JOIN practica_ee.revisiones as r
ON ur.id_coche = r.id_coche AND ur.fecha = r.fecha_revision
LEFT JOIN ultima_poliza as up
ON c.id_coche = up.id_coche
INNER JOIN practica_ee.polizas as p2
ON up.id_coche = p2.id_coche AND up.fecha_poliza = p2.fecha_contratacion
INNER JOIN practica_ee.aseguradoras as a
ON p2.id_aseguradora = a.id_aseguradora
WHERE c.flag_activo = true
ORDER BY c.fecha_compra;