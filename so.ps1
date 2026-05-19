#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Detecta y muestra el sistema operativo actual.
.DESCRIPTION
    Este script funciona en Windows PowerShell 5.1 y en PowerShell 7+ en Linux, macOS y Windows.
    Utiliza las variables automáticas $IsWindows/$IsLinux/$IsMacOS si están disponibles (PowerShell Core),
    y si no, recurre a [System.Runtime.InteropServices.RuntimeInformation] como fallback universal.
.EXAMPLE
    .\detectar-os.ps1
    Muestra: "Estás ejecutando: Windows"
.NOTES
    Autor: Asistente
    Versión: 1.0
#>

function Get-OperatingSystem {
    <#
    .SYNOPSIS
        Devuelve una cadena con el nombre del sistema operativo.
    #>

    # Método preferido: variables automáticas de PowerShell Core (6.0+)
    if (Test-Path variable:IsWindows) {
        if ($IsWindows) { return "Windows" }
        if ($IsLinux)   { return "Linux" }
        if ($IsMacOS)   { return "macOS" }
    }

    # Fallback para Windows PowerShell (5.1) o sistemas donde no estén definidas las variables
    # Requiere .NET Framework 4.7.1+ en Windows, o .NET Core/5+ en otras plataformas.
    $osPlatform = [System.Runtime.InteropServices.RuntimeInformation]

    if ($osPlatform::IsOSPlatform([System.Runtime.InteropServices.OSPlatform]::Windows)) {
        return "Windows"
    }
    if ($osPlatform::IsOSPlatform([System.Runtime.InteropServices.OSPlatform]::Linux)) {
        return "Linux"
    }
    if ($osPlatform::IsOSPlatform([System.Runtime.InteropServices.OSPlatform]::OSX)) {
        return "macOS"
    }

    # Si todo falla, devolvemos información genérica
    # CORRECCIÓN: eliminado ']' extra y paréntesis innecesario
    return "Desconocido ($([System.Environment]::OSVersion.Platform))"
}

# Ejecutar la detección y mostrar el resultado
$so = Get-OperatingSystem
Write-Host "Estás ejecutando: $so" -ForegroundColor Cyan

# Opcional: mostrar más detalles
Write-Host "Versión de PowerShell: $($PSVersionTable.PSVersion)" -ForegroundColor Green
Write-Host "Edición: $($PSVersionTable.PSEdition)" -ForegroundColor Green
