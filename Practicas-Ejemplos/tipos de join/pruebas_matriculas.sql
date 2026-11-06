
SELECT 
    *
FROM
    alumnos
        JOIN
    matriculas USING (id_alumno)
        JOIN
    cursos USING (id_curso);

-- alumnos con matriculaciones dejando huecos.

SELECT 
    *
FROM
    alumnos a
        LEFT JOIN
    matriculas m ON a.id_alumno = m.id_alumno
        LEFT JOIN
    cursos c ON m.id_curso = c.id_curso;
   
-- saca el listado de matriculas en cursos inexistentes
   
   SELECT 
    *
FROM
    matriculas m
        LEFT JOIN
    cursos c ON m.id_curso = c.id_curso
WHERE
    c.id_curso IS NULL;
   
-- saca el listado de los cursos sin matricula
   
	SELECT 
    *
FROM
    matriculas m
        RIGHT JOIN
    cursos c ON m.id_curso = c.id_curso
WHERE
    m.id_curso IS NULL;
   
   
-- Alumnos matriculados en cursos inexistentes.

SELECT 
    *
FROM
    matriculas m
        RIGHT JOIN
    alumnos a ON m.id_alumno = a.id_alumno
WHERE
    m.id_alumno IS NULL;

-- matriculas de alumnos inexistentes.

SELECT 
    *
FROM
    matriculas m
        LEFT JOIN
    alumnos a ON m.id_alumno = a.id_alumno
WHERE
    a.id_alumno IS NULL;