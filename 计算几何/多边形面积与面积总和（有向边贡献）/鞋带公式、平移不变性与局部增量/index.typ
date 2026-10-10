#import "/template/frame.typ": extract-code
#import "/template/trick-code.typ": trick-code

#let render(code) = [
#heading(level: 4, outlined: false, numbering: none)[鞋带公式、平移不变性与局部增量] <geom-signed-area>
边界按逆时针顺序给出、不重复首点的简单多边形，

$ A_2=sum_(i=0)^(n-1) p_i times p_((i+1) mod n), quad S=A_2/2. $

顺时针时 $A_2<0$，普通面积最终取 $|A_2|/2$。单条有向边贡献可正可负，必须先求和后取绝对值。正方形 $(1,1),(2,1),(2,2),(1,2)$ 的四项为 $-1,2,2,-1$，和为 $2$；逐项取绝对值会得到 $6$。

#trick-code(extract-code(
  read("有向面积.cpp"),
  parts: "polygon-area",
  path: "计算几何/多边形面积与面积总和（有向边贡献）/鞋带公式、平移不变性与局部增量/有向面积.cpp",
))

把所有点平移 $-O$ 后，叉积之和不变，因为附加项 $O times (p_i-p_(i+1))$ 在环上相消。坐标特别大但多边形很小时，选附近的原点可减少浮点消减；整数计算也可通过平移降低实际量级，但平移操作本身仍须防溢出。

边 $u arrow.r v$ 插入 $w$ 时，两倍有向面积增量为

$ Delta A_2=u times w+w times v-u times v
  =-(v-u) times (w-u). $

三项在 $O(1)$ 内更新，删除顶点取相反增量。围成自交折线时该和是代数面积，不能直接当成并区域面积；含洞区域须给外环与内环相反朝向。



]
