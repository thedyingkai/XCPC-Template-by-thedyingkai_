# XCPC 算法模板 by thedyingkai_

这是一个使用 Typst 编写和渲染的 XCPC 算法模板项目。

## 代码标准与切割

- C++ 板子按 GNU++20 编写。
- 一个文件需要暴露多个可复制部分时，用 `// start: name` 与 `// end: name` 标记完整区段。
- Typst 用 `#code("路径.cpp", parts: ("base", "query"))` 按数组顺序选择并拼接区段。
- 区段名必须唯一且不能嵌套；名称错误、重复引用或标记未闭合会在构建时直接报出文件路径和行号。
- 未使用 `parts` 的旧 `mode` 调用继续兼容；`#include`、`#pragma once` 和标准外层 include guard 默认不进入代码框。

## 本地渲染

渲染当前 `VERSION` 对应的 PDF：

```powershell
.\scripts\render.ps1
```

生成的 PDF 会放在 `dist/` 目录下，该目录不会被提交到仓库。

## 发布版本

小规模改动发布，版本号从 `x.y` 更新为 `x.(y+1)`：

```powershell
.\scripts\release-small.ps1
```

大规模改动发布，版本号从 `x.y` 更新为 `(x+1).0`：

```powershell
.\scripts\release-large.ps1
```

发布脚本会更新 `VERSION`、本地渲染 PDF、提交版本变更、创建 Git tag 并推送到 GitHub。推送 tag 后，GitHub Actions 会自动重新渲染 PDF，并把产物上传到对应的 GitHub Release。

## 版本规则

- `VERSION` 是当前版本号的唯一来源。
- 封面页会自动读取 `VERSION` 并显示为 `vX.Y`。
- 历史 PDF 放在 GitHub Releases 中，`last version/` 目录不会进入版本管理。
