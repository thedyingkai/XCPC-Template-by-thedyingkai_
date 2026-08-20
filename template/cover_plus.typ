#let version = sys.inputs.at("version", default: read("../VERSION").trim() + " beta")

#set page(columns: 1)

#align(center)[
  #v(1.2cm)

  #text(
    size: 48pt,
    weight: "bold"
  )[XCPC 算法模板]

  #text(
    size: 24pt,
    weight: "bold"
  )[XCPC Algorithms]

  #v(1.2cm)

  #image(
    "logo.jpg",
    width: 4.2cm
  )

  #v(0.8cm)

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

#align(center + horizon)[
  #image(
    "cover.png",
    height: 18.5cm,
    fit: "contain"
  )
]

#pagebreak()

#set page(columns: 2)
#set columns(gutter: 8mm)

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
