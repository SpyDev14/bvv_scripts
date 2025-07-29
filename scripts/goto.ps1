param(
	[string]$path
)
	
# "project" � ���� ���������� $env:CURRENT_PROJECT
if ($path -eq "project" -and $env:CURRENT_PROJECT) {
	Set-Location $env:CURRENT_PROJECT
	Write-Host "������� � ����� �������: $($env:CURRENT_PROJECT)" -ForegroundColor DarkCyan
}

# "scripts" - ������� � ������������ ����� �������
elseif ($path -eq "scripts") {
	$scriptParent = Split-Path -Parent $MyInvocation.MyCommand.Path
	Set-Location $scriptParent
	Write-Host "����� ���������� � �������! ($scriptParent)" -ForegroundColor DarkCyan
}

# "local" - ������� http://127.0.0.1:8000
elseif ($path -eq "local") {
	Start-Process "http://127.0.0.1:8000"
}

# ������ ����
elseif ($path -eq "") {
	Write-Host "������� �������� �����" -ForegroundColor Yellow
}

# �� ��������� �����
else {
	Write-Host "����� '$path' �� ����������." -ForegroundColor Red
}

Write-Host ""
