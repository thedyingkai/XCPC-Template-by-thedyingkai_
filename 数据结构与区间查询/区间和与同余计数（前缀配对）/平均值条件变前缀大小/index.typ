#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[#text("平均值条件变前缀大小")] <trick-math-28>
*问题概述*　#text("给定整数数组以及有理阈值 ")$K=c/d$#text("，d>0。统计满足 ")$( sum _(i=l)^r a_i)/(r-l+1)≥K$#text(" 的非空连续子数组个数，等号计入；要求使用整数变换避免浮点判等。")

*必要思路*　#text("令 ")$b_(i)=a_(i)-K$#text("，条件变区间和")$≥0$#text("，即前缀 ")$p_(l-1)≤p_(r)$#text("。离散化前缀并用树状数组统计此前≤当前者。若 ")$K$#text(" 是有理数 ")$c/d$#text("，改用 ")$d*a_(i)-c$#text(" 做整数比较，d>0，注意扩宽。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。



]
