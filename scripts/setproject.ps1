param (
	[string]$Path
)

if ($Path -eq '')
{
	Write-Host "�� �� ������� ����`n" -ForegroundColor Red
	exit 1
}

$projectPath = $null
try {
	$projectPath = Resolve-Path $Path -ErrorAction Stop
}
catch {
	Write-Host "���������� ���� �� ����������.`n" -ForegroundColor Red
	exit 1
}

[System.Environment]::SetEnvironmentVariable("CURRENT_PROJECT", $projectPath, [System.EnvironmentVariableTarget]::User)
Write-Host "����� �������������� `$CURRENT_PROJECT ������� ����������� � $projectPath`n" -ForegroundColor Green
