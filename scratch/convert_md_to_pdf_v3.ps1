$mdPath = "C:\Users\asadu\.gemini\antigravity\brain\e8179a66-1e06-4b01-aa03-b57af1713c43\curriculum_plan.md"
$htmlPath = "C:\Users\asadu\.gemini\antigravity\brain\e8179a66-1e06-4b01-aa03-b57af1713c43\curriculum_plan_v3.html"
$pdfPath = "C:\Users\asadu\.gemini\antigravity\brain\e8179a66-1e06-4b01-aa03-b57af1713c43\curriculum_plan_v3.pdf"

$lines = Get-Content -Path $mdPath
$htmlBody = ""
$inTable = $false
$inList = $false
$inAlert = $false

foreach ($line in $lines) {
    $trimmed = $line.Trim()
    
    # Close table if we are not in one
    if ($inTable -and -not $trimmed.StartsWith("|")) {
        $htmlBody += "</tbody></table>`n"
        $inTable = $false
    }
    
    # Close list if we are not in one
    if ($inList -and -not ($trimmed.StartsWith("*") -or $trimmed.StartsWith("-") -or $trimmed.StartsWith("•"))) {
        $htmlBody += "</ul>`n"
        $inList = $false
    }
    
    # Close alert/blockquote
    if ($inAlert -and -not $trimmed.StartsWith(">")) {
        $htmlBody += "</div>`n"
        $inAlert = $false
    }
    
    # Process line
    if ($trimmed.StartsWith("|")) {
        # Check if it's separator row
        if ($trimmed -match "^\|[\s:-|]+$") {
            continue
        }
        
        # Split cells
        # Remove leading/trailing pipes
        $cells = $trimmed.SubString(1, $trimmed.Length - 2).Split("|")
        
        if (-not $inTable) {
            $htmlBody += "<table><thead><tr>`n"
            foreach ($cell in $cells) {
                # Format cell text (bold)
                $cellText = $cell.Trim() -replace '\*\*(.*?)\*\*','<strong>$1</strong>'
                $htmlBody += "<th>$cellText</th>`n"
            }
            $htmlBody += "</tr></thead><tbody>`n"
            $inTable = $true
        } else {
            $htmlBody += "<tr>`n"
            foreach ($cell in $cells) {
                # Format cell text (bold, break lines)
                $cellText = $cell.Trim() -replace '\*\*(.*?)\*\*','<strong>$1</strong>'
                $cellText = $cellText -replace '<br>', '<br>'
                $cellText = $cellText -replace '\\<br\\>', '<br>'
                $htmlBody += "<td>$cellText</td>`n"
            }
            $htmlBody += "</tr>`n"
        }
    }
    elseif ($trimmed.StartsWith("*") -or $trimmed.StartsWith("-") -or $trimmed.StartsWith("•")) {
        $itemText = $trimmed.SubString(1).Trim() -replace '\*\*(.*?)\*\*','<strong>$1</strong>'
        if (-not $inList) {
            $htmlBody += "<ul>`n"
            $inList = $true
        }
        $htmlBody += "<li>$itemText</li>`n"
    }
    elseif ($trimmed.StartsWith(">")) {
        $quoteText = $trimmed.SubString(1).Trim()
        if ($quoteText -match "\[!IMPORTANT\]") {
            $htmlBody += "<div class='alert alert-important'><strong>IMPORTANT:</strong> "
            $inAlert = $true
        }
        elseif ($quoteText -match "\[!TIP\]") {
            $htmlBody += "<div class='alert alert-tip'><strong>TIP:</strong> "
            $inAlert = $true
        }
        elseif ($quoteText -match "\[!NOTE\]") {
            $htmlBody += "<div class='alert alert-note'><strong>NOTE:</strong> "
            $inAlert = $true
        }
        else {
            if ($inAlert) {
                $htmlBody += "$quoteText "
            } else {
                $htmlBody += "<div class='alert'>$quoteText"
                $inAlert = $true
            }
        }
    }
    elseif ($trimmed.StartsWith("###")) {
        $headerText = $trimmed.SubString(3).Trim() -replace '\*\*(.*?)\*\*','<strong>$1</strong>'
        $htmlBody += "<h3>$headerText</h3>`n"
    }
    elseif ($trimmed.StartsWith("##")) {
        $headerText = $trimmed.SubString(2).Trim() -replace '\*\*(.*?)\*\*','<strong>$1</strong>'
        $htmlBody += "<h2>$headerText</h2>`n"
    }
    elseif ($trimmed.StartsWith("#")) {
        $headerText = $trimmed.SubString(1).Trim() -replace '\*\*(.*?)\*\*','<strong>$1</strong>'
        $htmlBody += "<h1>$headerText</h1>`n"
    }
    elseif ($trimmed -eq "---") {
        $htmlBody += "<hr>`n"
    }
    else {
        if ($trimmed.Length -gt 0) {
            # Format text
            $lineText = $trimmed -replace '\*\*(.*?)\*\*','<strong>$1</strong>'
            $htmlBody += "<p>$lineText</p>`n"
        }
    }
}

# Cleanup open tags
if ($inTable) { $htmlBody += "</tbody></table>`n" }
if ($inList) { $htmlBody += "</ul>`n" }
if ($inAlert) { $htmlBody += "</div>`n" }

$htmlTemplate = @"
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Practical Curriculum Design: Security, Automation, & IoT Systems</title>
<style>
  @page {
    size: A4 portrait;
    margin: 15mm;
  }
  body {
    font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, Roboto, Helvetica, Arial, sans-serif;
    color: #333333;
    line-height: 1.4;
    padding: 0;
    margin: 0;
  }
  h1 {
    font-size: 22px;
    color: #1a1a1a;
    border-bottom: 2px solid #eaeaea;
    padding-bottom: 6px;
    margin-top: 25px;
  }
  h2 {
    font-size: 18px;
    color: #2c3e50;
    margin-top: 20px;
    border-bottom: 1px solid #eee;
    padding-bottom: 4px;
    page-break-after: avoid;
  }
  h3 {
    font-size: 14px;
    color: #34495e;
    margin-top: 15px;
    page-break-after: avoid;
  }
  table {
    width: 100%;
    max-width: 100%;
    border-collapse: collapse;
    margin: 15px 0;
    font-size: 10px;
    page-break-inside: auto;
  }
  th {
    background-color: #f8f9fa;
    color: #2c3e50;
    font-weight: 600;
    border: 1px solid #dee2e6;
    padding: 6px 8px;
    text-align: left;
  }
  td {
    border: 1px solid #dee2e6;
    padding: 6px 8px;
    vertical-align: top;
  }
  tr:nth-child(even) {
    background-color: #fdfdfd;
  }
  tr {
    page-break-inside: avoid;
    page-break-after: auto;
  }
  ul {
    padding-left: 20px;
    margin: 8px 0;
  }
  li {
    margin-bottom: 4px;
    font-size: 11px;
  }
  .alert {
    padding: 10px;
    margin: 12px 0;
    border-left: 5px solid;
    border-radius: 4px;
    background-color: #f8f9fa;
    font-size: 11px;
  }
  .alert-important {
    border-left-color: #d9534f;
    background-color: #fdf7f7;
  }
  .alert-tip {
    border-left-color: #5cb85c;
    background-color: #f4faf4;
  }
  .alert-note {
    border-left-color: #5bc0de;
    background-color: #f4fafd;
  }
  hr {
    border: 0;
    border-top: 1px solid #eee;
    margin: 25px 0;
  }
  p {
    font-size: 11px;
    margin: 6px 0;
  }
  @media print {
    body {
      font-size: 10px;
    }
    h1, h2, h3 {
      page-break-after: avoid;
    }
  }
</style>
</head>
<body>
$htmlBody
</body>
</html>
"@

Set-Content -Path $htmlPath -Value $htmlTemplate -Encoding utf8

# Print to PDF using headless Microsoft Edge
& "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --headless --disable-gpu --print-to-pdf=$pdfPath $htmlPath

Write-Host "PDF conversion complete."
