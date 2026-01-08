[CmdletBinding()]
param(
  [string]$Configuration = "Release"
)

$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $repoRoot

$payload = Join-Path $repoRoot "payloads/MyProduct.msi"
if (-not (Test-Path $payload)) {
  throw "Required payload is missing: $payload`nThis repo expects payloads/MyProduct.msi to exist (placeholder is fine)."
}

$artifacts = Join-Path $repoRoot "artifacts"
New-Item -ItemType Directory -Force -Path $artifacts | Out-Null

$bundleProj = Join-Path $repoRoot "src/Bundle/Bundle.csproj"

Write-Host "Restoring..."
dotnet restore $bundleProj

Write-Host "Building bundle ($Configuration)..."
dotnet build $bundleProj -c $Configuration

# Find produced bundle exe under bin/<cfg>/.../MyBundle.exe
$bundleExe = Get-ChildItem -Path (Join-Path $repoRoot "src/Bundle/bin") -Recurse -Filter "MyBundle.exe" |
  Sort-Object LastWriteTime -Descending |
  Select-Object -First 1

if (-not $bundleExe) {
  throw "Bundle output MyBundle.exe not found under src/Bundle/bin."
}

Copy-Item $bundleExe.FullName (Join-Path $artifacts "MyBundle.exe") -Force
Write-Host "OK: artifacts/MyBundle.exe"
