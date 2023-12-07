#!/bin/env -S apl --noSV --script -f common.apl -f

order ← 'AKQJT98765432'

∇R ← Count I
    R ← Sorted +/ (∪I) ∘.∊ I
∇

input ← ReadFile
cards ← ParseCards input
vals ← ParseValues input

ranks ← CalcRanks cards
vals +.× ranks

)OFF
