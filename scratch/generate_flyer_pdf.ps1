$htmlPath = "C:\Users\asadu\.gemini\antigravity\brain\e8179a66-1e06-4b01-aa03-b57af1713c43\flyer.html"
$pdfPath = "C:\Users\asadu\.gemini\antigravity\brain\e8179a66-1e06-4b01-aa03-b57af1713c43\flyer.pdf"
$tempPdfPath = "$env:TEMP\flyer.pdf"

$htmlContent = @"
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Course Flyer & Registration Form</title>
<style>
  @page {
    size: A4 portrait;
    margin: 10mm;
  }
  body {
    font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, Roboto, sans-serif;
    color: #1e293b;
    line-height: 1.4;
    padding: 0;
    margin: 0;
    font-size: 10pt;
  }
  .header {
    text-align: center;
    border-bottom: 2px solid #0f172a;
    padding-bottom: 8px;
    margin-bottom: 12px;
  }
  .header h1 {
    font-size: 20pt;
    color: #0f172a;
    margin: 0 0 4px 0;
    font-weight: 800;
  }
  .header h2 {
    font-size: 12pt;
    color: #3b82f6;
    margin: 0;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }
  .grid-container {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 15px;
    margin-bottom: 12px;
  }
  .col h3 {
    font-size: 11pt;
    color: #0f172a;
    margin: 0 0 6px 0;
    border-bottom: 1px solid #e2e8f0;
    padding-bottom: 3px;
  }
  ul {
    margin: 0;
    padding-left: 18px;
  }
  li {
    margin-bottom: 5px;
    font-size: 9.5pt;
  }
  .highlights-box {
    background: #f8fafc;
    border: 1px solid #cbd5e1;
    border-radius: 6px;
    padding: 10px;
    margin-bottom: 12px;
  }
  .highlights-box h3 {
    margin-top: 0;
    font-size: 11pt;
    color: #0f172a;
    margin-bottom: 5px;
  }
  .highlights-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 10px;
    text-align: center;
  }
  .highlight-item {
    font-size: 8.5pt;
    padding: 5px;
    background: #ffffff;
    border: 1px solid #e2e8f0;
    border-radius: 4px;
  }
  .highlight-item strong {
    color: #3b82f6;
    display: block;
    margin-bottom: 2px;
  }
  table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 15px;
    font-size: 8.5pt;
  }
  th {
    background-color: #0f172a;
    color: #ffffff;
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
  .form-section {
    border: 1.5px dashed #475569;
    border-radius: 6px;
    padding: 12px;
    background: #fafafa;
    margin-top: 10px;
  }
  .form-title {
    font-size: 11pt;
    font-weight: 700;
    color: #0f172a;
    margin-bottom: 8px;
    text-align: center;
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }
  .form-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 8px 15px;
  }
  .form-field {
    display: flex;
    align-items: center;
    font-size: 9pt;
  }
  .form-field label {
    font-weight: 600;
    margin-right: 5px;
    width: 110px;
  }
  .form-field .line {
    flex-grow: 1;
    border-bottom: 1px solid #475569;
    height: 15px;
  }
  .form-footer {
    display: flex;
    justify-content: space-between;
    margin-top: 12px;
    font-size: 9pt;
  }
  .sign-line {
    width: 180px;
    border-top: 1px solid #475569;
    text-align: center;
    margin-top: 20px;
    font-size: 8pt;
  }
</style>
</head>
<body>

<div class="header">
  <h1>Security, Automation, & Low-Voltage Systems</h1>
  <h2>Professional System Integrator Program</h2>
</div>

<div class="highlights-box">
  <h3>Key Course Highlights</h3>
  <div class="highlights-grid">
    <div class="highlight-item">
      <strong>28 Days</strong>
      Hands-on Practical Labs
    </div>
    <div class="highlight-item">
      <strong>AI-Focused</strong>
      Smart Cameras & Analytics
    </div>
    <div class="highlight-item">
      <strong>Inherently Safe</strong>
      Low-Voltage DC Circuits
    </div>
    <div class="highlight-item">
      <strong>Job Ready</strong>
      System Integrator Skills
    </div>
  </div>
</div>

<div class="grid-container">
  <div class="col">
    <h3>Module 1: Electrical & Networking</h3>
    <ul>
      <li><b>AC/DC Basics:</b> Wire staircase loops & switch boards.</li>
      <li><b>Safety Systems:</b> Audit MCB, RCCB & SPD surge protection.</li>
      <li><b>IP Networks:</b> Configure routers, VLAN segmentation, and subnets.</li>
      <li><b>PoE & Fiber:</b> Power cameras over Ethernet and deploy SFP fiber-optics.</li>
    </ul>
  </div>
  <div class="col">
    <h3>Module 2: Professional CCTV Systems</h3>
    <ul>
      <li><b>System Design:</b> Mount dome/bullet cameras, select lenses & calculate FOV.</li>
      <li><b>AI Analytics:</b> Program face recognition, whitelists & tripwires.</li>
      <li><b>NVR & RAID:</b> Set storage schedules and rebuild RAID 5 arrays.</li>
      <li><b>Cybersecurity:</b> Encrypt streams, disable UPnP & secure default ports.</li>
    </ul>
  </div>
</div>

<h3>Syllabus Schedule Summary</h3>
<table>
  <thead>
    <tr>
      <th style="width: 15%;">Phase</th>
      <th style="width: 45%;">Core Hands-on Competency</th>
      <th style="width: 40%;">Earning & Career Prospects</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>Week 1</b></td>
      <td>Basic circuit wiring, earthing checks, DMM troubleshooting, and wire LOTO safety.</td>
      <td>Electrician apprentice, wiring technician.</td>
    </tr>
    <tr style="background: #f8fafc;">
      <td><b>Week 2</b></td>
      <td>Cat6 RJ45/RJ11 crimping, switch port configuration, static IP routing, and VLAN setup.</td>
      <td>Network installer, IT support assistant.</td>
    </tr>
    <tr>
      <td><b>Week 3</b></td>
      <td>Coaxial BNC wiring, NVR drive mounting, RAID storage design, and camera mounting.</td>
      <td>CCTV installer, security technician.</td>
    </tr>
    <tr style="background: #f8fafc;">
      <td><b>Week 4</b></td>
      <td>AI event configurations, face databases, ANPR barrier loops, and network cyber-hardening.</td>
      <td>Security systems engineer, freelance systems integrator.</td>
    </tr>
  </tbody>
</table>

<div class="form-section">
  <div class="form-title">Student Enrollment & Registration Form</div>
  <div class="form-grid">
    <div class="form-field"><label>Student Name:</label><div class="line"></div></div>
    <div class="form-field"><label>Parent/Guardian Name:</label><div class="line"></div></div>
    <div class="form-field"><label>Contact Number:</label><div class="line"></div></div>
    <div class="form-field"><label>Email Address:</label><div class="line"></div></div>
    <div class="form-field">
      <label>Preferred Batch:</label>
      <div style="font-size: 8.5pt;">[ ] Morning (9 AM - 12 PM) &nbsp;&nbsp;&nbsp;&nbsp; [ ] Evening (4 PM - 7 PM)</div>
    </div>
    <div class="form-field"><label>Educational Qualification:</label><div class="line"></div></div>
  </div>
  <div class="form-footer">
    <div class="sign-line">Parent/Guardian Signature</div>
    <div class="sign-line" style="width: 120px;">Date</div>
    <div class="sign-line">Student Signature</div>
  </div>
</div>

</body>
</html>
"@

Set-Content -Path $htmlPath -Value $htmlContent -Encoding utf8
Write-Host "Generated flyer.html"

# Compile to PDF using headless Edge
$p = Start-Process -FilePath "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" -ArgumentList "--headless=new", "--no-sandbox", "--print-to-pdf=$tempPdfPath", "file:///$($htmlPath -replace '\\', '/')" -NoNewWindow -PassThru -Wait

if ($p.ExitCode -eq 0) {
    Copy-Item -Path $tempPdfPath -Destination $pdfPath -Force
    Write-Host "Flyer PDF conversion completed successfully. Saved to: $pdfPath"
} else {
    Write-Host "Edge PDF conversion failed with exit code $($p.ExitCode)"
}
