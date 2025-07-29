<#
.SYNOPSIS
	������������� ����������� �� req.txt, ���� ����������� venv � ���� ����������.
#>

function InstallByPipReq {
	param (
		[string]$targetFile
	)

	# ���������, ����������� �� venv
	$isVenvActive = $null -ne $env:VIRTUAL_ENV
	
	if (-not $isVenvActive)
	{
		Write-Host "����������� ��������� Python �� ������������." -ForegroundColor Red
		exit 1
	}
	
	# ��������� ��������� ������������
	Write-Host "��������� ������������ �� $targetFile..." -ForegroundColor Green
	Invoke-Expression "pip install -r $targetFile"
}

function InstallByPipenv {
	Write-Host "��������� ������������ � ������� pipenv..." -ForegroundColor Green
	Invoke-Expression "pipenv install"
}

# ��������� ������� ������
$reqFiles = @("Pipfile", "requirements.txt", "req.txt")
$targetFile = $null

foreach ($file in $reqFiles) {
	if (Test-Path -Path $file -PathType Leaf) {
		$targetFile = $file
		break
	}
}

if (-not $targetFile) {
	Write-Host "�� $($reqFiles -join ", �� ") �� ������� � ������� ����������." -ForegroundColor Red
	exit 1
}


if ($targetFile -eq "Pipfile") {
	InstallByPipenv
}
else {
	InstallByPipReq $targetFile
}

if ($LASTEXITCODE -eq 0) {
	Write-Host "����������� ������� �����������." -ForegroundColor Green
}
else {
	Write-Host "������ ��� ��������� ������������." -ForegroundColor Red
	exit $LASTEXITCODE
}
