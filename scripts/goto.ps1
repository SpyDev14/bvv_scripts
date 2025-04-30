param(
    [string]$path
)
    
# Case 2: Если ввод "project" и есть переменная $env:CURRENT_PROJECT
if ($path -eq "project" -and $env:CURRENT_PROJECT) {
    Set-Location $env:CURRENT_PROJECT
    Write-Host "Перешел в папку проекта: $($env:CURRENT_PROJECT)"
    Write-Host ""
    return
}

# Case 3: Если ввод "scripts" - перейти в родительскую папку скрипта
if ($path -eq "scripts") {
    $scriptParent = Split-Path -Parent $MyInvocation.MyCommand.Path
    Set-Location $scriptParent
    Write-Host "Добро пожаловать в скрипты! ($scriptParent)" -ForegroundColor DarkCyan
    Write-Host ""
    return
}

# Case 1: Пробуем перейти по введённому пути
try {
    Set-Location $path -ErrorAction Stop
} catch {
    Write-Host "Ошибка, пути '$path' не существует." -ForegroundColor Red
}

Write-Host ""