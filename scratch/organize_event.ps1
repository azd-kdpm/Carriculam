$baseDir = "c:\Users\asadu\Downloads\Quick Share\BotGI"
$eventDir = "$baseDir\event"

# Create event directory
if (!(Test-Path -Path $eventDir)) {
    New-Item -ItemType Directory -Path $eventDir -Force
}

# Move HTML and PDF presentation files
if (Test-Path -Path "$baseDir\event_presentation.html") {
    Move-Item -Path "$baseDir\event_presentation.html" -Destination "$eventDir\event_presentation.html" -Force
}
if (Test-Path -Path "$baseDir\event_presentation.pdf") {
    Move-Item -Path "$baseDir\event_presentation.pdf" -Destination "$eventDir\event_presentation.pdf" -Force
}

# Copy compiler script and update it
if (Test-Path -Path "$baseDir\scratch\generate_event_presentation.ps1") {
    Copy-Item -Path "$baseDir\scratch\generate_event_presentation.ps1" -Destination "$eventDir\generate_event_presentation.ps1" -Force
}

Write-Host "Files moved to event directory!"
