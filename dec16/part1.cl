#!/bin/env clisp

(load "common.cl")
(readFile (first *args*))

(print (tryStart (list 0 0 +east+)))
