#let render(code) = [
#heading(level: 2, outlined: true)[题目入口与实现约定] <comm-samples>

以下按功能收录原题入口，区域赛、EC-Final、网络赛与 OI 明确区分；同题跨重赛或跨 CF 场次不重复解释为独立样本。

#table(columns: (1.1fr,1fr), table.header([原题来源], [功能]),
[#link("https://qoj.ac/problem/8870")[CERC 2023 H · Human Resources]], [姓名前序与树形],
[#link("https://qoj.ac/problem/14942")[沈阳 2025 C · Buggy Painting Software II]], [标定与质数位移],
[#link("https://qoj.ac/problem/15437")[香港 2025 F · Find the Circuit]], [重标号后的环],
[#link("https://qoj.ac/problem/16338")[EC-Final 2025 K · Magically Marked Matching Master]], [在线匹配建议],
[#link("https://qoj.ac/problem/16339")[EC-Final 2025 L · Logical Resonance]], [可逆树构造],
[#link("https://qoj.ac/problem/15636")[NWERC 2025 H · Hasty Haul]], [无不动点对合],
[#link("https://2025.gcpc.nwerc.eu/contest.pdf")[GCPC 2025 J · Jumbled Packets]], [循环同步],
[#link("https://qoj.ac/problem/14860")[BAPC 2025 F · Faulty Connection]], [两包恢复],
[#link("https://qoj.ac/problem/20722")[CCPC 网络预选 2026 H · Hidden Permutation]], [洗行后的频数],
[#link("https://codeforces.com/contest/2168/problem/A2")[CF 2168A2 · Encode and Decode]], [定长进制],
[#link("https://codeforces.com/problemset/problem/2168/B")[CF 2168B · Locate]], [一位建议],
[#link("https://codeforces.com/contest/2168/problem/C")[CF 2168C · Intercepting Butterflies]], [单错纠正],
[#link("https://codeforces.com/problemset/problem/2179/F")[CF 2179F · RGB Walking]], [距离模三],
[#link("https://codeforces.com/contest/2255/problem/C")[CF 2255C／2256E · Even If the World Turns]], [模重心等变量，同题],
[#link("https://qoj.ac/problem/12650")[IOI 2010 Saveit]], [距离差分],
[#link("https://qoj.ac/problem/2006")[IOI 2011 Parrots]], [乱序多重集容量],
[#link("https://qoj.ac/problem/1505")[IOI 2012 Last Supper]], [驻留期建议],
[#link("https://qoj.ac/problem/364")[JOISC 2017 Broken Device]], [已知坏位],
[#link("https://qoj.ac/problem/1139")[IOI 2020 Stations]], [局部路由标签],
[#link("https://qoj.ac/problem/9237")[IOI 2024 Message]], [可靠列认证],
[#link("https://qoj.ac/problem/4208")[BOI 2022 Flight to the Ford]], [反馈与列表恢复],
)

每个实现与正文放在同名功能目录，统一使用 communication 命名空间。纯编解码组件返回串、位数组、标签或结构，外层只接题目规定的 first／second、prepare／play 或函数式接口。读写仍需遵守在线时序，跨执行不依赖全局缓存。位序、根、下标、字符域和不足整块的填充规则在各节固定说明。
]
