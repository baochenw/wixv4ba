[CmdletBinding()]
param(
  [string]$Configuration = "Release",
  [switch]$Zip
)

$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $repoRoot

./build.ps1 -Configuration $Configuration

if ($Zip) {
  $artifacts = Join-Path $repoRoot "artifacts"
  $exe = Join-Path $artifacts "MyBundle.exe"
  if (-not (Test-Path $exe)) {
    throw "Expected artifact not found: $exe"
  }

  $zipPath = Join-Path $artifacts "MyBundle.zip"
  if (Test-Path $zipPath) { Remove-Item $zipPath -Force }

  Add-Type -AssemblyName System.IO.Compression.FileSystem
  $tmpDir = Join-Path $artifacts "_ziptmp"
  if (Test-Path $tmpDir) { Remove-Item $tmpDir -Recurse -Force }
  New-Item -ItemType Directory -Path $tmpDir | Out-Null

  Copy-Item $exe (Join-Path $tmpDir "MyBundle.exe") -Force
  [System.IO.Compression.ZipFile]::CreateFromDirectory($tmpDir, $zipPath)
  Remove-Item $tmpDir -Recurse -Force

  Write-Host "OK: $zipPath"
}
