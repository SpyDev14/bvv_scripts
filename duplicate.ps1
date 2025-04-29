# Получаем текущий путь
$currentPath = Get-Location -PSProvider FileSystem
$venvScriptPath = ".\.venv\Scripts\Activate.ps1"


# можно добавить к avenv в if: ; Write-Host '.venv activated' -ForegroundColor Green
# Формируем команды для нового терминала
$commands = @(
    "cd '$currentPath'",                                                 # Переходим в текущую папку
    "if (Test-Path $venvScriptPath -PathType Leaf) { avenv }", # Если есть avenv — активируем venv
    "Write-Host 'New Terminal in: $currentPath' -ForegroundColor Green"  # Выводим инфо
) -join "; "

# Открываем новое окно Windows Terminal и выполняем команды
Start-Process powershell -ArgumentList @(
    "-NoExit",                      # Не закрывать после выполнения
    "-Command", $commands           # Выполняем наши команды
)