param(
  [string]$Configuration = "Release",
  [string]$Artifacts = "artifacts"
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSCommandPath
Set-Location $repoRoot

if (!(Test-Path $Artifacts)) {
  New-Item -ItemType Directory -Path $Artifacts | Out-Null
}

Write-Host "Building solution..."
dotnet build . -c $Configuration

# Copy newest bundle exe to artifacts.
$bundleExe = Get-ChildItem -Path $repoRoot -Recurse -Filter "MyBundle.exe" |
  Sort-Object LastWriteTime -Descending |
  Select-Object -First 1

if ($null -eq $bundleExe) {
  throw "Could not find MyBundle.exe after build."
}

$dest = Join-Path $Artifacts "MyBundle.exe"
Copy-Item $bundleExe.FullName $dest -Force
Write-Host "Copied $($bundleExe.FullName) -> $dest"
