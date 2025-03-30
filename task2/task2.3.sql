SELECT c.name AS car_name,
       cl.class AS car_class,
       AVG(r.position) AS average_position,
       COUNT(r.race) AS race_count,
       cl.country AS car_country,
       cls_total.total_races
FROM Cars c
JOIN Classes cl ON c.class = cl.class
JOIN Results r ON c.name = r.car
JOIN (
    SELECT cl2.class,
           AVG(r2.position) AS class_avg_position
    FROM Cars c2
    JOIN Classes cl2 ON c2.class = cl2.class
    JOIN Results r2 ON c2.name = r2.car
    GROUP BY cl2.class
    HAVING AVG(r2.position) = (
        SELECT MIN(class_avg)
        FROM (
            SELECT AVG(r3.position) AS class_avg
            FROM Cars c3
            JOIN Classes cl3 ON c3.class = cl3.class
            JOIN Results r3 ON c3.name = r3.car
            GROUP BY cl3.class
        ) AS class_avg_sub
    )
) AS best_classes ON cl.class = best_classes.class
JOIN (
    SELECT cl4.class,
           COUNT(r4.race) AS total_races
    FROM Cars c4
    JOIN Classes cl4 ON c4.class = cl4.class
    JOIN Results r4 ON c4.name = r4.car
    GROUP BY cl4.class
) AS cls_total ON cl.class = cls_total.class
GROUP BY c.name, cl.class, cl.country, cls_total.total_races
ORDER BY c.name;