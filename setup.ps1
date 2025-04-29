<#
.SYNOPSIS
    ��������� ����� scripts ������� ���������� � ��������� PATH �� ���������� ������.
#>

# �������� ������ ���� � ����� scripts � ������� ����������
$scriptsPath = Join-Path -Path (Get-Location).Path -ChildPath "scripts"

# ��������� ������������� �����
if (-not (Test-Path -Path $scriptsPath -PathType Container)) {
    Write-Host "����� scripts �� ������� � ������� ����������." -ForegroundColor Red
    exit 1
}

# �������� ������� PATH ������������
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")


# ���������, �� ��������� �� ��� ��� �����
if ($currentPath -split ';' -contains $scriptsPath) {
    Write-Host "����� scripts ��� ��������� � PATH." -ForegroundColor Yellow
    exit 0
}

# ��������� ����� � PATH
$newPath = $currentPath + ";" + $scriptsPath
[Environment]::SetEnvironmentVariable("Path", $newPath, "User")

# ��������� ���������
[Environment]::SetEnvironmentVariable("Path", $newPath, "User")

Write-Host "����� $scriptsPath ������� ��������� � PATH (��� �������� ������������)." -ForegroundColor Green
Write-Host "����� ��������� �������� � ����, �������� � ����� �������� ��������." -ForegroundColor Cyan