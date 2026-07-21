$htmlPath = "c:\Users\asadu\Downloads\Quick Share\BotGI\event_presentation.html"
$pdfPath = "c:\Users\asadu\Downloads\Quick Share\BotGI\event_presentation.pdf"
$tempPdfPath = "$env:TEMP\event_presentation.pdf"

Write-Host "Converting Event Slides to PDF..."

# Compile to PDF using headless Edge in landscape mode
$url = "file:///$($htmlPath -replace '\\', '/')" -replace ' ', '%20'
$p = Start-Process -FilePath "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" -ArgumentList "--headless=new", "--no-sandbox", "--print-to-pdf=$tempPdfPath", $url -NoNewWindow -PassThru -Wait

if ($p.ExitCode -eq 0) {
    Copy-Item -Path $tempPdfPath -Destination $pdfPath -Force
    Write-Host "Event Presentation PDF conversion completed successfully. Saved to: $pdfPath"
} else {
    Write-Host "Edge PDF conversion failed with exit code $($p.ExitCode)"
}
