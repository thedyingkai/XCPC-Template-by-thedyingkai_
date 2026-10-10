#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("轮廓状态：只记未来可见的边界")] <trick-dp-22>
*问题概述*　#text("给定 ")$h w$#text(" 的矩形棋盘，部分格子禁用。用不限数量的 ")$1 2$#text(" 或 ")$2 1$#text(" 骨牌恰好覆盖所有可用格，每格被覆盖一次，骨牌不能穿过禁用格。求铺法数；适用条件是 min(h,w) 足够小，可以枚举边界占用掩码。")

*必要思路*　#text("逐行或逐格扫描，只记当前边界哪些格子已被跨边界砖占用；边界后面的历史不再影响未来。复杂度指数应落在较小的宽度上，可先转置网格；涉及连通性时还需记录连接关系，而非仅占用位。")

*参考*　#link("https://cp-algorithms.com/dynamic_programming/profile-dynamics.html")[#text("CP-Algorithms：轮廓 DP")]。



]
