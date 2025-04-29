<#
.SYNOPSIS
    Автоматически находит и выполняет python manage.py с указанными аргументами.
.DESCRIPTION
    Ищет файл manage.py в текущей директории и выше (до корня диска),
    затем выполняет его с переданными аргументами.
.EXAMPLE
    ./runmanage.ps1 runserver
    ./runmanage.ps1 migrate
    ./runmanage.ps1 createsuperuser
#>

param(
    [Parameter(Mandatory=$false, ValueFromRemainingArguments=$true)]
    [string[]]$Arguments
)

# Получаем текущую директорию как строку
$currentDir = (Get-Location).Path
$managePath = $null


# Функция для безопасного поиска manage.py
function Find-ManagePy {
    param([string]$searchDir)
    
    # Проверяем не пустой ли путь
    if ([string]::IsNullOrEmpty($searchDir)) {
        return $null
    }

    $potentialPath = Join-Path -Path $searchDir -ChildPath "manage.py"
    
    if (Test-Path -Path $potentialPath -PathType Leaf) {
        return $potentialPath
    }
    
    # Поднимаемся на уровень выше
    $parentDir = Split-Path -Path $searchDir -Parent
    
    # Если мы уже в корневой директории
    if ($parentDir -eq $searchDir) {
        return $null
    }
    
    return Find-ManagePy -searchDir $parentDir
}


# Ищем manage.py рекурсивно
$managePath = Find-ManagePy -searchDir $currentDir


if (-not $managePath) {
    Write-Host "Файл manage.py не найден в текущей директории или родительских." -ForegroundColor Red
    exit 1
}

# Проверяем, активировано ли виртуальное окружение (предупреждение)
if (-not $env:VIRTUAL_ENV) {
    Write-Host "Предупреждение: Виртуальное окружение Python не активировано." -ForegroundColor Yellow
}

# Формируем команду
$command = "python `"$managePath`""
if ($Arguments) {
    $command += " " + ($Arguments -join " ")
}

Write-Host "Выполняю: $command" -ForegroundColor Cyan
try {
    Invoke-Expression $command
    if ($LASTEXITCODE -ne 0) {
        exit $LASTEXITCODE
    }
}
catch {
    Write-Host "Ошибка при выполнении команды: $_" -ForegroundColor Red
    exit 1
}