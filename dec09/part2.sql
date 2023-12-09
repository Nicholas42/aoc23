-- vi: ft=sql

.read 'read_input.sql'

WITH
max_column(in_row, max_column)  AS (
    SELECT row, MAX(column) FROM input GROUP BY row
)
UPDATE input
SET column = max_column - column
FROM (SELECT max_column FROM input JOIN max_column ON row = in_row);

.read 'calculation.sql'
