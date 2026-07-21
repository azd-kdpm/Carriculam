$c = Get-Content -Path .\scratch\generate_slides.ps1 -Raw
$c = $c -replace '\{\{', '{'
$c = $c -replace '\}\}', '}'
Set-Content -Path .\scratch\generate_slides.ps1 -Value $c -Encoding utf8
