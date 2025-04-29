<#
.SYNOPSIS
    Удаляет папку scripts текущей директории из системного PATH.
#>

# Получаем полный путь к папке scripts в текущей директории
$scriptsPath = Join-Path -Path (Get-Location).Path -ChildPath "scripts"

# Получаем текущий PATH пользователя
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")

# Проверяем, есть ли наш путь в PATH
if ($currentPath -notlike "*$scriptsPath*") {
    Write-Host "Папка $scriptsPath не найдена в PATH." -ForegroundColor Yellow
    exit 0
}

# Удаляем путь из PATH
$newPath = ($currentPath -split ';' | Where-Object { $_ -ne $scriptsPath }) -join ';'


# Применяем изменения
[Environment]::SetEnvironmentVariable("Path", $newPath, "User")

Write-Host "Папка $scriptsPath успешно удалена из PATH." -ForegroundColor Green
Write-Host "Чтобы изменения вступили в силу, закройте и снова откройте терминал." -ForegroundColor Cyan