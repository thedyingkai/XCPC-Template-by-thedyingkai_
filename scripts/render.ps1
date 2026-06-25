param (
    [string]$Version = ""
)

$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$versionPath = Join-Path $repoRoot "VERSION"
$mainTyp = Join-Path $repoRoot "main.typ"
$distDir = Join-Path $repoRoot "dist"

if (-not (Get-Command typst -ErrorAction SilentlyContinue)) {
    throw "typst is required but was not found in PATH."
}

if ([string]::IsNullOrWhiteSpace($Version)) {
    $Version = (Get-Content -Raw -Encoding UTF8 $versionPath).Trim()
}

if ($Version -notmatch '^\d+\.\d+$') {
    throw "Version must look like x.y, got '$Version'."
}

New-Item -ItemType Directory -Force -Path $distDir | Out-Null

$pdfPrefixBytes = [byte[]](
    0x58, 0x43, 0x50, 0x43, 0x20,
    0xe7, 0xae, 0x97,
    0xe6, 0xb3, 0x95,
    0xe6, 0xa8, 0xa1,
    0xe6, 0x9d, 0xbf,
    0x20, 0x62, 0x79, 0x20,
    0x74, 0x68, 0x65, 0x64, 0x79, 0x69, 0x6e, 0x67, 0x6b, 0x61, 0x69, 0x5f,
    0x20, 0x76
)
$pdfPrefix = [System.Text.Encoding]::UTF8.GetString($pdfPrefixBytes)
$pdfName = "$pdfPrefix$Version.pdf"
$pdfPath = Join-Path $distDir $pdfName

& typst compile $mainTyp $pdfPath --input "version=$Version"
if ($LASTEXITCODE -ne 0) {
    throw "typst compile failed."
}

Write-Host "Rendered $pdfName"
Write-Output $pdfPath
