# XCPC-Template-by-thedyingkai_
XCPC Template by thedyingkai_

## Release

Render the current version locally:

```powershell
.\scripts\render.ps1
```

Create a small release (`x.y -> x.(y+1)`):

```powershell
.\scripts\release-small.ps1
```

Create a large release (`x.y -> (x+1).0`):

```powershell
.\scripts\release-large.ps1
```

Release PDFs are rendered to `dist/` locally and uploaded to GitHub Releases by the tag workflow.
