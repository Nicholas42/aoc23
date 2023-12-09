-- vi: ft=sql

WITH recursive
max_depth(in_row, max_depth) AS (
    SELECT row, COUNT(column) FROM input GROUP BY row
),
indices_left(row, column, val, depth) AS (
    SELECT row, column + 0, val, 0 FROM input
    UNION ALL
    SELECT row, column-1, val, depth+1 FROM indices_left
    WHERE column > 0 AND depth < (SELECT max_depth FROM max_depth where in_row = row)
    UNION ALL
    SELECT row, column, -val, depth+1 FROM indices_left
    WHERE column + depth < (SELECT max_depth FROM max_depth where in_row = row)
)
SELECT -SUM(val) FROM indices_left WHERE depth = (SELECT max_depth FROM max_depth WHERE in_row = row) GROUP BY column, depth ORDER BY row, depth;
