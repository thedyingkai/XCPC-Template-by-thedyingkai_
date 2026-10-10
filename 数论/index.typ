#import "模幂与防溢出模乘/index.typ" as section-0
#import "整数线性方程（扩展欧几里得）/index.typ" as section-1
#import "模逆元与模除法/index.typ" as section-2
#import "同余方程组合（EXCRT）/index.typ" as section-3
#import "复合模指数降幂（扩展欧拉）/index.typ" as section-4
#import "离散对数（扩展 BSGS）/index.typ" as section-5
#import "质数与积性函数预处理（线性筛）/index.typ" as section-6
#import "整数分解与质因子指数（Pollard-Rho）/index.typ" as section-7
#import "整除商的批量求和（整除分块）/index.typ" as section-8
#import "因子与倍数贡献交换/index.typ" as section-9
#import "互质计数（莫比乌斯反演）/index.typ" as section-10
#import "积性函数大范围前缀和（杜教筛）/index.typ" as section-11
#import "积性函数大范围求和（Min_25 筛）/index.typ" as section-12
#import "线性取整求和（类欧几里得）/index.typ" as section-13

#let render(code) = [
#heading(level: 1, outlined: true)[数论] <chapter-number-theory>

#text("模数下的除法先检查可逆条件。计数口径区分有序/无序、重复/互异；期望可线性拆分，但概率乘法不能假定独立。")

#text("每条先给明确问题模型，再给必要思路与适用条件。参考链接用于追溯知识，应用情景由本文重新整理。")


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

]
