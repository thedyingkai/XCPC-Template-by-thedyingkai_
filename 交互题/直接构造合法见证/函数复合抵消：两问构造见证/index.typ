#let render(code) = [
#heading(level: 3, outlined: true)[函数复合抵消：两问构造见证] <inter-hash>

*模型。* 固定隐藏 $f:[1,n]->[1,n]$，可问 $f^k(x)$，要求 $f^c(r)=c$。不需要恢复函数。

任取 $x$，先得 $c=f^n(x)$。若 $c<n$，再得 $r=f^(n-c)(x)$；若 $c=n$，直接取 $r=x$，不发送题面不允许的零次迭代查询。于是
$ f^c(r)=f^c(f^(n-c)(x))=f^n(x)=c. $

从最终等式倒推能通过复合、抵消和替换制造的量。只用一到两问，函数其他位置仍未知。依赖同一个固定函数，以及合法的迭代次数；函数随查询改变时不能套这条等式链。
#link("https://2024.nwerc.eu/main/problem-set.pdf")[NWERC 2024 H 原题]。

#code("交互题/直接构造合法见证/函数复合抵消：两问构造见证/函数复合见证.cpp", mode: "full")
]
