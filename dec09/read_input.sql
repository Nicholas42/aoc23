-- vi: ft=sql

CREATE TABLE input(row INT, column INT, val INT);

WITH recursive
input_helper(new_row, row, column, value, rest) AS (
    SELECT 1, -1, -1, NULL, cast(readfile('input.txt') AS TEXT)
    UNION
    SELECT  0, row + new_row, IIF(new_row, 0, column+1), substring(rest,1,instr(rest, ' ')-1) as new_value, substring(rest, instr(rest, ' ')+1) as new_rest FROM input_helper WHERE instr(rest, ' ') < instr(rest, char(10)) AND instr(rest, ' ') > 0
    UNION
    SELECT 1, row, column+1, substring(rest,1,instr(rest, char(10))-1) as new_value, substring(rest, instr(rest, char(10))+1) as new_rest FROM input_helper WHERE instr(rest, ' ') > instr(rest, char(10)) OR (instr(rest, ' ') = 0 ) AND rest != ''
)
INSERT INTO input SELECT row, column, value FROM input_helper WHERE column >= 0;
