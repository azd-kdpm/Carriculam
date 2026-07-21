$eventDir = "c:\Users\asadu\Downloads\Quick Share\BotGI\event"

$files = @(
    "seminar_plan_v2_en",
    "seminar_plan_v2_ml",
    "talking_points_v2_en",
    "talking_points_v2_ml"
)

Write-Host "Starting compilation of v2 PDFs inside the event folder..."

foreach ($file in $files) {
    $htmlPath = "$eventDir\$file.html"
    $pdfPath = "$eventDir\$file.pdf"
    $tempPdfPath = "$env:TEMP\$file.pdf"

    Write-Host "Converting $file.html to PDF..."

    # Target URL format (escaped space with %20 and forward slashes)
    $url = "file:///$($htmlPath -replace '\\', '/')" -replace ' ', '%20'
    $p = Start-Process -FilePath "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" -ArgumentList "--headless=new", "--no-sandbox", "--print-to-pdf=$tempPdfPath", $url -NoNewWindow -PassThru -Wait

    if ($p.ExitCode -eq 0) {
        Copy-Item -Path $tempPdfPath -Destination $pdfPath -Force
        Write-Host "Successfully compiled: $pdfPath"
    } else {
        Write-Host "Failed to compile $file.html with exit code $($p.ExitCode)"
    }
}

Write-Host "All v2 PDF documents compiled!"
