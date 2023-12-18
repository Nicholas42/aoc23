#!/bin/env clisp

(load "common.cl")

(readFile (first *args*))

(princ (tryStart (list 0 0 +east+)))
