param(
  [ValidateSet('Debug','Release')]
  [string]$Configuration = 'Release'
)

$ErrorActionPreference = 'Stop'

Write-Host "Packing bundle (Configuration=$Configuration)" -ForegroundColor Cyan

# This project uses the WiX v4 MSBuild SDK.
# Ensure you have restored packages and have the .NET SDK.

& dotnet restore "./MyWixV4WpfBA.sln"
& dotnet build "./src/Bundle/Bundle.csproj" -c $Configuration

Write-Host "Bundle build complete. Output is under src/Bundle/bin/$Configuration" -ForegroundColor Green
