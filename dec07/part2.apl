#!/bin/env -S apl --noSV --script -f common.apl -f

order ← 'J23456789TQKA'

∇R ← Count I;Js
    Js ← +/ 'J' = I
    R ← Sorted +/ (∪I) ∘.{(⍺≢'J') ∧ (⍺∊⍵)} I
    →(Js = 0)⍴0
    R ← (R[1] + Js), (1↓¯1↓R)
∇

data ← ReadFile
cards ← CalculateKeys data
vals ← ParseValues data

ranks ← CalcRanks cards
vals[ranks] +.× (⍳≢cards)

)OFF
