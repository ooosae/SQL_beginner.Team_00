WITH
  RECURSIVE path (passed, last_point, total_cost) AS (
    SELECT point1 || ',' ||  point2, point2, cost
    FROM nodes AS n
    WHERE point1 = 'a'

    UNION ALL

    SELECT
      path.passed || ',' || n.point2,
      n.point2,
      path.total_cost + n.cost
    FROM path
    JOIN nodes AS n ON path.last_point = n.point1
    WHERE (POSITION (n.point2 IN path.passed) = 0) OR
        (LENGTH(path.passed) = 7 AND POSITION (n.point2 IN path.passed) = 1)
  ),
  p AS (SELECT * FROM path WHERE LENGTH(path.passed) = 9)
SELECT total_cost, ('{' || passed || '}') AS tour
FROM p
WHERE total_cost = (SELECT MIN(total_cost) FROM p) OR
    total_cost = (SELECT MAX(total_cost) FROM p)
ORDER BY 1,2;