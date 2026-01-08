# WiX v4 WPF Managed Bootstrapper Application (net48)

This repo contains a WiX Toolset v4 **bundle** with a **managed (WPF) bootstrapper application** built on **.NET Framework 4.8 (net48)**.

## Prerequisites

- Windows
- Visual Studio 2022 (or MSBuild) with **.NET Framework 4.8 targeting pack**
- WiX Toolset v4 build support via NuGet (restored automatically)
- PowerShell 5.1+ (or PowerShell 7)

## Layout

- `src/BA/` – managed bootstrapper application (WPF) targeting `net48`
- `src/Bundle/` – WiX v4 bundle project that hosts the managed BA
- `payloads/MyProduct.msi` – **placeholder** payload checked in as a file the scripts validate exists
- `build.ps1` – builds the bundle and copies `MyBundle.exe` to `artifacts/`
- `pack.ps1` – builds then optionally zips the artifact

## Build

From a Developer PowerShell / regular PowerShell:

```powershell
./build.ps1
```

Outputs:

- `artifacts/MyBundle.exe`

## Pack (optional zip)

```powershell
./pack.ps1 -Zip
```

Outputs:

- `artifacts/MyBundle.exe`
- `artifacts/MyBundle.zip` (when `-Zip` is used)

## Notes

- This solution targets **net48** and uses **WiX Toolset 4.0.6** packages.
- Any previous `net8.0` references have been removed.
- The scripts validate that `payloads/MyProduct.msi` exists. It is intentionally a placeholder in this repo.
