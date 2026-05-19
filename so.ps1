#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Detecta y muestra el sistema operativo actual.
.DESCRIPTION
    Funciona en Windows PowerShell 5.1 y PowerShell 7+ en Linux, macOS y Windows.
    Mensajes sin acentos para evitar problemas de codificación en consolas antiguas de Windows.
.NOTES
    Autor: Asistente
    Versión: 1.1
#>

function Get-OperatingSystem {
    if (Test-Path variable:IsWindows) {
        if ($IsWindows) { return "Windows" }
        if ($IsLinux)   { return "Linux" }
        if ($IsMacOS)   { return "macOS" }
    }

    $osPlatform = [System.Runtime.InteropServices.RuntimeInformation]
    if ($osPlatform::IsOSPlatform([System.Runtime.InteropServices.OSPlatform]::Windows)) { return "Windows" }
    if ($osPlatform::IsOSPlatform([System.Runtime.InteropServices.OSPlatform]::Linux))   { return "Linux" }
    if ($osPlatform::IsOSPlatform([System.Runtime.InteropServices.OSPlatform]::OSX))     { return "macOS" }

    return "Desconocido ($([System.Environment]::OSVersion.Platform))"
}

$so = Get-OperatingSystem
Write-Host "Estas ejecutando: $so" -ForegroundColor Cyan
Write-Host "Version de PowerShell: $($PSVersionTable.PSVersion)" -ForegroundColor Green
Write-Host "Edicion: $($PSVersionTable.PSEdition)" -ForegroundColor Green
