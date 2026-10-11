#import "双方信息与信道模型/index.typ" as section-0
#import "容量计算与序列化/index.typ" as section-1
#import "单翻转纠错与校验综合/index.typ" as section-2
#import "擦除与删除后的恢复/index.typ" as section-3
#import "循环同步与变换等价/index.typ" as section-4
#import "未知符号映射下的编码/index.typ" as section-5
#import "树形与边标签编码/index.typ" as section-6
#import "图重标号后的目标结构恢复/index.typ" as section-7
#import "重排与受限修改中的结构标记/index.typ" as section-8
#import "已知坏位与可靠位置认证/index.typ" as section-9
#import "局部标签与离线建议/index.typ" as section-10
#import "双向比较与带反馈的信道/index.typ" as section-11
#import "可逆构造与对合/index.typ" as section-12
#import "题目入口与实现约定/index.typ" as section-13

#let render(code) = [
#pagebreak(weak: true)
#heading(level: 1, outlined: true)[通信题] <chapter-communication>

从接收者缺少的信息和信道保留的结构出发，选择容量足够且能够解码的表示。分别写明编码端输入、可控制操作、信道变化和解码端观察，逐项计算地址、校验、同步和反馈成本。

#table(columns: (1fr,1fr), table.header([信道或目标], [功能入口]),
[位置保留，但一位可能翻转], [#link(<comm-hamming>)[校验综合与 Hamming]],
[任意留下少量正确包], [#link(<comm-erasure>)[有限域采样]],
[字符删除使后续位置移动], [#link(<comm-vt>)[VT 删除码]],
[循环移位或整体反转], [#link(<comm-transform>)[同步与轨道编码]],
[颜色经同一个未知映射], [#link(<comm-calibrate>)[标定与质数位移]],
[坏位只由发送端知道], [#link(<comm-defects>)[多码字覆盖与位置认证]],
[接收者只看局部邻居], [#link(<comm-local>)[局部标签与建议位]],
[双方有私有输入或信道有反馈], [#link(<comm-feedback>)[双向协议与候选状态]],
)

#section-0.render(code)

#section-1.render(code)

#section-2.render(code)

#section-3.render(code)

#section-4.render(code)

#section-5.render(code)

#section-6.render(code)

#section-7.render(code)

#section-8.render(code)

#section-9.render(code)

#section-10.render(code)

#section-11.render(code)

#section-12.render(code)

#section-13.render(code)

#pagebreak(weak: true)
]
