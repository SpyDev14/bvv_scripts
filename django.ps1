<#
.SYNOPSIS
    ������������� ������� � ��������� python manage.py � ���������� �����������.
.DESCRIPTION
    ���� ���� manage.py � ������� ���������� � ���� (�� ����� �����),
    ����� ��������� ��� � ����������� �����������.
.EXAMPLE
    ./runmanage.ps1 runserver
    ./runmanage.ps1 migrate
    ./runmanage.ps1 createsuperuser
#>

param(
    [Parameter(Mandatory=$false, ValueFromRemainingArguments=$true)]
    [string[]]$Arguments
)

# �������� ������� ���������� ��� ������
$currentDir = (Get-Location).Path
$managePath = $null


# ������� ��� ����������� ������ manage.py
function Find-ManagePy {
    param([string]$searchDir)
    
    # ��������� �� ������ �� ����
    if ([string]::IsNullOrEmpty($searchDir)) {
        return $null
    }

    $potentialPath = Join-Path -Path $searchDir -ChildPath "manage.py"
    
    if (Test-Path -Path $potentialPath -PathType Leaf) {
        return $potentialPath
    }
    
    # ����������� �� ������� ����
    $parentDir = Split-Path -Path $searchDir -Parent
    
    # ���� �� ��� � �������� ����������
    if ($parentDir -eq $searchDir) {
        return $null
    }
    
    return Find-ManagePy -searchDir $parentDir
}


# ���� manage.py ����������
$managePath = Find-ManagePy -searchDir $currentDir


if (-not $managePath) {
    Write-Host "���� manage.py �� ������ � ������� ���������� ��� ������������." -ForegroundColor Red
    exit 1
}

# ���������, ������������ �� ����������� ��������� (��������������)
if (-not $env:VIRTUAL_ENV) {
    Write-Host "��������������: ����������� ��������� Python �� ������������." -ForegroundColor Yellow
}

# ��������� �������
$command = "python `"$managePath`""
if ($Arguments) {
    $command += " " + ($Arguments -join " ")
}

Write-Host "��������: $command" -ForegroundColor Cyan
try {
    Invoke-Expression $command
    if ($LASTEXITCODE -ne 0) {
        exit $LASTEXITCODE
    }
}
catch {
    Write-Host "������ ��� ���������� �������: $_" -ForegroundColor Red
    exit 1
}