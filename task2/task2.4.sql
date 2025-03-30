SELECT c.name AS car_name,
       cl.class AS car_class,
       AVG(r.position) AS average_position,
       COUNT(r.race) AS race_count,
       cl.country AS car_country
FROM Cars c
JOIN Classes cl ON c.class = cl.class
JOIN Results r ON c.name = r.car
GROUP BY c.name, cl.class, cl.country
HAVING AVG(r.position) < (
    SELECT AVG(r2.position)
    FROM Cars c2
    JOIN Results r2 ON c2.name = r2.car
    WHERE c2.class = c.class
)
AND (
    SELECT COUNT(DISTINCT c3.name)
    FROM Cars c3
    WHERE c3.class = c.class
) >= 2
ORDER BY cl.class, average_position;
