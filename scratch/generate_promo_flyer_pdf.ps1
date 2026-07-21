$htmlPath = "C:\Users\asadu\.gemini\antigravity\brain\e8179a66-1e06-4b01-aa03-b57af1713c43\promo_flyer.html"
$pdfPath = "C:\Users\asadu\.gemini\antigravity\brain\e8179a66-1e06-4b01-aa03-b57af1713c43\promo_flyer.pdf"
$tempPdfPath = "$env:TEMP\promo_flyer.pdf"

$htmlContent = @"
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Promotional Flyer - Smart Home & Security Automation</title>
<style>
  @page {
    size: A4 portrait;
    margin: 8mm;
  }
  body {
    font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, Roboto, sans-serif;
    color: #0f172a;
    line-height: 1.35;
    padding: 0;
    margin: 0;
    font-size: 10pt;
    background-color: #ffffff;
  }
  .container {
    border: 3px solid #1e3a8a;
    border-radius: 12px;
    padding: 15px;
    height: 94%;
    box-sizing: border-box;
    position: relative;
  }
  .header {
    text-align: center;
    background: linear-gradient(135deg, #1e3a8a, #3b82f6);
    color: #ffffff;
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 12px;
  }
  .header h1 {
    font-size: 22pt;
    margin: 0 0 5px 0;
    font-weight: 800;
    letter-spacing: -0.5px;
  }
  .header h2 {
    font-size: 11pt;
    margin: 0;
    font-weight: 400;
    opacity: 0.9;
  }
  .malayalam-banner {
    background: #fef08a;
    border-left: 5px solid #ca8a04;
    padding: 8px;
    text-align: center;
    font-weight: 700;
    font-size: 11.5pt;
    color: #854d0e;
    margin-bottom: 12px;
    border-radius: 4px;
  }
  .grid-2 {
    display: grid;
    grid-template-columns: 1.1fr 0.9fr;
    gap: 15px;
    margin-bottom: 12px;
  }
  .section-title {
    font-size: 12pt;
    font-weight: 700;
    color: #1e3a8a;
    margin-bottom: 6px;
    border-bottom: 2px solid #cbd5e1;
    padding-bottom: 2px;
  }
  .vision-mission {
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    border-radius: 6px;
    padding: 10px;
  }
  .vision-mission p {
    margin: 4px 0 10px 0;
    font-size: 9pt;
  }
  .vision-mission strong {
    color: #1e3a8a;
  }
  /* Stats styling */
  .stats-box {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 10px;
  }
  .stat-card {
    background: #eff6ff;
    border: 1px solid #bfdbfe;
    border-radius: 6px;
    padding: 10px;
    text-align: center;
  }
  .stat-num {
    font-size: 20pt;
    font-weight: 800;
    color: #2563eb;
    margin-bottom: 2px;
  }
  .stat-label {
    font-size: 8pt;
    color: #1e40af;
    font-weight: 600;
  }
  /* Graphical House Setup */
  .house-graphic {
    border: 1px dashed #3b82f6;
    background-color: #f0fdf4;
    border-radius: 8px;
    padding: 10px;
    margin-bottom: 12px;
  }
  .house-graphic h3 {
    margin: 0 0 8px 0;
    font-size: 11pt;
    color: #15803d;
    text-align: center;
  }
  .house-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 10px;
  }
  .house-node {
    background: #ffffff;
    border: 1px solid #bbf7d0;
    border-radius: 6px;
    padding: 8px 5px;
    text-align: center;
    font-size: 8.5pt;
  }
  .house-node span {
    font-size: 16pt;
    display: block;
    margin-bottom: 4px;
  }
  .house-node strong {
    color: #166534;
    display: block;
  }
  /* Job Opportunities */
  .jobs-box {
    background: #faf5ff;
    border: 1px solid #f3e8ff;
    border-radius: 8px;
    padding: 12px;
    margin-bottom: 12px;
  }
  .jobs-box h3 {
    margin: 0 0 8px 0;
    font-size: 11.5pt;
    color: #6b21a8;
    text-align: center;
    border-bottom: 1.5px solid #e9d5ff;
    padding-bottom: 3px;
  }
  .jobs-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 8px;
  }
  .job-card {
    background: #ffffff;
    border: 1px solid #e9d5ff;
    border-radius: 6px;
    padding: 8px 5px;
    text-align: center;
    font-size: 8.5pt;
  }
  .job-card strong {
    color: #7c3aed;
    display: block;
    margin-bottom: 3px;
  }
  .footer-promo {
    text-align: center;
    margin-top: 15px;
    font-size: 11pt;
    font-weight: 700;
    color: #1e3a8a;
  }
  .footer-promo span {
    color: #ef4444;
  }
</style>
</head>
<body>

<div class="container">
  <div class="header">
    <h1>SMART HOME & SECURITY AUTOMATION</h1>
    <h2>Low-Voltage Systems Integration & Career Certification</h2>
  </div>

  <div class="malayalam-banner">
    Bhavi Smart Aanu, Ningalum Smart Aakuka! Ini Smart Home Rangathu Thilangam.
  </div>

  <div class="grid-2">
    <!-- Left Column: Vision & Mission -->
    <div class="vision-mission">
      <div class="section-title">Our Vision & Mission</div>
      <p>
        <strong>Nammude Lakshyam (Vision):</strong><br>
        Low-Voltage, Home Automation saangethika vidyakalil mikacha praayogika pareesheelanam nalki udyogarthikale aagola nilavaramulla Systems Integrators aaki maattuka.
      </p>
      <p style="margin-bottom:0;">
        <strong>Nammude Douthyam (Mission):</strong><br>
        Verum theory classukalkku pakaram poorna-mayum lab-adhisthithamayi (100% Practical Labs) Smart Home Installation, Internet Connectivity, AI Security ennivayil vidagdharakkuka.
      </p>
    </div>

    <!-- Right Column: Stats -->
    <div>
      <div class="section-title">Industry Statistics</div>
      <div class="stats-box">
        <div class="stat-card">
          <div class="stat-num">90%</div>
          <div class="stat-label">Modern homes deploy smart tech</div>
        </div>
        <div class="stat-card">
          <div class="stat-num">3x</div>
          <div class="stat-label">Demand for low-voltage technicians</div>
        </div>
        <div class="stat-card" style="grid-column: span 2;">
          <div class="stat-num" style="color: #10b981;">100%</div>
          <div class="stat-label">Hands-on Lab Training (No written exams)</div>
        </div>
      </div>
    </div>
  </div>

  <!-- Smart Home Ecosystem (Graphical) -->
  <div class="house-graphic">
    <h3>Smart Home Automation Ecosystem</h3>
    <div class="house-grid">
      <div class="house-node">
        <span>💡</span>
        <strong>Smart Lighting</strong>
        Smart Switchukal
      </div>
      <div class="house-node">
        <span>🔒</span>
        <strong>Smart Access</strong>
        Digital Lockukal
      </div>
      <div class="house-node">
        <span>👁️</span>
        <strong>AI CCTV Security</strong>
        Face Recognition
      </div>
      <div class="house-node">
        <span>🌐</span>
        <strong>High-Speed LAN</strong>
        Wi-Fi & Optics
      </div>
    </div>
  </div>

  <!-- Job Opportunities -->
  <div class="jobs-box">
    <h3>Thozhil Avasarangal (Career Opportunities)</h3>
    <div class="jobs-grid">
      <div class="job-card">
        <strong>Smart Home Installer</strong>
        Smart Home Installation
      </div>
      <div class="job-card">
        <strong>CCTV Engineer</strong>
        Security Camera Installer
      </div>
      <div class="job-card">
        <strong>Network Tech</strong>
        Network Technician
      </div>
      <div class="job-card">
        <strong>Own Business</strong>
        Swayam Thozhil / Samrambhakan
      </div>
    </div>
  </div>

  <div class="footer-promo">
    Innuthane Praveshanam Nedoo! Ningalude Career <span>Smart</span> Aakkoo!<br>
    <small style="font-size: 8.5pt; font-weight: normal; color: #64748b;">Low-Voltage Systems and Security Automation training program</small>
  </div>
</div>

</body>
</html>
"@

Set-Content -Path $htmlPath -Value $htmlContent -Encoding utf8
Write-Host "Generated promo_flyer.html"

# Compile to PDF using headless Edge
$p = Start-Process -FilePath "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" -ArgumentList "--headless=new", "--no-sandbox", "--print-to-pdf=$tempPdfPath", "file:///$($htmlPath -replace '\\', '/')" -NoNewWindow -PassThru -Wait

if ($p.ExitCode -eq 0) {
    Copy-Item -Path $tempPdfPath -Destination $pdfPath -Force
    Write-Host "Promo Flyer PDF conversion completed successfully. Saved to: $pdfPath"
} else {
    Write-Host "Edge PDF conversion failed with exit code $($p.ExitCode)"
}
