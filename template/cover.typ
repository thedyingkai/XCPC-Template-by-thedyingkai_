#let version = sys.inputs.at("version", default: read("../VERSION").trim())

#align(center)[
  #v(6cm)
  
  #text(
    size: 48pt,
    weight: "bold"
  )[XCPC 算法模板]

  #text(
    size: 24pt,
    weight: "bold"
  )[XCPC Algorithms]

  #v(3.5cm)

  #image(
    "logo.jpg",
    width: 5cm
  )
  
  #v(2cm)

  #text(
    size: 14pt,
    weight: "bold"
  )[Author：thedyingkai\_]

  #text(
    size: 14pt,
    weight: "bold"
  )[更新时间：#datetime.today().year() 年 #datetime.today().month() 月 #datetime.today().day() 日]
  
  #text(
    size: 14pt,
    weight: "bold"
  )[version：v#version]
]

#pagebreak()

#image("cover.png", width: 100%)

#pagebreak()

#align(center)[
  #text(
    size: 22pt,
    weight: "bold"
  )[目录]
]

#v(1cm)

#outline(
  depth: 3,
  title: none,
  indent: 1.5em
)

#pagebreak()
