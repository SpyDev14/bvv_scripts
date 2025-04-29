<#
.SYNOPSIS
    ������������� ����������� �� req.txt, ���� ����������� venv � ���� ����������.
#>

# ���������, ����������� �� venv
$isVenvActive = $env:VIRTUAL_ENV -ne $null

if (-not $isVenvActive) {
    Write-Host "����������� ��������� Python �� ������������." -ForegroundColor Red
    exit 1
}

# ��������� ������� ������ req.txt ��� requirements.txt
$reqFiles = @("req.txt", "requirements.txt")
$targetFile = $null

foreach ($file in $reqFiles) {
    if (Test-Path -Path $file -PathType Leaf) {
        $targetFile = $file
        break
    }
}

if (-not $targetFile) {
    Write-Host "����� req.txt � requirements.txt �� ������� � ������� ����������." -ForegroundColor Red
    exit 1
}

# ��������� ��������� ������������
Write-Host "��������� ������������ �� $targetFile..." -ForegroundColor Green
pip install -r $targetFile

if ($LASTEXITCODE -eq 0) {
    Write-Host "����������� ������� �����������." -ForegroundColor Green
} else {
    Write-Host "������ ��� ��������� ������������." -ForegroundColor Red
    exit $LASTEXITCODE
}