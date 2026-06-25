param (
    [Parameter(Mandatory = $true)]
    [ValidateSet("small", "large")]
    [string]$Scale,

    [switch]$NoCommit,
    [switch]$NoPush
)

$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$versionPath = Join-Path $repoRoot "VERSION"
$renderScript = Join-Path $PSScriptRoot "render.ps1"

Push-Location $repoRoot
try {
    if (-not (Test-Path $versionPath)) {
        throw "VERSION file was not found."
    }

    if (-not $NoCommit) {
        $status = git status --porcelain
        if ($status) {
            throw "Working tree must be clean before releasing. Commit or stash your changes first."
        }
    }

    $current = (Get-Content -Raw -Encoding UTF8 $versionPath).Trim()
    if ($current -notmatch '^(\d+)\.(\d+)$') {
        throw "VERSION must look like x.y, got '$current'."
    }

    $major = [int]$matches[1]
    $minor = [int]$matches[2]

    if ($Scale -eq "small") {
        $minor += 1
    } else {
        $major += 1
        $minor = 0
    }

    $newVersion = "$major.$minor"
    $tag = "v$newVersion"

    if (git rev-parse --verify --quiet "refs/tags/$tag") {
        throw "Tag $tag already exists."
    }

    Set-Content -Path $versionPath -Value $newVersion -Encoding UTF8 -NoNewline

    & $renderScript -Version $newVersion | Out-Host

    if (-not $NoCommit) {
        git add VERSION
        git commit -m "Release $tag"
        git tag -a $tag -m "Release $tag"

        if (-not $NoPush) {
            $branch = git branch --show-current
            if ([string]::IsNullOrWhiteSpace($branch)) {
                throw "Cannot determine current branch."
            }

            git push origin $branch
            git push origin $tag
        }
    }

    Write-Host "Prepared release $tag"
}
catch {
    throw
}
finally {
    Pop-Location
}
