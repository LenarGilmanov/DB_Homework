SELECT c.name AS car_name,
       cl.class AS car_class,
       AVG(r.position) AS average_position,
       COUNT(r.race) AS race_count
FROM Cars c
JOIN Classes cl ON c.class = cl.class
JOIN Results r ON c.name = r.car
GROUP BY c.name, cl.class
HAVING AVG(r.position) = (
    SELECT MIN(avg_pos)
    FROM (
        SELECT AVG(r2.position) AS avg_pos
        FROM Cars c2
        JOIN Classes cl2 ON c2.class = cl2.class
        JOIN Results r2 ON c2.name = r2.car
        WHERE cl2.class = cl.class
        GROUP BY c2.name
    ) AS subquery
)
ORDER BY average_position;