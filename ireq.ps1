<#
.SYNOPSIS
    Устанавливает зависимости из req.txt, если активирован venv и файл существует.
#>

# Проверяем, активирован ли venv
$isVenvActive = $env:VIRTUAL_ENV -ne $null

if (-not $isVenvActive) {
    Write-Host "Виртуальное окружение Python не активировано." -ForegroundColor Red
    exit 1
}

# Проверяем наличие файлов req.txt или requirements.txt
$reqFiles = @("req.txt", "requirements.txt")
$targetFile = $null

foreach ($file in $reqFiles) {
    if (Test-Path -Path $file -PathType Leaf) {
        $targetFile = $file
        break
    }
}

if (-not $targetFile) {
    Write-Host "Файлы req.txt и requirements.txt не найдены в текущей директории." -ForegroundColor Red
    exit 1
}

# Выполняем установку зависимостей
Write-Host "Установка зависимостей из $targetFile..." -ForegroundColor Green
pip install -r $targetFile

if ($LASTEXITCODE -eq 0) {
    Write-Host "Зависимости успешно установлены." -ForegroundColor Green
} else {
    Write-Host "Ошибка при установке зависимостей." -ForegroundColor Red
    exit $LASTEXITCODE
}