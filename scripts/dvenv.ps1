if (-not $env:VIRTUAL_ENV) {
	Write-Host "����������� ��������� Python �� ������������." -ForegroundColor Red
	Write-Host ''
	exit 1
}

deactivate
