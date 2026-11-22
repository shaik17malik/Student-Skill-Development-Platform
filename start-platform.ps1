Write-Host "===============================================================" -ForegroundColor Green
Write-Host "  Starting Student Skill Development Platform (SSP)  " -ForegroundColor Cyan
Write-Host "===============================================================" -ForegroundColor Green

$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$ServerDirectory = Join-Path $Root "server"
$ClientDirectory = Join-Path $Root "client"
$BackendUrl = "http://127.0.0.1:8000/api/health"
$FrontendUrl = "http://127.0.0.1:5173/login"

function Test-Endpoint {
    param([string]$Uri)

    try {
        Invoke-WebRequest -Uri $Uri -UseBasicParsing -TimeoutSec 2 | Out-Null
        return $true
    }
    catch {
        return $false
    }
}

if (-not (Test-Endpoint $BackendUrl)) {
    $Python = Join-Path $ServerDirectory "venv\Scripts\python.exe"
    if (-not (Test-Path -LiteralPath $Python)) {
        throw "Backend Python environment not found at $Python"
    }

    Start-Process -FilePath $Python `
        -ArgumentList @("-m", "uvicorn", "app.main:app", "--host", "127.0.0.1", "--port", "8000") `
        -WorkingDirectory $ServerDirectory `
        -WindowStyle Hidden `
        -RedirectStandardOutput (Join-Path $env:TEMP "ssp-backend.log") `
        -RedirectStandardError (Join-Path $env:TEMP "ssp-backend-error.log") | Out-Null
}

if (-not (Test-Endpoint $FrontendUrl)) {
    $Npm = (Get-Command npm.cmd -ErrorAction Stop).Source
    Start-Process -FilePath $Npm `
        -ArgumentList @("run", "dev", "--", "--host", "127.0.0.1", "--port", "5173", "--strictPort") `
        -WorkingDirectory $ClientDirectory `
        -WindowStyle Hidden `
        -RedirectStandardOutput (Join-Path $env:TEMP "ssp-client.log") `
        -RedirectStandardError (Join-Path $env:TEMP "ssp-client-error.log") | Out-Null
}

$Deadline = [DateTime]::UtcNow.AddSeconds(90)
do {
    $BackendReady = Test-Endpoint $BackendUrl
    $FrontendReady = Test-Endpoint $FrontendUrl

    if ($BackendReady -and $FrontendReady) {
        break
    }

    Start-Sleep -Seconds 1
} while ([DateTime]::UtcNow -lt $Deadline)

if (-not $BackendReady -or -not $FrontendReady) {
    throw "Platform startup failed. Backend ready: $BackendReady; frontend ready: $FrontendReady. Check the ssp-backend and ssp-client logs in $env:TEMP."
}

Write-Host "Backend:  $BackendUrl"
Write-Host "Frontend: $FrontendUrl"
Start-Process $FrontendUrl
