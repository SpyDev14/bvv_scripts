param (
	[switch]$new
)

$venvScriptPath = ".\.venv\Scripts\Activate.ps1"

if ($new) {
	if (Test-Path $venvScriptPath -PathType Leaf) {
		Write-Host "����������� ��������� ��� ����������" -ForegroundColor Red
		Write-Host "����������� ��������� ������������" -ForegroundColor Green
	} else {
		Write-Host "�������� ������ ������������ ���������..." -ForegroundColor Cyan
		Invoke-Expression "python -m venv .venv"

		if (Test-Path $venvScriptPath -PathType Leaf) {
			& $venvScriptPath
			Write-Host "����������� ��������� ������� ������� � ������������" -ForegroundColor Green
			return
		} else {
			Write-Host "������: �� ������� ������� ����������� ���������" -ForegroundColor Red
		}
	}
}


if (Test-Path $venvScriptPath -PathType Leaf) {
	& $venvScriptPath # ����� ����� �� ����� ����
} else {
	Write-Host "������: �� ������ ���� ��������� ������������ ���������" -ForegroundColor Red
	Write-Host "���������, ��� ����������� ��������� ������� � ����� .venv" -ForegroundColor Yellow
	Write-Host "����� ������� ��� ��������: python -m venv .venv ��� ������������ ���� ������ � ������ -new" -ForegroundColor Yellow
}
