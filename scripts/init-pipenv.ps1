[System.Environment]::SetEnvironmentVariable("PIPENV_VENV_IN_PROJECT", 1, [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable("PIPENV_VERBOSITY", -1, [System.EnvironmentVariableTarget]::User)

Write-Host "Настройки по умолчанию для pipenv успешно установлены." -ForegroundColor Green
Write-Host ""
