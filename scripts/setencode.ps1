param (
    [string]$EncodeName
)

if ($EncodeName -eq "utf") {
	Write-Host "Установлена кодировка Unicode" -ForegroundColor Green
	chcp 65001
}
elseif ($EncodeName -eq "win") {
	Write-Host "Установлена кодировка Windows 1251" -ForegroundColor Green
	chcp 1251
}
elseif ($EncodeName -eq "1251") {
	Write-Host "Установлена кодировка Windows 1251" -ForegroundColor Green
	chcp 1251
}
elseif ($EncodeName -eq "old") {
	Write-Host "Установлена кодировка CP866" -ForegroundColor Green
	chcp 866
}
elseif ($EncodeName -eq "866") {
	Write-Host "Установлена кодировка CP866" -ForegroundColor Green
	chcp 866
}
else {
	Write-Host "Неизвестная кодировка, есть utf (65001), win (1251) & old (866)" -ForegroundColor Red
}