#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("换根后的子树只分三种情况")] <trick-tree-21>
*问题概述*　#text("给定树及节点权值，先以固定根 ")$r_0$#text(" 建立数据结构。每次询问指定新根 ")$r$#text(" 和节点 ")$u$#text("，求在根 ")$r$#text(" 的意义下 ")$u$#text(" 子树中的节点权值和；询问不改变边，只改变父子关系，可以另外支持节点权值修改。")

*必要思路*　#text("")$u=r$#text(" 则是全树；")$u$#text(" 不是原根下 ")$r$#text(" 的祖先，则仍是原子树；否则找到 ")$u$#text(" 朝 ")$r$#text(" 方向的儿子 ")$c$#text("，新子树为全树减原子树 ")$c$#text("。用祖先判断和倍增找 ")$c$#text("，最终是一段或两段序列区间。")

*参考*　#link("https://oi-wiki.org/graph/hld/")[#text("OI Wiki：树链剖分")]。



]
