param (
	[string]$Path
)

if ($Path -eq '')
{
	Write-Host "Вы не указали путь`n" -ForegroundColor Red
	exit 1
}

$projectPath = $null
try {
	$projectPath = Resolve-Path $Path -ErrorAction Stop
}
catch {
	Write-Host "Указанного пути не существует.`n" -ForegroundColor Red
	exit 1
}

[System.Environment]::SetEnvironmentVariable("CURRENT_PROJECT", $projectPath, [System.EnvironmentVariableTarget]::User)
Write-Host "Новое местоположение `$CURRENT_PROJECT успешно установлено в $projectPath`n" -ForegroundColor Green
