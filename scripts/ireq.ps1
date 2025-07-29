<#
.SYNOPSIS
	Устанавливает зависимости из req.txt, если активирован venv и файл существует.
#>

function InstallByPipReq {
	param (
		[string]$targetFile
	)

	# Проверяем, активирован ли venv
	$isVenvActive = $null -ne $env:VIRTUAL_ENV
	
	if (-not $isVenvActive)
	{
		Write-Host "Виртуальное окружение Python не активировано." -ForegroundColor Red
		exit 1
	}
	
	# Выполняем установку зависимостей
	Write-Host "Установка зависимостей из $targetFile..." -ForegroundColor Green
	Invoke-Expression "pip install -r $targetFile"
}

function InstallByPipenv {
	Write-Host "Установка зависимостей с помощью pipenv..." -ForegroundColor Green
	Invoke-Expression "pipenv install"
}

# Проверяем наличие файлов
$reqFiles = @("Pipfile", "requirements.txt", "req.txt")
$targetFile = $null

foreach ($file in $reqFiles) {
	if (Test-Path -Path $file -PathType Leaf) {
		$targetFile = $file
		break
	}
}

if (-not $targetFile) {
	Write-Host "Ни $($reqFiles -join ", ни ") не найдены в текущей директории." -ForegroundColor Red
	exit 1
}


if ($targetFile -eq "Pipfile") {
	InstallByPipenv
}
else {
	InstallByPipReq $targetFile
}

if ($LASTEXITCODE -eq 0) {
	Write-Host "Зависимости успешно установлены." -ForegroundColor Green
}
else {
	Write-Host "Ошибка при установке зависимостей." -ForegroundColor Red
	exit $LASTEXITCODE
}
