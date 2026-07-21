$destDir = "c:\Users\asadu\Downloads\Quick Share\BotGI\assets"

# Copy alarm panel to fire alarm placeholder (looks much more appropriate than CCTV camera)
Copy-Item -Path "$destDir\offer_alarm_system.jpg" -Destination "$destDir\offer_fire_alarm.jpg" -Force

# Copy technical lab graduate image to networking placeholder
Copy-Item -Path "$destDir\slide2.jpg" -Destination "$destDir\offer_networking.jpg" -Force

Write-Host "New placeholders copied!"
