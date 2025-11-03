# Script: run_app.ps1

if ($null -eq $env:APP_MODE) {
    Write-Host " Variable APP_MODE no esta definida."
} else {
    Write-Host "APP_MODE: $env:APP_MODE"
}

if ($null -eq $env:DB_USER) {
    Write-Host " Variable DB_USER no esta definida."
} else {
    Write-Host "DB_USER: $env:DB_USER"
}
