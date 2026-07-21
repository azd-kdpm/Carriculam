$destDir = "c:\Users\asadu\Downloads\Quick Share\BotGI\assets"

# Copy the correct intruder alarm image
Copy-Item -Path "C:\Users\asadu\.gemini\antigravity\brain\85b0cac5-bf47-4d98-9572-7c9fcbefa310\offer_alarm_system_1783665711738.jpg" -Destination "$destDir\offer_alarm_system.jpg" -Force

# Let's also copy the cctv_ai image as a slightly better temporary placeholder for fire alarm ceiling device
Copy-Item -Path "$destDir\offer_cctv_ai.jpg" -Destination "$destDir\offer_fire_alarm.jpg" -Force

Write-Host "Updated alarm asset copied!"
