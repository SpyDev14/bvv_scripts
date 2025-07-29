param(
	[string]$path
)
	
# "project" и есть переменная $env:CURRENT_PROJECT
if ($path -eq "project" -and $env:CURRENT_PROJECT) {
	Set-Location $env:CURRENT_PROJECT
	Write-Host "Перешел в папку проекта: $($env:CURRENT_PROJECT)" -ForegroundColor DarkCyan
}

# "scripts" - перейти в родительскую папку скрипта
elseif ($path -eq "scripts") {
	$scriptParent = Split-Path -Parent $MyInvocation.MyCommand.Path
	Set-Location $scriptParent
	Write-Host "Добро пожаловать в скрипты! ($scriptParent)" -ForegroundColor DarkCyan
}

# "local" - открыть http://127.0.0.1:8000
elseif ($path -eq "local") {
	Start-Process "http://127.0.0.1:8000"
}

# Пустой ввод
elseif ($path -eq "") {
	Write-Host "Введите название метки" -ForegroundColor Yellow
}

# Не известная метка
else {
	Write-Host "Метки '$path' не существует." -ForegroundColor Red
}

Write-Host ""
