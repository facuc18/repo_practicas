# ===============================================
# menu_carpetas.ps1
# Script para gestionar carpetas en PowerShell
# Autor: $env:UserName
# ===============================================

# 1) Preparación del workspace
$workspace = "C:\tmp\tp_carpetas_$env:UserName"

if (-not (Test-Path $workspace)) {
    New-Item -ItemType Directory -Path $workspace | Out-Null
    Write-Host "Workspace creado en: $workspace"
} else {
    Write-Host "Usando workspace existente: $workspace"
}

Set-Location $workspace

# 2) Menú principal
while ($true) {
    Write-Host ""
    Write-Host "===== MENU DE CARPETAS ====="
    Write-Host "1) Crear carpeta"
    Write-Host "2) Listar carpetas"
    Write-Host "3) Renombrar carpeta"
    Write-Host "4) Eliminar carpeta"
    Write-Host "5) Salir"
    $op = Read-Host "Seleccione una opcion (1-5)"

    switch ($op) {
#=========crear==========#
        '1' {
    # Opción 1: Crear carpeta
    $nombre = Read-Host "Ingrese el nombre de la nueva carpeta"

    # Validar nombre: no vacío, sin / ni ..
    if ([string]::IsNullOrWhiteSpace($nombre) -or
        $nombre -match '[\\/]' -or
        $nombre -match '\.\.') {
        Write-Host " Nombre invalido. No use '/', '..' ni deje vacio."
        return
    }

    # Verificar si ya existe
    if (Test-Path "$workspace\$nombre") {
        Write-Host " La carpeta '$nombre' ya existe."
    } else {
        New-Item -ItemType Directory -Path "$workspace\$nombre" | Out-Null
        Write-Host " Carpeta '$nombre' creada correctamente."
    }
}
#================listar==================#
       '2' {
    # Opción 2: Listar carpetas
    Write-Host ""
    Write-Host " Carpetas dentro del workspace:"
    
    # Obtener solo directorios dentro del workspace actual
    $carpetas = Get-ChildItem -Directory

    if ($carpetas.Count -eq 0) {
        Write-Host "   (No hay carpetas creadas aun)"
    } else {
        foreach ($c in $carpetas) {
            Write-Host "   - $($c.Name)"
        }
    }
}
#============renombrar============#
        '3' {
    # Opción 3: Renombrar carpeta
    $origen = Read-Host "Ingrese el nombre de la carpeta a renombrar"
    $destino = Read-Host "Ingrese el nuevo nombre"

    # Validar nombres
    if ([string]::IsNullOrWhiteSpace($origen) -or
        [string]::IsNullOrWhiteSpace($destino) -or
        $origen -match '[\\/]' -or
        $destino -match '[\\/]' -or
        $origen -match '\.\.' -or
        $destino -match '\.\.') {
        Write-Host " Nombres invalidos. No use '/', '..' ni deje vacio."
        return
    }

    # Verificar existencia del origen
    if (-not (Test-Path "$workspace\$origen")) {
        Write-Host " La carpeta '$origen' no existe."
        return
    }

    # Verificar si el destino ya existe
    if (Test-Path "$workspace\$destino") {
        Write-Host " Ya existe una carpeta llamada '$destino'."
        return
    }

    # Renombrar
    Rename-Item -Path "$workspace\$origen" -NewName "$destino"
    Write-Host " Carpeta '$origen' renombrada a '$destino'."
}
#============eliminar============#
        '4' {
    # Opción 4: Eliminar carpeta
    $nombre = Read-Host "Ingrese el nombre de la carpeta a eliminar"

    # Validar nombre
    if ([string]::IsNullOrWhiteSpace($nombre) -or
        $nombre -match '[\\/]' -or
        $nombre -match '\.\.') {
        Write-Host " Nombre invalido. No use '/', '..' ni deje vacao."
        return
    }

    $ruta = "$workspace\$nombre"

    # Verificar existencia
    if (-not (Test-Path $ruta)) {
        Write-Host " La carpeta '$nombre' no existe."
        return
    }

    # Verificar si está vacía
    $contenido = Get-ChildItem -Path $ruta
    if ($contenido.Count -eq 0) {
        Remove-Item -Path $ruta
        Write-Host " Carpeta '$nombre' eliminada correctamente (estaba vacia)."
    }
    else {
        Write-Host " La carpeta '$nombre' no está vacía."
        $forzar = Read-Host "¿Desea forzar su eliminación? (S/N)"
        if ($forzar -match '^[sS]$') {
            Remove-Item -Recurse -Force -Path $ruta
            Write-Host " Carpeta '$nombre' eliminada completamente (forzada)."
        }
        else {
            Write-Host " Operación cancelada. Carpeta no eliminada."
        }
    }
}

#=============salir===========#
       '5' {
    Write-Host ""
       Write-Host "Programa finalizado correctamente."
    exit
}

        default { Write-Host "Opcion invalida. Intente nuevamente." }
    }
}
