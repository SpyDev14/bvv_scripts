param (
	[switch]$new
)

$venvScriptPath = ".\.venv\Scripts\Activate.ps1"

if ($new) {
	if (Test-Path $venvScriptPath -PathType Leaf) {
		Write-Host "Виртуальное окружение уже существует" -ForegroundColor Red
		Write-Host "Виртуальное окружение активировано" -ForegroundColor Green
	} else {
		Write-Host "Создание нового виртуального окружения..." -ForegroundColor Cyan
		Invoke-Expression "python -m venv .venv"

		if (Test-Path $venvScriptPath -PathType Leaf) {
			& $venvScriptPath
			Write-Host "Виртуальное окружение успешно создано и активировано" -ForegroundColor Green
			return
		} else {
			Write-Host "Ошибка: Не удалось создать виртуальное окружение" -ForegroundColor Red
		}
	}
}


if (Test-Path $venvScriptPath -PathType Leaf) {
	& $venvScriptPath # Вызов файла по этому пути
} else {
	Write-Host "Ошибка: Не найден файл активации виртуального окружения" -ForegroundColor Red
	Write-Host "Убедитесь, что виртуальное окружение создано в папке .venv" -ForegroundColor Yellow
	Write-Host "Можно создать его командой: python -m venv .venv или использовать этот скрипт с флагом -new" -ForegroundColor Yellow
}
