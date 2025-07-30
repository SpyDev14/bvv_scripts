param (
	[switch]$new
)

if ($env:VIRTUAL_ENV) {
	Write-Host "Виртуальное окружение Python уже активировано." -ForegroundColor Yellow
	Write-Host ''
	exit 0
}

$venvBasePath = ".\.venv"
$venvScriptPath = "\Scripts\Activate.ps1"
$venvPath = $venvBasePath + $venvScriptPath

$isPipenv = Test-Path "Pipfile" -PathType Leaf
if ($isPipenv) {
	$venvPath = $(pipenv --venv) + $venvScriptPath
}

if ($new) {
	if (Test-Path $venvPath -PathType Leaf) {
		Write-Host "Виртуальное окружение уже существует" -ForegroundColor Red
		Write-Host "Виртуальное окружение активировано" -ForegroundColor Green
	}
	else {
		Write-Host "Создание нового виртуального окружения..." -ForegroundColor Cyan
		Invoke-Expression "python -m venv .venv"

		if (Test-Path $venvPath -PathType Leaf) {
			& $venvPath
			Write-Host "Виртуальное окружение успешно создано и активировано" -ForegroundColor Green
			exit 0
		}
		else {
			Write-Host "Ошибка: Не удалось создать виртуальное окружение" -ForegroundColor Red
		}
	}
}


if (Test-Path $venvPath -PathType Leaf) {
	& $venvPath # Вызов файла по этому пути
} else {
	Write-Host "Ошибка: Не найден файл активации виртуального окружения" -ForegroundColor Red
	Write-Host "Убедитесь, что виртуальное окружение создано в папке .venv" -ForegroundColor Yellow
	Write-Host "Можно создать его командой: python -m venv .venv или использовать этот скрипт с флагом -new" -ForegroundColor Yellow
}
