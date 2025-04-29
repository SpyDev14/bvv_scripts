<#
.SYNOPSIS
    Добавляет папку scripts текущей директории в системный PATH на постоянной основе.
#>

# Получаем полный путь к папке scripts в текущей директории
$scriptsPath = Join-Path -Path (Get-Location).Path -ChildPath "scripts"

# Проверяем существование папки
if (-not (Test-Path -Path $scriptsPath -PathType Container)) {
    Write-Host "Папка scripts не найдена в текущей директории." -ForegroundColor Red
    exit 1
}

# Получаем текущий PATH пользователя
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")


# Проверяем, не добавлена ли уже эта папка
if ($currentPath -split ';' -contains $scriptsPath) {
    Write-Host "Папка scripts уже добавлена в PATH." -ForegroundColor Yellow
    exit 0
}

# Добавляем папку в PATH
$newPath = $currentPath + ";" + $scriptsPath
[Environment]::SetEnvironmentVariable("Path", $newPath, "User")

# Применяем изменения
[Environment]::SetEnvironmentVariable("Path", $newPath, "User")

Write-Host "Папка $scriptsPath успешно добавлена в PATH (для текущего пользователя)." -ForegroundColor Green
Write-Host "Чтобы изменения вступили в силу, закройте и снова откройте терминал." -ForegroundColor Cyan