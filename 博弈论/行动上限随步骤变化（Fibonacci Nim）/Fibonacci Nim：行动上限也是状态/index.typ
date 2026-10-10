#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("Fibonacci Nim：行动上限也是状态")] <trick-game-13>
*问题概述*　#text("一堆 ")$n≥1$#text(" 颗石子，先手第一步可取任意正数颗但不能取完。此后每步取数不超过剩余量，且至多为对方上一步取数的两倍；无合法操作者输。判断初始先手胜负；中途局面由剩余数量和当前取数上限共同决定。")

*必要思路*　#text("该标准规则下，初始 ")$P$#text(" 局面恰为 Fibonacci 数。一般中途状态还需记当前取数上限；Zeckendorf 分解中最小 Fibonacci 项可用于策略。首步可取完或上限规则改变后，不能套初始结论。")

*参考*　#link("https://oi-wiki.org/math/game-theory/impartial-game/")[#text("OI Wiki：公平组合游戏")]。



]
