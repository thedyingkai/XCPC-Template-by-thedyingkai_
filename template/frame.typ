#let extract-code(
  code,
  mode: "struct",
  ignore-blank: true,
  ignore-include: true,
  ignore-main: true,
) = {
  let lines = code.split("\n")
  let res = ()
  let capturing = false
  let dep = 0
  for line in lines {
    if (ignore-include and line.trim().starts-with("#include")) {
      continue
    }
    if (ignore-main and line.contains("int main")) {
      break
    }
    if mode == "full" {
      if ignore-blank and line.trim() == "" {
        continue
      }
      res.push(line)
      continue
    }
    if mode == "struct" {
      if (
            (
            line.contains("struct ") or 
            line.contains("class ") or 
            line.contains("namespace ")
          )
        and line.contains("{")
        ) {
        capturing = true
      }
      if capturing {
        if not (ignore-blank and line.trim() == "") {
          res.push(line)
        }
        dep += line.matches("{").len()
        dep -= line.matches("}").len()
        if dep <= 0 and line.contains("};") {
          capturing = false
        }
      }
    }
  }
  res.join("\n")
}

#let lineno(n) = {
  if n < 10 {
    "  " + str(n)
  } else if n < 100 {
    " " + str(n)
  } else {
    str(n)
  }
}

#let render-code(
  code,
  font-size: 8pt,
  line-number: true,
) = {
  if code == none or code.trim() == "" {
    code = "// TODO"
  }
  let lines = code.split("\n")
  block(
    breakable: true,
    stroke: 0.6pt + rgb("#777"),
    radius: 3pt,
    inset: 6pt,
    width: 100%,
  )[
    #set text(
      font: "JetBrains Mono",
      size: font-size,
    )
    #for (i, line) in lines.enumerate() {
      text(fill: rgb("#888"))[#lineno(i + 1)]
      h(1em)
      raw(line)
      linebreak()
      if i + 1 < lines.len() {
        v(-2em)
      }
    }
  ]
}

#let code(
  path,
  title: none,
  mode: "struct",
  ignore-blank: true,
  ignore-include: true,
  ignore-main: true,
) = {
  let raw-code = read("..\\"+path)
  let code = extract-code(
    raw-code,
    mode: mode,
    ignore-blank: ignore-blank,
    ignore-include: ignore-include,
    ignore-main: ignore-main,
  )
  [
    #text(weight: "bold", size: 11pt)[#title]
    #v(4pt)
    #render-code(code, line-number: "ture")
    #v(1em)
  ]
}

#let header(pag) = {
  let left_content = [算法竞赛模板]
  let right_content = text(size: 11pt)[#context counter(page).display()]
  if (calc.rem(pag , 2) == 0) {
    let tmp = left_content
    left_content = right_content
    right_content = tmp
  }
  grid(
    columns: (1fr, 1fr),
    align(left)[#left_content],
    align(right)[#right_content]
  )
  line(length: 100%)
}

#let footer = align(center)[
  #line(length: 100%)
  #text(size: 11pt)[第 #context counter(page).display() / #context counter(page).final().first() 页]
]
