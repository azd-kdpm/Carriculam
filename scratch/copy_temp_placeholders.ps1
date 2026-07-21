$destDir = "c:\Users\asadu\Downloads\Quick Share\BotGI\assets"

Copy-Item -Path "$destDir\slide1.jpg" -Destination "$destDir\offer_alarm_system.jpg" -Force
Copy-Item -Path "$destDir\slide1.jpg" -Destination "$destDir\offer_fire_alarm.jpg" -Force

Write-Host "Temporary placeholders copied for alarm and fire alarm!"
