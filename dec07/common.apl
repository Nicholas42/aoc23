Zero ← ⎕UCS '0'

∇R ← CalculateKeys I
    R ← { CalcKey ⍵[⍳ 5] }¨ I
∇

∇R ← ParseValues I
    R ← {({⍺+10×⍵}/(⌽(⎕UCS 6↓⍵) - Zero))}¨ I
∇

∇R ← ReadFile
    index ← 1 + ⎕Arg ⍳ ⊂'--'
    R ← ⎕FIO[49] ⊃⎕Arg[index]

∇

∇R ← Sorted I
    R ← I[⍒I]
∇

∇ R ← CalcKey I
    R ← {⍺+15×⍵}/⌽((5⍴ Count I), (order⍳I))
∇

∇R ← CalcRanks cards;maxRank
    R ← ⍋ cards
∇
