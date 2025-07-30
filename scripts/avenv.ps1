param (
	[switch]$new
)

if ($env:VIRTUAL_ENV) {
	Write-Host "����������� ��������� Python ��� ������������." -ForegroundColor Yellow
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
		Write-Host "����������� ��������� ��� ����������" -ForegroundColor Red
		Write-Host "����������� ��������� ������������" -ForegroundColor Green
	}
	else {
		Write-Host "�������� ������ ������������ ���������..." -ForegroundColor Cyan
		Invoke-Expression "python -m venv .venv"

		if (Test-Path $venvPath -PathType Leaf) {
			& $venvPath
			Write-Host "����������� ��������� ������� ������� � ������������" -ForegroundColor Green
			exit 0
		}
		else {
			Write-Host "������: �� ������� ������� ����������� ���������" -ForegroundColor Red
		}
	}
}


if (Test-Path $venvPath -PathType Leaf) {
	& $venvPath # ����� ����� �� ����� ����
} else {
	Write-Host "������: �� ������ ���� ��������� ������������ ���������" -ForegroundColor Red
	Write-Host "���������, ��� ����������� ��������� ������� � ����� .venv" -ForegroundColor Yellow
	Write-Host "����� ������� ��� ��������: python -m venv .venv ��� ������������ ���� ������ � ������ -new" -ForegroundColor Yellow
}
