param (
	[string]$EncodeName
)
$encodes = @{
	"utf" = 	@{code = 65001; name = "Unicode"};
	"win" = 	@{code = 1251; 	name = "Windows 1251"};
	"legacy" = 	@{code = 866; 	name = "CP866"};
}

$avaiableCodeSheetsMSG = "доступны utf (65001), win (1251) & legacy (cp866)"
if ($EncodeName -eq "") {
	Write-Host "Укажите кодировку, $avaiableCodeSheetsMSG" -ForegroundColor Red
	exit 1
}

if ($EncodeName -in $encodes.Keys) {
	$codeInfo = $encodes[$EncodeName]
	chcp $($codeInfo.code) *> $null
	Write-Host "Установлена кодировка $($codeInfo.name)" -ForegroundColor Green
	Write-Host ""
}
else {
	chcp $EncodeName *> $null

	if (-not $LASTEXITCODE -eq 0) {
		Write-Host "Неизвестная кодировка $EncodeName, $avaiableCodeSheetsMSG" -ForegroundColor Red
		Write-Host ""
		exit $LASTEXITCODE
	}

	Write-Host "Установлена кодировка $EncodeName" -ForegroundColor Green
	Write-Host ""
}
