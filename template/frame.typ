// A C++ file may expose several named snippets:
//   // start: core
//   ...
//   // end: core
// Select one or more with `#code(path, parts: ("core", "query"))`.

#let normalize-code(code) = {
  code.replace("\r\n", "\n").replace("\r", "\n").replace("\n", "\r\n")
}

#let clean-code-lines(
  lines,
  ignore-blank: true,
  ignore-include: true,
  ignore-main: true,
) = {
  let res = ()
  for line in lines {
    if ignore-include and line.trim().starts-with("#include") {
      continue
    }
    if ignore-main and line.contains("int main") {
      break
    }
    if not (ignore-blank and line.trim() == "") {
      res.push(line)
    }
  }
  res
}

#let wrapper-guard-indices(lines) = {
  let meaningful = ()
  for (i, line) in lines.enumerate() {
    if line.trim() != "" {
      meaningful.push((i, line.trim()))
    }
  }
  let result = ()
  if meaningful.len() >= 3 {
    let first = meaningful.at(0)
    let second = meaningful.at(1)
    let last = meaningful.at(meaningful.len() - 1)
    let prefix = "#ifndef "
    if first.at(1).starts-with(prefix) {
      let name = first.at(1).slice(prefix.len()).trim()
      if second.at(1) == "#define " + name and last.at(1).starts-with("#endif") {
        result = (first.at(0), second.at(0), last.at(0))
      }
    }
  }
  result
}

#let extraction-location(path, line: none) = {
  let result = if path == none { "" } else { " in `" + path + "`" }
  if line != none {
    result += " at line " + str(line)
  }
  result
}

#let parse-parts(code, path: none) = {
  let start-prefix = "// start:"
  let end-prefix = "// end:"
  let names = ()
  let blocks = ()
  let current = none
  let current-line = none
  let buffer = ()
  let lines = normalize-code(code).split("\n")

  for (i, line) in lines.enumerate() {
    let trimmed = line.trim()
    if trimmed.starts-with(start-prefix) {
      let active-name = if current == none { "none" } else { current }
      let active-line = if current-line == none { "unknown" } else { str(current-line) }
      assert(
        current == none,
        message: "code extraction failed" + extraction-location(path, line: i + 1) +
          ": nested part; `" + active-name + "` started at line " + active-line,
      )
      let name = trimmed.slice(start-prefix.len()).trim()
      assert(
        name != "",
        message: "code extraction failed" + extraction-location(path, line: i + 1) +
          ": empty part name",
      )
      current = name
      current-line = i + 1
      buffer = ()
      continue
    }
    if trimmed.starts-with(end-prefix) {
      let name = trimmed.slice(end-prefix.len()).trim()
      assert(
        current != none,
        message: "code extraction failed" + extraction-location(path, line: i + 1) +
          ": part `" + name + "` ends before it starts",
      )
      assert(
        name == current,
        message: "code extraction failed" + extraction-location(path, line: i + 1) +
          ": expected end of `" + current + "`, got `" + name + "`",
      )
      assert(
        not names.contains(current),
        message: "code extraction failed" + extraction-location(path, line: current-line) +
          ": duplicate part `" + current + "`",
      )
      names.push(current)
      blocks.push(buffer)
      current = none
      current-line = none
      buffer = ()
      continue
    }
    if current != none {
      buffer.push(line)
    }
  }
  let open-name = if current == none { "none" } else { current }
  assert(
    current == none,
    message: "code extraction failed" + extraction-location(path, line: current-line) +
      ": part `" + open-name + "` is not closed",
  )
  (names, blocks)
}

#let extract-parts(
  code,
  parts,
  path: none,
  ignore-blank: true,
  ignore-include: true,
  ignore-main: true,
) = {
  let parsed = parse-parts(code, path: path)
  let names = parsed.at(0)
  let blocks = parsed.at(1)

  let wanted = if type(parts) == str { (parts,) } else { parts }
  assert(
    type(wanted) == array and wanted.len() > 0,
    message: "code extraction failed" + extraction-location(path) +
      ": parts must be a name or a non-empty array",
  )
  let selected = ()
  let requested = ()
  for name in wanted {
    assert(
      type(name) == str and name != "",
      message: "code extraction failed" + extraction-location(path) +
        ": every part name must be a non-empty string",
    )
    assert(
      not requested.contains(name),
      message: "code extraction failed" + extraction-location(path) +
        ": duplicate requested part `" + name + "`",
    )
    requested.push(name)
    let index = none
    for (i, known) in names.enumerate() {
      if known == name {
        index = i
      }
    }
    let available = if names.len() == 0 { "none" } else { names.join(", ") }
    assert(
      index != none,
      message: "code extraction failed" + extraction-location(path) +
        ": unknown part `" + name + "`; available: " + available,
    )
    let cleaned = clean-code-lines(
      blocks.at(index),
      ignore-blank: ignore-blank,
      ignore-include: ignore-include,
      ignore-main: ignore-main,
    )
    assert(
      cleaned.len() > 0,
      message: "code extraction failed" + extraction-location(path) +
        ": selected part `" + name + "` is empty after filtering",
    )
    selected.push(cleaned.join("\n"))
  }
  selected.join("\n\r\n")
}

#let extract-code(
  code,
  mode: "struct",
  parts: none,
  path: none,
  ignore-blank: true,
  ignore-include: true,
  ignore-main: true,
  ignore-guard: true,
) = {
  if parts != none {
    extract-parts(
      code,
      parts,
      path: path,
      ignore-blank: ignore-blank,
      ignore-include: ignore-include,
      ignore-main: ignore-main,
    )
  } else {
    let parsed = parse-parts(code, path: path)
    let lines = normalize-code(code).split("\n")
    let guard-lines = if ignore-guard { wrapper-guard-indices(lines) } else { () }
    let res = ()
    let capturing = false
    let dep = 0
    for (i, line) in lines.enumerate() {
      if line.trim().starts-with("// start:") or line.trim().starts-with("// end:") {
        continue
      }
      if guard-lines.contains(i) or (ignore-guard and line.trim() == "#pragma once") {
        continue
      }
      if ignore-include and line.trim().starts-with("#include") {
        continue
      }
      if ignore-main and line.contains("int main") {
        break
      }
      if mode == "full" {
        if not (ignore-blank and line.trim() == "") {
          res.push(line)
        }
        continue
      }
      if mode == "struct" {
        if not capturing and (
          line.contains("struct ") or
          line.contains("class ") or
          line.contains("namespace ")
        ) and line.contains("{") {
          capturing = true
          dep = 0
        }
        if capturing {
          if not (ignore-blank and line.trim() == "") {
            res.push(line)
          }
          dep += line.matches("{").len()
          dep -= line.matches("}").len()
          if dep <= 0 {
            capturing = false
          }
        }
      }
    }
    res.join("\n")
  }
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
      if line-number {
        text(fill: rgb("#888"))[#lineno(i + 1)]
        h(1em)
      }
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
  parts: none,
  ignore-blank: true,
  ignore-include: true,
  ignore-main: true,
  ignore-guard: true,
) = {
  let raw-code = read("..//"+path)
  let code = extract-code(
    raw-code,
    mode: mode,
    parts: parts,
    path: path,
    ignore-blank: ignore-blank,
    ignore-include: ignore-include,
    ignore-main: ignore-main,
    ignore-guard: ignore-guard,
  )
  [
    #text(weight: "bold", size: 11pt)[#title]
    #v(4pt)
    #render-code(code, line-number: true)
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
