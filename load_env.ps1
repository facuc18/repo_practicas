# Script: load_env.ps1
# Carga las variables desde .env y las muestra

if (Test-Path ".env") {
    Get-Content ".env" | ForEach-Object {
        if ($_ -match "^(.*?)=(.*)$") {
            $name = $matches[1].Trim()
            $value = $matches[2].Trim()
            [System.Environment]::SetEnvironmentVariable($name, $value, "Process")
        }
    }

    Write-Host "Variables cargadas desde .env:"
    Write-Host "PORT: $env:PORT"
    Write-Host "HOST: $env:HOST"
    Write-Host "LOG_LEVEL: $env:LOG_LEVEL"
} else {
    Write-Host " No se encontro el archivo .env"
}
