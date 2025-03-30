SELECT c.name AS car_name,
       cl.class AS car_class,
       AVG(r.position) AS average_position,
       COUNT(r.race) AS race_count,
       cl.country AS car_country
FROM Cars c
JOIN Classes cl ON c.class = cl.class
JOIN Results r ON c.name = r.car
GROUP BY c.name, cl.class, cl.country
ORDER BY AVG(r.position), c.name
LIMIT 1;