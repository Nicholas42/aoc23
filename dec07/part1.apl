#!/bin/env -S apl --noSV --script -f common.apl -f

order ← '23456789TJQKA'

∇R ← Count I
    R ← Sorted +/ (∪I) ∘.∊ I
∇

input ← ReadFile
cards ← CalculateKeys input
vals ← ParseValues input

ranks ← CalcRanks cards
vals[ranks] +.× (⍳≢cards)

)OFF
