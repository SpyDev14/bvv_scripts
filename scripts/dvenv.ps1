if (-not $env:VIRTUAL_ENV) {
	Write-Host "Виртуальное окружение Python не активировано." -ForegroundColor Red
	Write-Host ''
	exit 1
}

deactivate
