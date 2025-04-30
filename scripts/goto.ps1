param(
    [string]$path
)
    
# Case 2: ���� ���� "project" � ���� ���������� $env:CURRENT_PROJECT
if ($path -eq "project" -and $env:CURRENT_PROJECT) {
    Set-Location $env:CURRENT_PROJECT
    Write-Host "������� � ����� �������: $($env:CURRENT_PROJECT)"
    Write-Host ""
    return
}

# Case 3: ���� ���� "scripts" - ������� � ������������ ����� �������
if ($path -eq "scripts") {
    $scriptParent = Split-Path -Parent $MyInvocation.MyCommand.Path
    Set-Location $scriptParent
    Write-Host "����� ���������� � �������! ($scriptParent)" -ForegroundColor DarkCyan
    Write-Host ""
    return
}

# Case 1: ������� ������� �� ��������� ����
try {
    Set-Location $path -ErrorAction Stop
} catch {
    Write-Host "������, ���� '$path' �� ����������." -ForegroundColor Red
}

Write-Host ""