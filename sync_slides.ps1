Write-Host "Checking for slide updates..." -ForegroundColor Cyan

# Set location to the script directory
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location -Path $scriptPath

# Stage all files
& "C:\Program Files\Git\cmd\git.exe" add .

# Get git status changes
$status = & "C:\Program Files\Git\cmd\git.exe" status --porcelain

if ($status) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $commitMessage = "Auto-update slides: $timestamp"
    
    Write-Host "Changes detected. Committing..." -ForegroundColor Green
    & "C:\Program Files\Git\cmd\git.exe" commit -m $commitMessage
    
    Write-Host "Pushing updates to GitHub..." -ForegroundColor Green
    $pushResult = & "C:\Program Files\Git\cmd\git.exe" push origin main 2>&1
    Write-Output $pushResult
    
    Write-Host "`nSync successful! Your live website will update in a few seconds." -ForegroundColor Green
} else {
    Write-Host "No changes detected. Slides are already up to date!" -ForegroundColor Yellow
}

# Wait for key press before closing
Write-Host "`nPress any key to close..." -ForegroundColor Cyan
[void]$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
