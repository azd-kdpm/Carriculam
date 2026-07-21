$destDir = "c:\Users\asadu\Downloads\Quick Share\BotGI\assets"
if (!(Test-Path -Path $destDir)) {
    New-Item -ItemType Directory -Path $destDir -Force
}

Copy-Item -Path "C:\Users\asadu\.gemini\antigravity\brain\85b0cac5-bf47-4d98-9572-7c9fcbefa310\slide1_smart_room_real_1783602825714.jpg" -Destination "$destDir\slide1.jpg" -Force
Copy-Item -Path "C:\Users\asadu\.gemini\antigravity\brain\85b0cac5-bf47-4d98-9572-7c9fcbefa310\slide2_education_gap_real_1783602862342.jpg" -Destination "$destDir\slide2.jpg" -Force
Copy-Item -Path "C:\Users\asadu\.gemini\antigravity\brain\85b0cac5-bf47-4d98-9572-7c9fcbefa310\slide5_kerala_villa_real_1783602901374.jpg" -Destination "$destDir\slide5.jpg" -Force
Copy-Item -Path "C:\Users\asadu\.gemini\antigravity\brain\85b0cac5-bf47-4d98-9572-7c9fcbefa310\slide8_professional_real_1783602939245.jpg" -Destination "$destDir\slide8.jpg" -Force

Write-Host "Assets copied successfully!"
