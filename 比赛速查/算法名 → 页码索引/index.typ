#import "/template/lookup.typ": algorithm-lookup
#import "entries.typ": algorithm-entries

#let render(code) = [
#heading(level: 2, outlined: false, numbering: none)[算法名 → 页码索引] <algorithm-index>
#algorithm-lookup(algorithm-entries)
#pagebreak()
// The unnumbered lookup does not consume a chapter number.
#counter(heading).update(0)

]
