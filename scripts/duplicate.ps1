# �������� ������� ����
$currentPath = Get-Location -PSProvider FileSystem
$venvScriptPath = ".\.venv\Scripts\Activate.ps1"


# ����� �������� � avenv � if: ; Write-Host '.venv activated' -ForegroundColor Green
# ��������� ������� ��� ������ ���������
$commands = @(
    "cd '$currentPath'",                                                 # ��������� � ������� �����
    "if (Test-Path $venvScriptPath -PathType Leaf) { avenv }", # ���� ���� avenv � ���������� venv
    "Write-Host 'New Terminal in: $currentPath' -ForegroundColor Green"  # ������� ����
) -join "; "

# ��������� ����� ���� Windows Terminal � ��������� �������
Start-Process powershell -ArgumentList @(
    "-NoExit",                      # �� ��������� ����� ����������
    "-Command", $commands           # ��������� ���� �������
)
