param(
  [ValidateSet('Debug','Release')]
  [string]$Configuration = 'Release'
)

$ErrorActionPreference = 'Stop'

Write-Host "Building solution (Configuration=$Configuration)" -ForegroundColor Cyan

# Requires .NET SDK installed
& dotnet --version | Out-Host

& dotnet restore "./MyWixV4WpfBA.sln"
& dotnet build "./MyWixV4WpfBA.sln" -c $Configuration

Write-Host "Build complete." -ForegroundColor Green
