#!/bin/env clisp
(load "common.cl")

(readFile "input.txt")

(print (max
         (loop for y below *height*
             maximize
             (max
               (tryStart (list 0 y +east+))
               (tryStart (list (- *width* 1) y +west+))
               ))
         (loop for x below *width*
             maximize
             (max
               (tryStart (list x 0 +south+))
               (tryStart (list x (- *height* 1) +north+))
               )))
       )
