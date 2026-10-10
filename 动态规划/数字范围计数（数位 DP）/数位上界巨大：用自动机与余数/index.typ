#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("数位上界巨大：用自动机与余数")] <trick-dp-25>
*问题概述*　#text("给定十进制上界字符串 ")$N$#text("、有限禁串集合 ")$F$#text("、正整数 ")$m$#text(" 及 ")$0≤r<m$#text("。求 ")$0≤x≤N$#text(" 中满足 ")$x≡r (mod m)$#text("、且通常十进制表示不含 ")$F$#text(" 中任一串的整数个数，答案按给定模数取模；0 的表示固定为单个字符“0”。")

*必要思路*　#text("用字符串自动机状态概括已读前缀对禁串匹配的影响，再与余数、tight、started（是否已有实际数位）组合。尚未 started 的补位零不送入自动机；开始后每位都参与匹配，命中禁串的状态不转移。扫描结束仍未 started 的唯一分支表示整数 0，须按单个字符“0”检查禁串，并检查余数条件。状态量按各维大小相乘估算。")

*参考*　#link("https://www.luogu.com.cn/article/ki71nw88")[#text("洛谷：DP 题方法总汇")]。



]
