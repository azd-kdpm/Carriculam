$destDir = "c:\Users\asadu\Downloads\Quick Share\BotGI\assets"

# Copy the generated Ajax fire alarm panel to assets
Copy-Item -Path "C:\Users\asadu\.gemini\antigravity\brain\85b0cac5-bf47-4d98-9572-7c9fcbefa310\offer_fire_alarm_ajax_1783674226918.jpg" -Destination "$destDir\offer_fire_alarm.jpg" -Force

Write-Host "Ajax fire alarm asset copied successfully!"
