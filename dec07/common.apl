Zero ← ⎕UCS '0'

∇R ← ParseCards I
    R ← { (GetType Count ⍵[⍳ 5]) ⍵[⍳ 5] }¨ I
∇

∇R ← ParseValues I
    R ← {({⍺+10×⍵}/(⌽(⎕UCS 6↓⍵) - Zero))}¨ I
∇

∇R ← ReadFile
    R ← ⎕FIO[49] "input.txt"
∇

∇R ← Sorted I
    R ← I[⍒I]
∇

∇R ← A Lt B;Ao;Bo;diff
    R ← A[1] < B[1]
    →(A[1] ≠ B[1])⍴0
    →(A[2] ≡ B[2])⍴0

    Ao ← order ⍳ (⊃A[2])
    Bo ← order ⍳ (⊃B[2])

    diff ← (Ao =¨ Bo) ⍳ 0
    R ← (diff ⌷ Ao) >  (diff ⌷ Bo)
∇

∇ R ← GetType I
    R ← {⍺+6×⍵}/⌽(5⍴I)
∇

∇R ← CalcRanks cards;maxRank
    maxRank ← ≢cards
    R ← maxRank - +/ (cards ∘.Lt cards)
∇
