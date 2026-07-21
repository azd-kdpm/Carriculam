$outputDir = "c:\Users\asadu\Downloads\Quick Share\BotGI\slides"
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir -Force
}

$template = @"
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Session {session_num}: {session_title}</title>
<style>
  :root {
    --bg-color: #080c14;
    --card-bg: rgba(15, 25, 45, 0.6);
    --accent-color: {accent_color};
    --accent-glow: {accent_glow};
    --text-main: #f3f4f6;
    --text-muted: #9ca3af;
    --border-color: rgba(255, 255, 255, 0.08);
  }

  * {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
  }

  body {
    background-color: var(--bg-color);
    color: var(--text-main);
    font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, Roboto, sans-serif;
    overflow: hidden;
    height: 100vh;
    width: 100vw;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    touch-action: pan-y;
  }

  .deck {
    flex-grow: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    padding: 30px;
    touch-action: pan-y;
  }

  .slide {
    width: 100%;
    max-width: 1200px;
    height: 100%;
    max-height: 700px;
    background: var(--card-bg);
    border: 1px solid var(--border-color);
    border-radius: 16px;
    backdrop-filter: blur(12px);
    padding: 40px;
    display: none;
    flex-direction: column;
    justify-content: flex-start;
    position: relative;
    box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3);
    animation: fadeIn 0.4s ease;
    touch-action: pan-y;
  }

  .slide.active {
    display: flex;
  }

  .slide-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    border-bottom: 1px solid var(--border-color);
    padding-bottom: 15px;
  }

  .slide-tag {
    background: rgba(255, 255, 255, 0.05);
    color: var(--accent-color);
    font-weight: 700;
    font-size: 11px;
    padding: 4px 10px;
    border-radius: 20px;
    text-transform: uppercase;
    letter-spacing: 1px;
    border: 1px solid var(--accent-color);
  }

  .slide-title {
    font-size: 28px;
    font-weight: 700;
    color: #ffffff;
    margin-bottom: 15px;
  }

  .slide-body {
    display: grid;
    grid-template-columns: 1.2fr 0.8fr;
    gap: 30px;
    font-size: 17px;
    line-height: 1.5;
    color: var(--text-main);
    flex-grow: 1;
    overflow: hidden;
  }

  .text-content {
    overflow-y: auto;
    padding-right: 10px;
  }

  .visual-content {
    display: flex;
    align-items: center;
    justify-content: center;
    background: rgba(0, 0, 0, 0.2);
    border: 1px solid var(--border-color);
    border-radius: 12px;
    padding: 20px;
    position: relative;
    overflow: hidden;
  }

  .visual-content svg {
    max-width: 100%;
    max-height: 100%;
  }

  ul, ol {
    margin-left: 20px;
    margin-bottom: 15px;
  }

  li {
    margin-bottom: 10px;
  }

  li strong {
    color: var(--accent-color);
  }

  .highlight-block {
    background: rgba(255, 255, 255, 0.02);
    border-left: 4px solid var(--accent-color);
    padding: 12px;
    border-radius: 0 8px 8px 0;
    margin: 15px 0;
    font-style: italic;
    font-size: 15px;
  }

  .lab-block {
    background: rgba(16, 185, 129, 0.08);
    border: 1px solid rgba(16, 185, 129, 0.3);
    border-left: 4px solid #10b981;
    padding: 15px;
    border-radius: 8px;
    margin: 15px 0;
  }

  .lab-block h3 {
    color: #10b981;
    font-size: 18px;
    margin-bottom: 8px;
  }

  table {
    width: 100%;
    border-collapse: collapse;
    margin: 15px 0;
    font-size: 13px;
  }

  th {
    background-color: rgba(255, 255, 255, 0.03);
    color: var(--accent-color);
    border: 1px solid var(--border-color);
    padding: 6px;
    text-align: left;
  }

  td {
    border: 1px solid var(--border-color);
    padding: 6px;
  }

  .controls-bar {
    height: 60px;
    background: rgba(15, 22, 40, 0.8);
    border-top: 1px solid var(--border-color);
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 40px;
    z-index: 100;
  }

  .nav-buttons {
    display: flex;
    gap: 15px;
  }

  .btn {
    background: rgba(255, 255, 255, 0.05);
    border: 1px solid var(--border-color);
    color: var(--text-main);
    padding: 6px 12px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 600;
    transition: all 0.2s ease;
  }

  .btn:hover {
    background: var(--accent-color);
    border-color: var(--accent-color);
    box-shadow: 0 0 10px var(--accent-glow);
  }

  .btn:disabled {
    opacity: 0.3;
    cursor: not-allowed;
    background: transparent;
  }

  .slide-counter {
    font-size: 13px;
    color: var(--text-muted);
  }

  .progress-container {
    width: 100%;
    height: 4px;
    background: rgba(255, 255, 255, 0.05);
    position: absolute;
    bottom: 0;
    left: 0;
  }

  .progress-bar {
    height: 100%;
    background: var(--accent-color);
    width: 0%;
    transition: width 0.3s ease;
  }

  @keyframes fadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
  }

  .title-slide {
    justify-content: center;
    align-items: center;
    text-align: center;
  }

  .title-slide h1 {
    font-size: 42px;
    font-weight: 800;
    color: #ffffff;
    margin-bottom: 15px;
  }

  .title-slide h2 {
    font-size: 18px;
    color: var(--text-muted);
    font-weight: 500;
    margin-bottom: 30px;
  }

  /* Force landscape rotation on mobile portrait screen sizes only (excluding tablets/fold displays) */
  @media (orientation: portrait) and (max-width: 500px) {
    body {
      transform: rotate(90deg);
      transform-origin: top left;
      width: 100vh !important;
      height: 100vw !important;
      position: absolute;
      top: 0;
      left: 100%;
      overflow: hidden;
    }
  }
</style>
</head>
<body>

<div class="deck">
{slides_html}
</div>

<div class="controls-bar">
  <div class="nav-buttons">
    <a class="btn" href="slides_index.html" style="text-decoration:none;">Back to Hub</a>
    <button class="btn" id="prevBtn" disabled>Previous</button>
    <button class="btn" id="nextBtn">Next</button>
  </div>
  <button class="btn" id="fullscreenBtn">Fullscreen</button>
</div>

<div class="progress-container">
  <div class="progress-bar" id="progressBar"></div>
</div>

<script>
  const slides = document.querySelectorAll('.slide');
  const prevBtn = document.getElementById('prevBtn');
  const nextBtn = document.getElementById('nextBtn');
  const progressBar = document.getElementById('progressBar');
  const fullscreenBtn = document.getElementById('fullscreenBtn');
  let currentSlide = 0;

  function updateSlides() {
    slides.forEach((slide, index) => {
      if (index === currentSlide) {
        slide.classList.add('active');
      } else {
        slide.classList.remove('active');
      }
    });

    prevBtn.disabled = false;
    nextBtn.disabled = false;
    
    if (currentSlide === 0) {
      prevBtn.textContent = "Exit";
    } else {
      prevBtn.textContent = "Previous";
    }
    
    if (currentSlide === slides.length - 1) {
      nextBtn.textContent = "Finish";
    } else {
      nextBtn.textContent = "Next";
    }

    const progress = (currentSlide / (slides.length - 1)) * 100;
    progressBar.style.width = progress + "%";
  }

  prevBtn.addEventListener('click', () => {
    if (currentSlide > 0) {
      currentSlide--;
      updateSlides();
    } else {
      window.location.href = 'slides_index.html';
    }
  });

  nextBtn.addEventListener('click', () => {
    if (currentSlide < slides.length - 1) {
      currentSlide++;
      updateSlides();
    } else {
      window.location.href = 'slides_index.html';
    }
  });

  document.addEventListener('keydown', (e) => {
    if (e.key === 'ArrowRight' || e.key === ' ' || e.key === 'PageDown') {
      if (currentSlide < slides.length - 1) {
        currentSlide++;
        updateSlides();
      } else {
        window.location.href = 'slides_index.html';
      }
    } else if (e.key === 'ArrowLeft' || e.key === 'PageUp') {
      if (currentSlide > 0) {
        currentSlide--;
        updateSlides();
      } else {
        window.location.href = 'slides_index.html';
      }
    }
  });

  // Global Document-level Touch Swipe Support
  let touchStartX = 0;
  let touchStartY = 0;
  let touchEndX = 0;
  let touchEndY = 0;
  
  document.addEventListener('touchstart', e => {
    touchStartX = e.changedTouches[0].screenX;
    touchStartY = e.changedTouches[0].screenY;
  }, {passive: true});

  document.addEventListener('touchend', e => {
    touchEndX = e.changedTouches[0].screenX;
    touchEndY = e.changedTouches[0].screenY;
    handleSwipeGesture();
  }, {passive: true});

  function handleSwipeGesture() {
    const swipeThreshold = 50;
    const diffX = touchStartX - touchEndX;
    const diffY = touchStartY - touchEndY;
    
    // Check if the screen is physically vertical (portrait) but rotated to landscape layout
    const isRotated = (window.innerHeight > window.innerWidth) && (window.innerWidth <= 500);
    
    if (isRotated) {
      // In rotated mode, vertical gestures (up/down) correspond to slide progression (left/right)
      if (Math.abs(diffY) > Math.abs(diffX) && Math.abs(diffY) > swipeThreshold) {
        if (diffY > 0) {
          // Swipe Up -> Next
          if (currentSlide < slides.length - 1) {
            currentSlide++;
            updateSlides();
          } else {
            window.location.href = 'slides_index.html';
          }
        } else {
          // Swipe Down -> Prev
          if (currentSlide > 0) {
            currentSlide--;
            updateSlides();
          } else {
            window.location.href = 'slides_index.html';
          }
        }
      }
    } else {
      // Normal horizontal swiping on tablets, folds, or landscape devices
      if (Math.abs(diffX) > Math.abs(diffY) && Math.abs(diffX) > swipeThreshold) {
        if (diffX > 0) {
          // Swipe Left -> Next
          if (currentSlide < slides.length - 1) {
            currentSlide++;
            updateSlides();
          } else {
            window.location.href = 'slides_index.html';
          }
        } else {
          // Swipe Right -> Prev
          if (currentSlide > 0) {
            currentSlide--;
            updateSlides();
          } else {
            window.location.href = 'slides_index.html';
          }
        }
      }
    }
  }

  fullscreenBtn.addEventListener('click', () => {
    if (!document.fullscreenElement) {
      document.documentElement.requestFullscreen().catch(err => {
        alert("Error enabling fullscreen: " + err.message);
      });
    } else {
      document.exitFullscreen();
    }
  });

  // Track session and module in localStorage for index back navigation
  const pageName = window.location.pathname.split('/').pop();
  localStorage.setItem('lastViewedSession', pageName);
  localStorage.setItem('lastViewedModule', 'm2');
</script>
</body>
</html>
"@

function Get-DiagramSvg([string]$type) {
    switch ($type) {
        # Session 14
        "coax_structure" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <!-- Outer sheath -->
  <rect x="15" y="45" width="170" height="40" fill="#4b5563" rx="4"/>
  <!-- Copper shield -->
  <rect x="55" y="50" width="115" height="30" fill="#f59e0b"/>
  <!-- Dielectric insulator -->
  <rect x="95" y="55" width="60" height="20" fill="#f3f4f6"/>
  <!-- Center Core -->
  <rect x="135" y="62" width="50" height="6" fill="#f97316"/>
  <text x="100" y="125" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">RG59 Coaxial Core Layers</text>
</svg>
"@
        }
        "cat6_structure" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="70" r="45" fill="none" stroke="#4b5563" stroke-width="2"/>
  <!-- Spline center divider -->
  <line x1="100" y1="25" x2="100" y2="115" stroke="#9ca3af" stroke-width="2"/>
  <line x1="55" y1="70" x2="145" y2="70" stroke="#9ca3af" stroke-width="2"/>
  <!-- Twisted pairs circles -->
  <circle cx="75" cy="45" r="8" fill="#f97316"/>
  <circle cx="125" cy="45" r="8" fill="#22c55e"/>
  <circle cx="75" cy="95" r="8" fill="#3b82f6"/>
  <circle cx="125" cy="95" r="8" fill="#854d0e"/>
  <text x="100" y="138" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Cat6 Twisted Pair Architecture</text>
</svg>
"@
        }
        "latency_chart" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <line x1="30" y1="15" x2="30" y2="120" stroke="#4b5563" stroke-width="1.5"/>
  <line x1="30" y1="120" x2="190" y2="120" stroke="#4b5563" stroke-width="1.5"/>
  <rect x="45" y="40" width="40" height="80" fill="#10b981"/>
  <text x="65" y="32" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">Analog (0ms)</text>
  <rect x="115" y="90" width="40" height="30" fill="#ef4444"/>
  <text x="135" y="82" fill="#ef4444" font-family="sans-serif" font-size="8" text-anchor="middle">IP (150ms)</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="10" text-anchor="middle">Direct vs Encoded Network Lag</text>
</svg>
"@
        }
        "hdtvi_signal" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <line x1="15" y1="75" x2="185" y2="75" stroke="#4b5563" stroke-width="1.5"/>
  <!-- High frequency carrier sine wave with small steps -->
  <path d="M 15 75 Q 35 30 55 75 T 95 75 T 135 75 T 175 75" fill="none" stroke="#f59e0b" stroke-width="2"/>
  <rect x="75" y="65" width="20" height="20" fill="#ef4444" opacity="0.8"/>
  <text x="85" y="60" fill="#ef4444" font-family="sans-serif" font-size="8" text-anchor="middle">Data</text>
  <text x="100" y="130" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">HD-TVI High-Freq Carrier</text>
</svg>
"@
        }
        "balun_circuit" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="75" y="45" width="50" height="50" rx="3" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <path d="M 85 55 C 95 55, 95 65, 85 65 C 95 65, 95 75, 85 75 C 95 75, 95 85, 85 85" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <line x1="25" y1="70" x2="75" y2="70" stroke="#f59e0b" stroke-width="2"/>
  <line x1="125" y1="60" x2="175" y2="60" stroke="#10b981" stroke-width="2"/>
  <line x1="125" y1="80" x2="175" y2="80" stroke="#10b981" stroke-width="2"/>
  <text x="50" y="60" fill="#f59e0b" font-family="sans-serif" font-size="8" text-anchor="middle">75Ω</text>
  <text x="150" y="50" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">100Ω</text>
  <text x="100" y="130" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Balun Matching Transformer</text>
</svg>
"@
        }
        "coax_loss" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <line x1="30" y1="20" x2="30" y2="120" stroke="#4b5563" stroke-width="1.5"/>
  <line x1="30" y1="120" x2="190" y2="120" stroke="#4b5563" stroke-width="1.5"/>
  <path d="M 30 30 Q 90 40 180 110" fill="none" stroke="#ef4444" stroke-width="2.5"/>
  <text x="110" y="55" fill="#ef4444" font-family="sans-serif" font-size="9">Coax Attenuation</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Signal Loss vs Run Length</text>
</svg>
"@
        }
        "ethernet_injector" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="15" y="45" width="40" height="40" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <text x="35" y="68" fill="#3b82f6" font-family="sans-serif" font-size="8" text-anchor="middle">Switch</text>
  <rect x="80" y="45" width="40" height="40" fill="none" stroke="#ef4444" stroke-width="2"/>
  <text x="100" y="68" fill="#ef4444" font-family="sans-serif" font-size="8" text-anchor="middle">PoE Inj</text>
  <rect x="145" y="45" width="40" height="40" fill="none" stroke="#10b981" stroke-width="2"/>
  <text x="165" y="68" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">Camera</text>
  <line x1="55" y1="65" x2="80" y2="65" stroke="#9ca3af" stroke-width="1.5"/>
  <line x1="120" y1="65" x2="145" y2="65" stroke="#10b981" stroke-width="2"/>
  <text x="100" y="130" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">100m Active Link Topology</text>
</svg>
"@
        }
        "xvr_hybrid" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="20" y="35" width="160" height="80" fill="none" stroke="#4b5563" stroke-width="2"/>
  <!-- Analog inputs -->
  <circle cx="45" cy="60" r="6" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <circle cx="75" cy="60" r="6" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <!-- IP ports -->
  <rect x="120" y="50" width="16" height="16" fill="none" stroke="#10b981" stroke-width="2"/>
  <rect x="145" y="50" width="16" height="16" fill="none" stroke="#10b981" stroke-width="2"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">XVR Rear Port Layout</text>
</svg>
"@
        }
        "analog_ip_lab" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="30" y="25" width="140" height="95" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <line x1="30" y1="72" x2="170" y2="72" stroke="#ef4444" stroke-width="2"/>
  <text x="100" y="65" fill="#ef4444" font-family="sans-serif" font-size="9" text-anchor="middle">Cable Run</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Bench Test Layout</text>
</svg>
"@
        }

        # Session 15
        "dome_profile" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <path d="M 40 85 A 60 60 0 0 1 160 85 Z" fill="none" stroke="#3b82f6" stroke-width="3"/>
  <rect x="35" y="85" width="130" height="10" fill="#3b82f6" rx="2"/>
  <circle cx="100" cy="55" r="15" fill="#9ca3af" opacity="0.6"/>
  <text x="100" y="130" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Vandal-Proof IK10 Housing</text>
</svg>
"@
        }
        "bullet_profile" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="45" y="45" width="90" height="40" rx="3" fill="none" stroke="#10b981" stroke-width="3"/>
  <!-- Bracket pivot -->
  <line x1="70" y1="85" x2="70" y2="120" stroke="#10b981" stroke-width="3"/>
  <!-- Sun visor cover -->
  <path d="M 40 40 L 140 40 L 125 45 L 45 45 Z" fill="#9ca3af"/>
  <text x="100" y="140" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">IP67 Waterproof Bullet</text>
</svg>
"@
        }
        "turret_profile" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="70" r="40" fill="none" stroke="#f59e0b" stroke-width="3"/>
  <!-- Ring separating IR and Lens -->
  <circle cx="100" cy="70" r="18" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <circle cx="100" cy="70" r="5" fill="#ef4444"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Dual-Pane Turret Eyeball</text>
</svg>
"@
        }
        "lux_scale" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <line x1="30" y1="75" x2="170" y2="75" stroke="#9ca3af" stroke-width="2"/>
  <circle cx="40" cy="75" r="5" fill="#ef4444"/>
  <circle cx="100" cy="75" r="5" fill="#3b82f6"/>
  <circle cx="160" cy="75" r="5" fill="#10b981"/>
  <text x="40" y="60" fill="#ef4444" font-family="sans-serif" font-size="8" text-anchor="middle">0.01 Lux</text>
  <text x="100" y="60" fill="#3b82f6" font-family="sans-serif" font-size="8" text-anchor="middle">10 Lux</text>
  <text x="160" y="60" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">10k Lux</text>
  <text x="100" y="130" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Sensor Lux Sensitivity Scale</text>
</svg>
"@
        }
        "wdr_comparison" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <!-- Off WDR -->
  <rect x="20" y="35" width="70" height="70" fill="#1f2937" stroke="#ef4444" stroke-width="2"/>
  <rect x="55" y="45" width="20" height="50" fill="#ffffff" opacity="0.9"/>
  <rect x="25" y="45" width="20" height="50" fill="#000000"/>
  <text x="55" y="120" fill="#ef4444" font-family="sans-serif" font-size="8" text-anchor="middle">WDR OFF</text>
  <!-- On WDR -->
  <rect x="110" y="35" width="70" height="70" fill="#6b7280" stroke="#10b981" stroke-width="2"/>
  <rect x="115" y="45" width="60" height="50" fill="none" stroke="#f59e0b" stroke-width="1.5"/>
  <text x="145" y="120" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">True WDR ON</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">High Contrast Calibration</text>
</svg>
"@
        }
        "smart_ir_action" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="60" cy="70" r="25" fill="#f59e0b" opacity="0.9"/>
  <text x="60" y="115" fill="#ef4444" font-family="sans-serif" font-size="8" text-anchor="middle">Standard IR Washout</text>
  <circle cx="140" cy="70" r="25" fill="#3b82f6" opacity="0.3"/>
  <text x="140" y="115" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">Smart IR Dimming</text>
  <text x="100" y="138" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Smart IR Face Overexposure Fix</text>
</svg>
"@
        }
        "dori_ranges" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <line x1="20" y1="75" x2="180" y2="75" stroke="#9ca3af" stroke-width="3"/>
  <rect x="30" y="65" width="30" height="20" fill="#ef4444"/>
  <text x="45" y="55" fill="#ef4444" font-family="sans-serif" font-size="8" text-anchor="middle">Identify</text>
  <rect x="80" y="65" width="40" height="20" fill="#f59e0b"/>
  <text x="100" y="55" fill="#f59e0b" font-family="sans-serif" font-size="8" text-anchor="middle">Recognize</text>
  <rect x="140" y="65" width="30" height="20" fill="#10b981"/>
  <text x="155" y="55" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">Detect</text>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">DORI Target Zone Limits</text>
</svg>
"@
        }
        "camera_mount_types" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <line x1="30" y1="20" x2="30" y2="130" stroke="#4b5563" stroke-width="4"/>
  <rect x="30" y="45" width="35" height="20" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <text x="80" y="58" fill="#3b82f6" font-family="sans-serif" font-size="8">Wall Arm</text>
  <circle cx="30" cy="100" r="10" fill="none" stroke="#10b981" stroke-width="2"/>
  <text x="80" y="104" fill="#10b981" font-family="sans-serif" font-size="8">Pole Clamp</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Structural Adapter Hardware</text>
</svg>
"@
        }
        "camera_design_lab" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="25" width="150" height="95" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Completed Mount Design</text>
</svg>
"@
        }

        # Session 16
        "focal_point" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <path d="M 60 25 C 80 25, 80 125, 60 125 C 40 125, 40 25, 60 25 Z" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <!-- Light rays merging -->
  <line x1="15" y1="40" x2="52" y2="40" stroke="#ef4444" stroke-width="1.5"/>
  <line x1="15" y1="110" x2="52" y2="110" stroke="#ef4444" stroke-width="1.5"/>
  <line x1="58" y1="40" x2="160" y2="75" stroke="#ef4444" stroke-width="1.5"/>
  <line x1="58" y1="110" x2="160" y2="75" stroke="#ef4444" stroke-width="1.5"/>
  <rect x="160" y="55" width="5" height="40" fill="#10b981"/>
  <text x="100" y="140" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Lens Optical Focal Point</text>
</svg>
"@
        }
        "aperture_comparison" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="60" cy="70" r="30" fill="none" stroke="#f59e0b" stroke-width="2"/>
  <circle cx="60" cy="70" r="22" fill="#f59e0b"/>
  <text x="60" y="120" fill="#f59e0b" font-family="sans-serif" font-size="9" text-anchor="middle">f/1.2 Wide Open</text>
  <circle cx="140" cy="70" r="30" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <circle cx="140" cy="70" r="6" fill="#3b82f6"/>
  <text x="140" y="120" fill="#3b82f6" font-family="sans-serif" font-size="9" text-anchor="middle">f/8.0 Narrow</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Aperture Size Light Intake</text>
</svg>
"@
        }
        "fixed_vs_varifocal" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="35" width="60" height="50" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <line x1="55" y1="35" x2="55" y2="85" stroke="#3b82f6" stroke-width="2"/>
  <text x="55" y="110" fill="#3b82f6" font-family="sans-serif" font-size="8" text-anchor="middle">Fixed</text>
  <rect x="115" y="35" width="60" height="50" fill="none" stroke="#10b981" stroke-width="2"/>
  <line x1="130" y1="35" x2="130" y2="85" stroke="#10b981" stroke-width="2" stroke-dasharray="3 3"/>
  <line x1="160" y1="35" x2="160" y2="85" stroke="#10b981" stroke-width="2" stroke-dasharray="3 3"/>
  <text x="145" y="110" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">Sliding Varifocal</text>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Lens Optical Elements Adjustment</text>
</svg>
"@
        }
        "motorized_zoom_gears" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="70" r="40" fill="none" stroke="#9ca3af" stroke-width="4" stroke-dasharray="8 4"/>
  <circle cx="100" cy="70" r="28" fill="none" stroke="#ef4444" stroke-width="3"/>
  <rect x="135" y="65" width="15" height="10" fill="#3b82f6"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Microstepper Servo Zoom Gears</text>
</svg>
"@
        }
        "fov_angles" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="20" cy="75" r="8" fill="#9ca3af"/>
  <!-- Angles cones overlay -->
  <polygon points="20,75 180,10 180,140" fill="rgba(59, 130, 246, 0.15)" stroke="#3b82f6"/>
  <polygon points="20,75 180,45 180,105" fill="rgba(16, 185, 129, 0.15)" stroke="#10b981"/>
  <text x="160" y="30" fill="#3b82f6" font-family="sans-serif" font-size="8">2.8mm (100°)</text>
  <text x="160" y="60" fill="#10b981" font-family="sans-serif" font-size="8">4mm (80°)</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Focal Length Angle cones</text>
</svg>
"@
        }
        "optical_vs_digital" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="35" width="60" height="60" fill="none" stroke="#10b981" stroke-width="2"/>
  <text x="55" y="115" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">Optical (Sharp)</text>
  <rect x="115" y="35" width="60" height="60" fill="none" stroke="#ef4444" stroke-width="2" stroke-dasharray="3 3"/>
  <text x="145" y="115" fill="#ef4444" font-family="sans-serif" font-size="8" text-anchor="middle">Digital (Pixelated)</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Magnification Comparison</text>
</svg>
"@
        }
        "depth_of_field" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <!-- Sharp middle target, blurred edges -->
  <circle cx="100" cy="70" r="20" fill="#10b981"/>
  <circle cx="40" cy="70" r="15" fill="#ef4444" opacity="0.3"/>
  <circle cx="160" cy="70" r="15" fill="#ef4444" opacity="0.3"/>
  <text x="100" y="130" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Focus Depth of Field Plane</text>
</svg>
"@
        }
        "fov_calculator_ui" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="25" width="150" height="95" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <line x1="25" y1="50" x2="175" y2="50" stroke="#4b5563"/>
  <text x="100" y="80" fill="#10b981" font-family="sans-serif" font-size="9" text-anchor="middle">Focal Tool Design Workspace</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Lens Calculation Utility Layout</text>
</svg>
"@
        }
        "lens_fov_lab" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="30" y="30" width="140" height="85" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Completed Field Verification</text>
</svg>
"@
        }

        # Session 17
        "dvr_block_diagram" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="15" y="55" width="30" height="30" fill="none" stroke="#3b82f6" stroke-width="1.5"/>
  <rect x="65" y="55" width="30" height="30" fill="none" stroke="#f59e0b" stroke-width="1.5"/>
  <rect x="115" y="55" width="30" height="30" fill="none" stroke="#10b981" stroke-width="1.5"/>
  <line x1="45" y1="70" x2="65" y2="70" stroke="#f3f4f6" stroke-width="1.5"/>
  <line x1="95" y1="70" x2="115" y2="70" stroke="#f3f4f6" stroke-width="1.5"/>
  <text x="30" y="110" fill="#3b82f6" font-family="sans-serif" font-size="8" text-anchor="middle">BNC</text>
  <text x="80" y="110" fill="#f59e0b" font-family="sans-serif" font-size="8" text-anchor="middle">ADC</text>
  <text x="130" y="110" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">HDD</text>
  <text x="100" y="138" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Analog DVR Codec Engine</text>
</svg>
"@
        }
        "nvr_block_diagram" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="15" y="55" width="30" height="30" fill="none" stroke="#10b981" stroke-width="1.5"/>
  <rect x="65" y="55" width="30" height="30" fill="none" stroke="#3b82f6" stroke-width="1.5"/>
  <rect x="115" y="55" width="30" height="30" fill="none" stroke="#10b981" stroke-width="1.5"/>
  <line x1="45" y1="70" x2="65" y2="70" stroke="#f3f4f6" stroke-width="1.5"/>
  <line x1="95" y1="70" x2="115" y2="70" stroke="#f3f4f6" stroke-width="1.5"/>
  <text x="30" y="110" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">PoE RJ45</text>
  <text x="80" y="110" fill="#3b82f6" font-family="sans-serif" font-size="8" text-anchor="middle">Switch</text>
  <text x="130" y="110" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">HDD</text>
  <text x="100" y="138" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">IP Network NVR Bus Routing</text>
</svg>
"@
        }
        "xvr_block" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="30" y="45" width="140" height="50" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <line x1="100" y1="45" x2="100" y2="95" stroke="#4b5563"/>
  <text x="65" y="75" fill="#3b82f6" font-family="sans-serif" font-size="9" text-anchor="middle">Analog Channels</text>
  <text x="135" y="75" fill="#10b981" font-family="sans-serif" font-size="9" text-anchor="middle">IP Channels</text>
  <text x="100" y="130" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Hybrid XVR Stream Management</text>
</svg>
"@
        }
        "sata_connector" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="55" width="60" height="20" rx="1" fill="#1f2937" stroke="#3b82f6" stroke-width="2"/>
  <text x="55" y="45" fill="#3b82f6" font-family="monospace" font-size="7" text-anchor="middle">7-Pin DATA</text>
  <rect x="110" y="55" width="65" height="20" rx="1" fill="#1f2937" stroke="#ef4444" stroke-width="2"/>
  <text x="142" y="45" fill="#ef4444" font-family="monospace" font-size="7" text-anchor="middle">15-Pin POWER</text>
  <text x="100" y="130" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">SATA Drive Backplane Connectors</text>
</svg>
"@
        }
        "storage_factors" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="70" r="40" fill="none" stroke="#f59e0b" stroke-width="2"/>
  <line x1="100" y1="30" x2="100" y2="110" stroke="#f59e0b" stroke-width="1.5"/>
  <line x1="60" y1="70" x2="140" y2="70" stroke="#f59e0b" stroke-width="1.5"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Key Variables in Storage Calculators</text>
</svg>
"@
        }
        "thermal_cooling" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="45" y="30" width="110" height="85" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <!-- Fan blades representation -->
  <circle cx="100" cy="72" r="22" fill="none" stroke="#ef4444" stroke-width="2" stroke-dasharray="10 5"/>
  <path d="M 65 72 L 45 72" stroke="#3b82f6" stroke-width="3"/>
  <path d="M 135 72 L 155 72" stroke="#ef4444" stroke-width="3"/>
  <text x="100" y="138" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Recorder Enclosure Heat Dissipation</text>
</svg>
"@
        }
        "poe_budget_bar" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="45" width="150" height="30" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <rect x="26" y="46" width="110" height="28" fill="#ef4444"/>
  <text x="80" y="65" fill="#ffffff" font-family="sans-serif" font-weight="bold" font-size="9" text-anchor="middle">96W Active</text>
  <text x="155" y="65" fill="#10b981" font-family="sans-serif" font-weight="bold" font-size="9" text-anchor="middle">24W Free</text>
  <text x="100" y="130" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Switch PoE Wattage Budget Bar</text>
</svg>
"@
        }
        "nvr_schedules" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="25" width="150" height="95" fill="none" stroke="#4b5563" stroke-width="2"/>
  <rect x="35" y="40" width="130" height="20" fill="#10b981"/>
  <rect x="35" y="75" width="130" height="20" fill="#f59e0b"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Constant vs Smart Event Timelines</text>
</svg>
"@
        }
        "hdd_install_lab" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="35" y="35" width="130" height="80" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Completed Mount Layout</text>
</svg>
"@
        }

        # Session 18
        "raid0_striping" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="45" width="60" height="55" rx="3" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <rect x="30" y="55" width="20" height="12" fill="#3b82f6"/>
  <rect x="30" y="75" width="20" height="12" fill="#3b82f6"/>
  <text x="55" y="120" fill="#3b82f6" font-family="sans-serif" font-size="8" text-anchor="middle">Disk 0 (A1, A3)</text>
  <rect x="115" y="45" width="60" height="55" rx="3" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <rect x="120" y="55" width="20" height="12" fill="#3b82f6"/>
  <rect x="120" y="75" width="20" height="12" fill="#3b82f6"/>
  <text x="145" y="120" fill="#3b82f6" font-family="sans-serif" font-size="8" text-anchor="middle">Disk 1 (A2, A4)</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">RAID 0 Striping (No Redundancy)</text>
</svg>
"@
        }
        "raid1_mirroring" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="45" width="60" height="55" rx="3" fill="none" stroke="#10b981" stroke-width="2"/>
  <rect x="35" y="55" width="40" height="35" fill="#10b981"/>
  <text x="55" y="120" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">Disk 0 (Primary)</text>
  <rect x="115" y="45" width="60" height="55" rx="3" fill="none" stroke="#10b981" stroke-width="2"/>
  <rect x="125" y="55" width="40" height="35" fill="#10b981"/>
  <text x="145" y="120" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">Disk 1 (Mirror)</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">RAID 1 Mirroring (100% Redundancy)</text>
</svg>
"@
        }
        "raid5_parity" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="15" y="45" width="45" height="55" rx="2" fill="none" stroke="#f59e0b" stroke-width="2"/>
  <text x="37" y="115" fill="#f59e0b" font-family="sans-serif" font-size="8" text-anchor="middle">Disk 0 (A1)</text>
  <rect x="75" y="45" width="45" height="55" rx="2" fill="none" stroke="#f59e0b" stroke-width="2"/>
  <text x="97" y="115" fill="#f59e0b" font-family="sans-serif" font-size="8" text-anchor="middle">Disk 1 (A2)</text>
  <rect x="135" y="45" width="45" height="55" rx="2" fill="none" stroke="#f59e0b" stroke-width="2"/>
  <text x="157" y="115" fill="#f59e0b" font-family="sans-serif" font-size="8" text-anchor="middle">Disk 2 (Parity)</text>
  <text x="100" y="138" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">RAID 5 Distributed Parity Blocks</text>
</svg>
"@
        }
        "raid10_nested" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="15" y="35" width="70" height="70" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <rect x="110" y="35" width="70" height="70" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">RAID 10 (Striping Mirrored Sets)</text>
</svg>
"@
        }
        "hot_swap_status" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="35" y="45" width="130" height="60" rx="3" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <circle cx="55" cy="75" r="8" fill="#10b981"/>
  <circle cx="145" cy="75" r="8" fill="#ef4444"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">HDD Trays Active Status Indicators</text>
</svg>
"@
        }
        "surveillance_hdd_internals" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="70" r="40" fill="none" stroke="#9ca3af" stroke-width="3"/>
  <line x1="100" y1="70" x2="135" y2="90" stroke="#ef4444" stroke-width="3"/>
  <circle cx="135" cy="90" r="4" fill="#ef4444"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">24/7 Heavy-Write Platter Mechanics</text>
</svg>
"@
        }
        "storage_retention_days" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <line x1="30" y1="15" x2="30" y2="120" stroke="#4b5563" stroke-width="1.5"/>
  <line x1="30" y1="120" x2="190" y2="120" stroke="#4b5563" stroke-width="1.5"/>
  <rect x="45" y="90" width="30" height="30" fill="#3b82f6"/>
  <rect x="95" y="60" width="30" height="60" fill="#f59e0b"/>
  <rect x="145" y="30" width="30" height="90" fill="#ef4444"/>
  <text x="60" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="8" text-anchor="middle">7D</text>
  <text x="110" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="8" text-anchor="middle">15D</text>
  <text x="160" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="8" text-anchor="middle">30D</text>
  <text x="100" y="10" fill="#f3f4f6" font-family="sans-serif" font-size="10" text-anchor="middle">Retention Days capacity curves</text>
</svg>
"@
        }
        "storage_calc_tool" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="25" width="150" height="95" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="100" y="75" fill="#10b981" font-family="monospace" font-weight="bold" font-size="11" text-anchor="middle">Bitrate * Hours * Days</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Storage Equation Profile</text>
</svg>
"@
        }
        "raid_rebuild_lab" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="70" r="35" fill="none" stroke="#4b5563" stroke-width="5"/>
  <path d="M 100 35 A 35 35 0 0 1 135 70" fill="none" stroke="#10b981" stroke-width="5"/>
  <text x="100" y="75" fill="#10b981" font-family="sans-serif" font-weight="bold" font-size="12" text-anchor="middle">25%</text>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Array Rebuild Progress Gauge</text>
</svg>
"@
        }

        # Session 19
        "onvif_organization" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="35" y="35" width="130" height="80" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="100" y="80" fill="#f59e0b" font-family="sans-serif" font-weight="bold" font-size="16" text-anchor="middle">ONVIF Core</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Standardized Protocol Stack</text>
</svg>
"@
        }
        "profile_s_features" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="50" y="40" width="100" height="70" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <text x="100" y="80" fill="#3b82f6" font-family="sans-serif" font-weight="bold" font-size="28" text-anchor="middle">S</text>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Video Streaming & PTZ</text>
</svg>
"@
        }
        "profile_g_features" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="50" y="40" width="100" height="70" fill="none" stroke="#10b981" stroke-width="2"/>
  <text x="100" y="80" fill="#10b981" font-family="sans-serif" font-weight="bold" font-size="28" text-anchor="middle">G</text>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Edge Recording & Sync</text>
</svg>
"@
        }
        "profile_t_features" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="50" y="40" width="100" height="70" fill="none" stroke="#f59e0b" stroke-width="2"/>
  <text x="100" y="80" fill="#f59e0b" font-family="sans-serif" font-weight="bold" font-size="28" text-anchor="middle">T</text>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Smart Analytics & H.265</text>
</svg>
"@
        }
        "discovery_multicast" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="70" r="15" fill="#ef4444"/>
  <circle cx="100" cy="70" r="35" fill="none" stroke="#ef4444" stroke-width="1.5" stroke-dasharray="3 3"/>
  <circle cx="100" cy="70" r="55" fill="none" stroke="#ef4444" stroke-width="1" stroke-dasharray="5 5"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">WS-Discovery Broadcast Loops</text>
</svg>
"@
        }
        "onvif_user_auth" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="45" width="45" height="50" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <rect x="130" y="45" width="45" height="50" fill="none" stroke="#10b981" stroke-width="2"/>
  <line x1="70" y1="70" x2="130" y2="70" stroke="#f59e0b" stroke-width="2" stroke-dasharray="3 3"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Authentication Token Exchange</text>
</svg>
"@
        }
        "onvif_debugging_ports" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="30" y="30" width="140" height="85" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="100" y="75" fill="#f3f4f6" font-family="monospace" font-size="9" text-anchor="middle">Port: 80 / 8000 / 8080</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Manufacturer Port standards</text>
</svg>
"@
        }
        "odm_software_gui" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="25" width="150" height="95" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <line x1="65" y1="25" x2="65" y2="120" stroke="#4b5563"/>
  <text x="120" y="75" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">Video Stream Panel</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">ONVIF Device Manager Interface</text>
</svg>
"@
        }
        "onvif_setup_lab" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="30" y="30" width="140" height="85" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Completed Integration Lab</text>
</svg>
"@
        }

        # Session 20
        "compression_ratio" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="20" y="45" width="70" height="50" fill="rgba(239, 68, 68, 0.2)" stroke="#ef4444" stroke-width="2"/>
  <text x="55" y="115" fill="#ef4444" font-family="sans-serif" font-size="8" text-anchor="middle">RAW Video</text>
  <rect x="130" y="55" width="30" height="30" fill="rgba(16, 185, 129, 0.2)" stroke="#10b981" stroke-width="2"/>
  <text x="145" y="115" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">Compressed</text>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Bitrate Data reduction ratio</text>
</svg>
"@
        }
        "h264_macroblock" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="50" y="30" width="80" height="80" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <!-- 16x16 grid lines -->
  <line x1="70" y1="30" x2="70" y2="110" stroke="#4b5563"/>
  <line x1="90" y1="30" x2="90" y2="110" stroke="#4b5563"/>
  <line x1="110" y1="30" x2="110" y2="110" stroke="#4b5563"/>
  <line x1="50" y1="50" x2="130" y2="50" stroke="#4b5563"/>
  <line x1="50" y1="70" x2="130" y2="70" stroke="#4b5563"/>
  <line x1="50" y1="90" x2="130" y2="90" stroke="#4b5563"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">H.264 16x16 Macroblock Grid</text>
</svg>
"@
        }
        "h265_ctu" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="50" y="30" width="80" height="80" fill="none" stroke="#10b981" stroke-width="2"/>
  <!-- CTU split lines -->
  <line x1="90" y1="30" x2="90" y2="110" stroke="#10b981" stroke-width="1.5"/>
  <line x1="50" y1="70" x2="130" y2="70" stroke="#10b981" stroke-width="1.5"/>
  <line x1="70" y1="30" x2="70" y2="70" stroke="#10b981" stroke-width="0.7" stroke-dasharray="1 1"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">H.265 64x64 Adaptive CTU Splitting</text>
</svg>
"@
        }
        "smart_codec_background" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="25" width="150" height="95" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <circle cx="100" cy="72" r="15" fill="#ef4444"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Static Scene Filtering (H.265+)</text>
</svg>
"@
        }
        "gop_structure" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="15" y="55" width="25" height="35" fill="#ef4444"/>
  <text x="27" y="110" fill="#ef4444" font-family="sans-serif" font-weight="bold" font-size="9" text-anchor="middle">I</text>
  <rect x="55" y="60" width="20" height="25" fill="#3b82f6"/>
  <text x="65" y="110" fill="#3b82f6" font-family="sans-serif" font-size="9" text-anchor="middle">P</text>
  <rect x="90" y="60" width="20" height="25" fill="#3b82f6"/>
  <text x="100" y="110" fill="#3b82f6" font-family="sans-serif" font-size="9" text-anchor="middle">P</text>
  <rect x="125" y="60" width="20" height="25" fill="#3b82f6"/>
  <text x="135" y="110" fill="#3b82f6" font-family="sans-serif" font-size="9" text-anchor="middle">P</text>
  <rect x="160" y="55" width="25" height="35" fill="#ef4444"/>
  <text x="172" y="110" fill="#ef4444" font-family="sans-serif" font-weight="bold" font-size="9" text-anchor="middle">I</text>
  <text x="100" y="138" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">GOP Frame Sequence (IPPI)</text>
</svg>
"@
        }
        "cbr_vs_vbr" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <line x1="20" y1="15" x2="20" y2="120" stroke="#4b5563" stroke-width="1.5"/>
  <line x1="20" y1="120" x2="190" y2="120" stroke="#4b5563" stroke-width="1.5"/>
  <line x1="20" y1="65" x2="190" y2="65" stroke="#ef4444" stroke-width="2"/>
  <path d="M 20 100 Q 50 20 80 110 T 140 50 T 190 90" fill="none" stroke="#10b981" stroke-width="2"/>
  <text x="150" y="55" fill="#ef4444" font-family="sans-serif" font-size="8">CBR</text>
  <text x="150" y="80" fill="#10b981" font-family="sans-serif" font-size="8">VBR</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Bandwidth Allocation Profiles</text>
</svg>
"@
        }
        "fps_bandwidth" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <line x1="30" y1="15" x2="30" y2="120" stroke="#4b5563" stroke-width="1.5"/>
  <line x1="30" y1="120" x2="190" y2="120" stroke="#4b5563" stroke-width="1.5"/>
  <rect x="45" y="100" width="30" height="20" fill="#3b82f6"/>
  <text x="60" y="92" fill="#3b82f6" font-family="sans-serif" font-size="8" text-anchor="middle">5fps</text>
  <rect x="95" y="60" width="30" height="60" fill="#f59e0b"/>
  <text x="110" y="52" fill="#f59e0b" font-family="sans-serif" font-size="8" text-anchor="middle">15fps</text>
  <rect x="145" y="30" width="30" height="90" fill="#ef4444"/>
  <text x="160" y="22" fill="#ef4444" font-family="sans-serif" font-size="8" text-anchor="middle">30fps</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Frame Rate Bandwidth Draw</text>
</svg>
"@
        }
        "resolution_grid" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="25" width="150" height="95" fill="none" stroke="#ef4444" stroke-width="2"/>
  <text x="160" y="40" fill="#ef4444" font-family="sans-serif" font-weight="bold" font-size="9" text-anchor="end">4K (8MP)</text>
  <rect x="25" y="55" width="90" height="65" fill="none" stroke="#f59e0b" stroke-width="1.5"/>
  <text x="105" y="70" fill="#f59e0b" font-family="sans-serif" font-weight="bold" font-size="8" text-anchor="end">4MP</text>
  <rect x="25" y="75" width="60" height="45" fill="none" stroke="#3b82f6" stroke-width="1"/>
  <text x="75" y="90" fill="#3b82f6" font-family="sans-serif" font-weight="bold" font-size="7" text-anchor="end">1080p</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Comparative Resolution Frame Sizes</text>
</svg>
"@
        }
        "compression_lab" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="30" y="30" width="140" height="85" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Completed Compression Lab</text>
</svg>
"@
        }

        # Session 21
        "motion_pixel_grid" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="40" y="30" width="120" height="80" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <rect x="60" y="50" width="20" height="20" fill="#ef4444" opacity="0.6"/>
  <rect x="80" y="50" width="20" height="20" fill="#ef4444" opacity="0.6"/>
  <rect x="60" y="70" width="20" height="20" fill="#ef4444" opacity="0.6"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Pixel-Change Activity Cells</text>
</svg>
"@
        }
        "line_crossing_tripwire" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <line x1="20" y1="75" x2="180" y2="75" stroke="#ef4444" stroke-width="3"/>
  <polygon points="100,55 105,65 95,65" fill="#10b981"/>
  <polygon points="100,95 105,85 95,85" fill="#ef4444"/>
  <text x="100" y="45" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">Allowed Direction</text>
  <text x="100" y="112" fill="#ef4444" font-family="sans-serif" font-size="8" text-anchor="middle">Alarm Direction</text>
  <text x="100" y="138" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Smart Tripwire Direction Rules</text>
</svg>
"@
        }
        "intrusion_zone_area" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <polygon points="40,40 160,35 140,110 50,105" fill="rgba(239, 68, 68, 0.15)" stroke="#ef4444" stroke-width="2"/>
  <text x="100" y="75" fill="#ef4444" font-family="sans-serif" font-weight="bold" font-size="12" text-anchor="middle">Intrusion Zone</text>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Custom Perimeter Polygon Areas</text>
</svg>
"@
        }
        "object_classifier_labels" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="35" width="55" height="70" fill="none" stroke="#10b981" stroke-width="2"/>
  <text x="52" y="28" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">Human: 98%</text>
  <rect x="110" y="55" width="70" height="50" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <text x="145" y="48" fill="#3b82f6" font-family="sans-serif" font-size="8" text-anchor="middle">Vehicle: 94%</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Object Classification Labels</text>
</svg>
"@
        }
        "leaf_wind_filter" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <path d="M 40 40 Q 60 20 80 50 T 120 40" fill="none" stroke="#9ca3af" stroke-width="1.5" stroke-dasharray="3 3"/>
  <text x="100" y="90" fill="#10b981" font-family="sans-serif" font-size="9" text-anchor="middle">Swaying Branches Ignored</text>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Dynamic Environment Filter Tree</text>
</svg>
"@
        }
        "smart_search_results" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="25" width="150" height="95" fill="none" stroke="#4b5563" stroke-width="2"/>
  <rect x="35" y="40" width="40" height="40" fill="#10b981" opacity="0.3"/>
  <rect x="85" y="40" width="40" height="40" fill="#10b981" opacity="0.3"/>
  <rect x="135" y="40" width="40" height="40" fill="#10b981" opacity="0.3"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Database Query Filter Event logs</text>
</svg>
"@
        }
        "alarm_relay_wiring" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="35" y="45" width="55" height="50" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <rect x="120" y="45" width="50" height="50" fill="none" stroke="#10b981" stroke-width="2"/>
  <line x1="90" y1="70" x2="120" y2="70" stroke="#f59e0b" stroke-width="2"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Hardware Relay Out Interconnects</text>
</svg>
"@
        }
        "camera_mounting_angle" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <line x1="20" y1="20" x2="20" y2="120" stroke="#4b5563" stroke-width="3"/>
  <polygon points="20,40 50,55 35,65" fill="#f59e0b"/>
  <polygon points="20,40 180,100 180,120" fill="rgba(245, 158, 11, 0.1)"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Target Height Blindspot Analysis</text>
</svg>
"@
        }
        "ai_analytics_lab" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="30" y="30" width="140" height="85" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Completed Analytics Configuration</text>
</svg>
"@
        }

        # Session 22
        "anpr_camera_optics" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <path d="M 30 75 L 180 35 L 180 115 Z" fill="rgba(59, 130, 246, 0.1)" stroke="#3b82f6" stroke-width="1.5"/>
  <circle cx="30" cy="75" r="8" fill="#9ca3af"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Target Lane Focus Focal Lengths</text>
</svg>
"@
        }
        "shutter_speed_compare" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="20" y="45" width="70" height="40" fill="none" stroke="#ef4444" stroke-width="2"/>
  <text x="55" y="68" fill="#ef4444" font-family="monospace" font-weight="bold" font-size="10" text-anchor="middle" opacity="0.3">KL01</text>
  <text x="55" y="115" fill="#ef4444" font-family="sans-serif" font-size="8" text-anchor="middle">1/50s Blur</text>
  <rect x="110" y="45" width="70" height="40" fill="none" stroke="#10b981" stroke-width="2"/>
  <text x="145" y="68" fill="#10b981" font-family="monospace" font-weight="bold" font-size="10" text-anchor="middle">KL01</text>
  <text x="145" y="115" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">1/1000s Sharp</text>
  <text x="100" y="138" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Motion Exposure Capture comparison</text>
</svg>
"@
        }
        "mounting_angles_grid" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="70" r="45" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <!-- 30 deg lines -->
  <line x1="60" y1="45" x2="140" y2="95" stroke="#ef4444" stroke-width="2"/>
  <line x1="60" y1="95" x2="140" y2="45" stroke="#ef4444" stroke-width="2"/>
  <text x="100" y="138" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">30° Max Lens Offsets Tolerances</text>
</svg>
"@
        }
        "plate_ir_reflection" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="35" y="50" width="130" height="40" fill="#ffffff" stroke="#111827" stroke-width="3"/>
  <text x="100" y="76" fill="#111827" font-family="monospace" font-weight="bold" font-size="20" text-anchor="middle">PLATE OK</text>
  <text x="100" y="130" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Plate Retro-Reflective Glow</text>
</svg>
"@
        }
        "anpr_database_match" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="25" width="150" height="95" fill="none" stroke="#4b5563" stroke-width="2"/>
  <text x="35" y="50" fill="#10b981" font-family="monospace" font-size="8">KL-01-A-1234 : MATCH whitelisted</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">ANPR Plate Logging Match Database</text>
</svg>
"@
        }
        "gate_relay_control" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="35" y="45" width="50" height="50" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <rect x="115" y="45" width="50" height="50" fill="none" stroke="#10b981" stroke-width="2"/>
  <line x1="85" y1="70" x2="115" y2="70" stroke="#f59e0b" stroke-width="2"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Barrier Control Relay loops</text>
</svg>
"@
        }
        "vehicle_flow_graph" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <line x1="30" y1="20" x2="30" y2="120" stroke="#4b5563" stroke-width="1.5"/>
  <line x1="30" y1="120" x2="190" y2="120" stroke="#4b5563" stroke-width="1.5"/>
  <path d="M 30 110 Q 70 30 110 90 T 190 40" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Traffic Peak statistics Flow Curves</text>
</svg>
"@
        }
        "anpr_troubleshooting" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="70" r="30" fill="none" stroke="#ef4444" stroke-width="3"/>
  <line x1="80" y1="50" x2="120" y2="90" stroke="#ef4444" stroke-width="3"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Plate Recognition Fail Diagnostics</text>
</svg>
"@
        }
        "anpr_lab" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="30" y="30" width="140" height="85" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Completed Gate Loop Lab</text>
</svg>
"@
        }

        # Session 23
        "face_detection_box" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="65" r="30" fill="none" stroke="#10b981" stroke-width="2"/>
  <rect x="65" y="30" width="70" height="75" fill="none" stroke="#10b981" stroke-width="1.5"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Head Detection Box Overlays</text>
</svg>
"@
        }
        "eye_pixel_distance" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="75" cy="65" r="4" fill="#3b82f6"/>
  <circle cx="125" cy="65" r="4" fill="#3b82f6"/>
  <line x1="75" y1="65" x2="125" y2="65" stroke="#f59e0b" stroke-width="2"/>
  <text x="100" y="55" fill="#f59e0b" font-family="sans-serif" font-size="8" text-anchor="middle">Min 80 Pixels</text>
  <text x="100" y="130" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Pupil Sizing density constraints</text>
</svg>
"@
        }
        "database_groups" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="45" width="40" height="40" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <rect x="80" y="45" width="40" height="40" fill="none" stroke="#10b981" stroke-width="2"/>
  <rect x="135" y="45" width="40" height="40" fill="none" stroke="#ef4444" stroke-width="2"/>
  <text x="45" y="110" fill="#9ca3af" font-family="sans-serif" font-size="8" text-anchor="middle">Staff</text>
  <text x="100" y="110" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">VIP</text>
  <text x="155" y="110" fill="#ef4444" font-family="sans-serif" font-size="8" text-anchor="middle">Blacklist</text>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Enrollment Database segment Categories</text>
</svg>
"@
        }
        "similarity_confidence" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="70" r="35" fill="none" stroke="#4b5563" stroke-width="5"/>
  <path d="M 100 35 A 35 35 0 0 1 135 70" fill="none" stroke="#10b981" stroke-width="5"/>
  <text x="100" y="75" fill="#10b981" font-family="sans-serif" font-weight="bold" font-size="12" text-anchor="middle">85%</text>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Biometric Match Similarity Gauge</text>
</svg>
"@
        }
        "lighting_compensation" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="55" r="20" fill="none" stroke="#3b82f6"/>
  <line x1="50" y1="110" x2="80" y2="80" stroke="#f59e0b" stroke-width="2"/>
  <line x1="150" y1="110" x2="120" y2="80" stroke="#f59e0b" stroke-width="2"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Face shadow Compensation Lights</text>
</svg>
"@
        }
        "blacklist_siren_trigger" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="45" width="55" height="50" fill="none" stroke="#ef4444" stroke-width="2"/>
  <path d="M 130 75 Q 150 75 160 90 L 120 90 Z" fill="none" stroke="#ef4444" stroke-width="2"/>
  <line x1="80" y1="70" x2="125" y2="70" stroke="#f59e0b" stroke-width="2"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Blacklist Horn & Strobe Relay Links</text>
</svg>
"@
        }
        "snapshot_search" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="25" width="150" height="95" fill="none" stroke="#4b5563" stroke-width="2"/>
  <circle cx="60" cy="72" r="16" fill="#10b981" opacity="0.3"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Face query Snapshot Search Dashboard</text>
</svg>
"@
        }
        "gdpr_privacy" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <path d="M 100 30 Q 115 25 130 30 L 130 70 Q 100 100 100 100 Q 100 100 70 70 L 70 30 Q 85 25 100 30 Z" fill="none" stroke="#10b981" stroke-width="3"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Encrypted Biometric Data Shield</text>
</svg>
"@
        }
        "facial_rec_lab" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="30" y="30" width="140" height="85" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Completed Face Database Setup</text>
</svg>
"@
        }

        # Session 24
        "colorvu_lens_f1" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="70" r="40" fill="none" stroke="#f59e0b" stroke-width="4"/>
  <circle cx="100" cy="70" r="38" fill="#f59e0b" opacity="0.2"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">F1.0 Super Large Lens Aperture</text>
</svg>
"@
        }
        "acusense_classification" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="15" y="45" width="45" height="40" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="37" y="68" fill="#9ca3af" font-family="sans-serif" font-size="8" text-anchor="middle">Pixel</text>
  <rect x="75" y="45" width="50" height="40" fill="none" stroke="#ef4444" stroke-width="2"/>
  <text x="100" y="68" fill="#ef4444" font-family="sans-serif" font-size="8" text-anchor="middle">Human</text>
  <rect x="140" y="45" width="45" height="40" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <text x="162" y="68" fill="#3b82f6" font-family="sans-serif" font-size="8" text-anchor="middle">Car</text>
  <text x="100" y="130" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Target Pixel Sorter Classifications</text>
</svg>
"@
        }
        "thermal_sensor_core" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="40" y="45" width="45" height="50" rx="3" fill="none" stroke="#ef4444" stroke-width="2"/>
  <rect x="115" y="45" width="45" height="50" rx="3" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Microbolometer Thermal Sensor Array</text>
</svg>
"@
        }
        "thermal_fire_alert" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="70" r="30" fill="rgba(239, 68, 68, 0.2)" stroke="#ef4444" stroke-width="3"/>
  <text x="100" y="75" fill="#ef4444" font-family="sans-serif" font-weight="bold" font-size="12" text-anchor="middle">120°C</text>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Hot-Spot Temperature Limit Alert</text>
</svg>
"@
        }
        "bispectrum_fusion" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="25" width="150" height="95" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <circle cx="100" cy="72" r="20" fill="none" stroke="#ef4444" stroke-width="3"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Visible details with Thermal Overlays</text>
</svg>
"@
        }
        "thermal_temp_graph" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <line x1="20" y1="15" x2="20" y2="120" stroke="#4b5563" stroke-width="1.5"/>
  <line x1="20" y1="120" x2="190" y2="120" stroke="#4b5563" stroke-width="1.5"/>
  <path d="M 20 110 L 80 90 L 130 40 L 190 30" fill="none" stroke="#ef4444" stroke-width="2"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Rise Rates Monitoring Curves</text>
</svg>
"@
        }
        "perimeter_thermal_fence" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <line x1="15" y1="80" x2="185" y2="80" stroke="#ef4444" stroke-width="3"/>
  <circle cx="100" cy="80" r="6" fill="#10b981"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Long-Range Fence boundary audits</text>
</svg>
"@
        }
        "thermal_obstructions" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="90" y="25" width="20" height="90" fill="#3b82f6" opacity="0.3"/>
  <line x1="20" y1="70" x2="90" y2="70" stroke="#ef4444" stroke-width="2"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Glass pane Heat Ray Block Check</text>
</svg>
"@
        }
        "thermal_lab" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="30" y="30" width="140" height="85" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Completed Thermal Setup Lab</text>
</svg>
"@
        }

        # Session 25
        "ptz_slip_ring" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="70" r="35" fill="none" stroke="#9ca3af" stroke-width="5"/>
  <circle cx="100" cy="70" r="25" fill="none" stroke="#f59e0b" stroke-width="3"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Continuous rotation Contact Rings</text>
</svg>
"@
        }
        "zoom_lenses" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="45" width="150" height="50" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <path d="M 60 50 C 70 50, 70 90, 60 90 Z" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <path d="M 120 50 C 130 50, 130 90, 120 90 Z" fill="none" stroke="#10b981" stroke-width="2"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Sliding Zoom element Assemblies</text>
</svg>
"@
        }
        "ptz_preset_coords" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="25" width="150" height="95" fill="none" stroke="#4b5563" stroke-width="2"/>
  <circle cx="50" cy="50" r="6" fill="#ef4444"/>
  <circle cx="150" cy="90" r="6" fill="#10b981"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Preset Coordinates motor Steps</text>
</svg>
"@
        }
        "ptz_patrol_tour" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <path d="M 40 40 L 160 40 L 100 100 Z" fill="none" stroke="#f59e0b" stroke-width="2"/>
  <circle cx="40" cy="40" r="6" fill="#3b82f6"/>
  <circle cx="160" cy="40" r="6" fill="#3b82f6"/>
  <circle cx="100" cy="100" r="6" fill="#3b82f6"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Preset Sequence Tour Loops</text>
</svg>
"@
        }
        "autotracking_logic" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="65" y="35" width="70" height="70" fill="none" stroke="#10b981" stroke-width="2"/>
  <circle cx="100" cy="70" r="20" fill="none" stroke="#ef4444" stroke-width="1.5" stroke-dasharray="3 3"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Auto-Center Target Tracking Logic</text>
</svg>
"@
        }
        "rs485_pelco_wiring" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="45" width="60" height="50" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <rect x="115" y="45" width="60" height="50" fill="none" stroke="#10b981" stroke-width="2"/>
  <line x1="85" y1="60" x2="115" y2="60" stroke="#f59e0b" stroke-width="2"/>
  <line x1="85" y1="80" x2="115" y2="80" stroke="#f59e0b" stroke-width="2"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">RS485 Pelco Serial Interconnects</text>
</svg>
"@
        }
        "ptz_joystick_desk" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="35" y="55" width="130" height="60" rx="4" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <circle cx="65" cy="85" r="15" fill="none" stroke="#ef4444" stroke-width="2"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">3-Axis joystick Desk Controls</text>
</svg>
"@
        }
        "mechanical_limit_stops" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="70" r="35" fill="none" stroke="#4b5563" stroke-width="3"/>
  <rect x="95" y="30" width="10" height="15" fill="#ef4444"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Physical limit Stop Switches</text>
</svg>
"@
        }
        "ptz_patrol_lab" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="30" y="30" width="140" height="85" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Completed Patrol Setup Lab</text>
</svg>
"@
        }

        # Session 26
        "p2p_handshake" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="15" y="45" width="40" height="40" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <!-- Broker cloud -->
  <path d="M 80 65 C 75 50, 110 50, 105 65 C 120 65, 120 80, 105 80 L 80 80 Z" fill="none" stroke="#10b981" stroke-width="2"/>
  <rect x="145" y="45" width="40" height="40" fill="none" stroke="#f59e0b" stroke-width="2"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">P2P Broker Tunnel Connection</text>
</svg>
"@
        }
        "qr_code_scan" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="75" y="35" width="50" height="50" fill="none" stroke="#f59e0b" stroke-width="3"/>
  <rect x="85" y="45" width="10" height="10" fill="#f59e0b"/>
  <rect x="105" y="65" width="10" height="10" fill="#f59e0b"/>
  <text x="100" y="130" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">NVR Unique QR Scan Serial</text>
</svg>
"@
        }
        "ddns_resolution" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="45" width="60" height="40" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <text x="55" y="68" fill="#3b82f6" font-family="sans-serif" font-size="8" text-anchor="middle">Client Domain</text>
  <rect x="115" y="45" width="60" height="40" fill="none" stroke="#10b981" stroke-width="2"/>
  <text x="145" y="68" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">Public IP</text>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Dynamic Host DNS mapping Updates</text>
</svg>
"@
        }
        "port_forwarding_tunnel" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="75" y="35" width="50" height="60" fill="none" stroke="#ef4444" stroke-width="2"/>
  <line x1="20" y1="65" x2="180" y2="65" stroke="#10b981" stroke-width="2.5"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Firewall Port Tunnel mappings</text>
</svg>
"@
        }
        "stream_profiles" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="20" y="45" width="70" height="40" fill="none" stroke="#ef4444" stroke-width="2"/>
  <text x="55" y="68" fill="#ef4444" font-family="sans-serif" font-size="8" text-anchor="middle">Main (4K)</text>
  <rect x="110" y="55" width="70" height="30" fill="none" stroke="#10b981" stroke-width="2"/>
  <text x="145" y="73" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">Sub (D1)</text>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Network Stream Profiles Sizing</text>
</svg>
"@
        }
        "push_notification_flow" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="15" y="45" width="40" height="40" fill="none" stroke="#ef4444" stroke-width="2"/>
  <rect x="145" y="45" width="40" height="40" fill="none" stroke="#10b981" stroke-width="2"/>
  <line x1="55" y1="65" x2="145" y2="65" stroke="#f59e0b" stroke-width="2"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Alarm Event Push notification Route</text>
</svg>
"@
        }
        "vms_central_station" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="25" width="150" height="95" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <line x1="100" y1="25" x2="100" y2="120" stroke="#4b5563"/>
  <line x1="25" y1="72" x2="175" y2="72" stroke="#4b5563"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Multi-View VMS Client Grid Console</text>
</svg>
"@
        }
        "isp_upload_bandwidth" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <line x1="30" y1="15" x2="30" y2="120" stroke="#4b5563" stroke-width="1.5"/>
  <line x1="30" y1="120" x2="190" y2="120" stroke="#4b5563" stroke-width="1.5"/>
  <rect x="45" y="40" width="120" height="80" fill="#ef4444"/>
  <text x="100" y="138" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">WAN Upload Link constraints</text>
</svg>
"@
        }
        "remote_viewing_lab" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="30" y="30" width="140" height="85" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Completed Mobile App setup</text>
</svg>
"@
        }

        # Session 27
        "cctv_hacking_vectors" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="70" r="30" fill="none" stroke="#ef4444" stroke-width="3"/>
  <line x1="100" y1="20" x2="100" y2="40" stroke="#ef4444" stroke-width="2"/>
  <line x1="100" y1="100" x2="100" y2="120" stroke="#ef4444" stroke-width="2"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Network Security Entry Points</text>
</svg>
"@
        }
        "password_rules" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="25" width="150" height="95" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="100" y="75" fill="#10b981" font-family="monospace" font-weight="bold" font-size="12" text-anchor="middle">Chars + Digits + Symbols</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Firmware Password rules Table</text>
</svg>
"@
        }
        "custom_port_mapping" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="35" y="45" width="55" height="50" fill="none" stroke="#ef4444" stroke-width="2"/>
  <text x="62" y="75" fill="#ef4444" font-family="monospace" font-size="8" text-anchor="middle">80</text>
  <rect x="110" y="45" width="55" height="50" fill="none" stroke="#10b981" stroke-width="2"/>
  <text x="137" y="75" fill="#10b981" font-family="monospace" font-size="8" text-anchor="middle">8585</text>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Standard Port Redirection Mapping</text>
</svg>
"@
        }
        "upnp_vulnerability" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="70" r="35" fill="none" stroke="#ef4444" stroke-width="3"/>
  <line x1="80" y1="50" x2="120" y2="90" stroke="#ef4444" stroke-width="3"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">UPnP Auto-Opening Port vulnerability</text>
</svg>
"@
        }
        "https_ssl_handshake" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="45" width="45" height="50" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <rect x="130" y="45" width="45" height="50" fill="none" stroke="#10b981" stroke-width="2"/>
  <line x1="70" y1="70" x2="130" y2="70" stroke="#10b981" stroke-width="2"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">HTTPS Key exchange SSL locks</text>
</svg>
"@
        }
        "ip_whitelisting" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="25" width="150" height="95" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="35" y="55" fill="#10b981" font-family="monospace" font-size="8">ALLOW: 192.168.1.50</text>
  <text x="35" y="75" fill="#ef4444" font-family="monospace" font-size="8">DENY: ALL OTHER HOSTS</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">IP Access Filter Firewall Whitelist</text>
</svg>
"@
        }
        "user_privileges" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="30" width="150" height="80" fill="none" stroke="#4b5563" stroke-width="1.5"/>
  <line x1="25" y1="55" x2="175" y2="55" stroke="#4b5563"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Admin vs Operator Privilege Rights</text>
</svg>
"@
        }
        "firmware_patching" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="30" y="55" width="140" height="30" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <rect x="31" y="56" width="95" height="28" fill="#10b981"/>
  <text x="100" y="130" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Firmware Flash Write Upgrade Block</text>
</svg>
"@
        }
        "cybersecurity_lab" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="30" y="30" width="140" height="85" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Completed Hardening Checklist Lab</text>
</svg>
"@
        }

        # Session 28
        "no_video_diagnostic" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="35" y="25" width="130" height="95" fill="none" stroke="#ef4444" stroke-width="2"/>
  <text x="100" y="75" fill="#ef4444" font-family="sans-serif" font-weight="bold" font-size="18" text-anchor="middle">NO VIDEO</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Video Loss Diagnostic Flowchart</text>
</svg>
"@
        }
        "ip_clash_detection" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="30" y="45" width="60" height="40" fill="none" stroke="#ef4444" stroke-width="2"/>
  <text x="60" y="68" fill="#ef4444" font-family="monospace" font-size="7" text-anchor="middle">192.168.1.10</text>
  <rect x="110" y="45" width="60" height="40" fill="none" stroke="#ef4444" stroke-width="2"/>
  <text x="140" y="68" fill="#ef4444" font-family="monospace" font-size="7" text-anchor="middle">192.168.1.10</text>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">IP Conflict Detection Collision</text>
</svg>
"@
        }
        "packet_loss_graph" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <line x1="20" y1="15" x2="20" y2="120" stroke="#4b5563" stroke-width="1.5"/>
  <line x1="20" y1="120" x2="190" y2="120" stroke="#4b5563" stroke-width="1.5"/>
  <path d="M 20 120 L 50 110 L 80 50 L 110 120 L 140 120 L 170 30" fill="none" stroke="#ef4444" stroke-width="2"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Ping Packet Drop rates Chart</text>
</svg>
"@
        }
        "ir_reflection_halo" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="70" r="40" fill="none" stroke="#ef4444" stroke-width="3"/>
  <circle cx="100" cy="70" r="30" fill="none" stroke="#ef4444" stroke-width="1.5" stroke-dasharray="3 3"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Dome Cover IR glare Reflection Halo</text>
</svg>
"@
        }
        "ground_loop_hum" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <line x1="20" y1="75" x2="180" y2="75" stroke="#4b5563"/>
  <path d="M 20 75 Q 35 45 50 75 T 80 75 T 110 75 T 140 75 T 170 75" fill="none" stroke="#ef4444" stroke-width="2"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Mains hum noise scroll bar filters</text>
</svg>
"@
        }
        "focus_drift" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="35" width="60" height="60" fill="none" stroke="#10b981" stroke-width="2"/>
  <text x="55" y="115" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">Sharp Focus</text>
  <rect x="115" y="35" width="60" height="60" fill="none" stroke="#ef4444" stroke-width="2" opacity="0.4"/>
  <text x="145" y="115" fill="#ef4444" font-family="sans-serif" font-size="8" text-anchor="middle">Soft Drift</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Focus Calibrations Audit</text>
</svg>
"@
        }
        "tftp_firmware_recovery" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="45" width="55" height="50" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <text x="52" y="75" fill="#3b82f6" font-family="sans-serif" font-size="8" text-anchor="middle">TFTP Server</text>
  <rect x="120" y="45" width="55" height="50" fill="none" stroke="#10b981" stroke-width="2"/>
  <text x="147" y="75" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">IP NVR</text>
  <line x1="80" y1="70" x2="120" y2="70" stroke="#f59e0b" stroke-width="2"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">TFTP Firmware recovery Loops</text>
</svg>
"@
        }
        "physical_cleaning_tools" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="70" r="30" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <line x1="100" y1="20" x2="100" y2="40" stroke="#9ca3af" stroke-width="2"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Dust blower & optical Cloth kits</text>
</svg>
"@
        }
        "troubleshooting_lab" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="30" y="30" width="140" height="85" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Completed diagnostic Lab</text>
</svg>
"@
        }
    }
}

$sessions = @(
    # Session 14: Analog & IP CCTV
    @{
        num = 14
        title = "Analog IP CCTV"
        accent_color = "#3b82f6"
        accent_glow = "rgba(59, 130, 246, 0.4)"
        diagram = "analog_ip_compare"
        slides = @(
            @{ type="title"; title="Analog & IP CCTV Systems" },
            @{ type="content"; title="Analog CCTV Basics"; diagram="coax_structure"; bullets="<ul><li><strong>Signal Type:</strong> Transmits raw analog electrical waveforms over physical copper cable lines.</li><li><strong>Coaxial Cables:</strong> Relies on RG59 or RG6 cables shielded to prevent high-frequency noise insertion.</li><li><strong>BNC Connectors:</strong> Utilizes twist-lock bayonet connections standard on analog DVR units.</li></ul>" },
            @{ type="content"; title="IP CCTV Basics"; diagram="cat6_structure"; bullets="<ul><li><strong>Digital Data:</strong> Video is compressed into standard network packets at the camera level.</li><li><strong>Cat6 Cabling:</strong> Employs ethernet lines to carry both digital data and PoE operating voltages.</li><li><strong>Decentralization:</strong> Each IP camera operates as a standalone network client with its own IP card.</li></ul>" },
            @{ type="content"; title="Signal Latency Comparison"; diagram="latency_chart"; bullets="<ul><li><strong>Analog Realtime:</strong> Zero processing delays. Video travels at electrical speed straight to screen.</li><li><strong>IP Delay:</strong> Compression, network routing, and NVR buffering introduce mild latency (typically 100-300ms).</li></ul>" },
            @{ type="content"; title="HD-TVI Protocols"; diagram="hdtvi_signal"; bullets="<ul><li><strong>HD-TVI:</strong> High Definition Transport Video Interface standard.</li><li><strong>Analog Megapixel:</strong> Permits sending full HD 1080p and 4K resolutions over existing standard analog coax routes.</li></ul>" },
            @{ type="content"; title="Video Baluns"; diagram="balun_circuit"; bullets="<ul><li><strong>Purpose:</strong> Impedance-matching transformers that allow coaxial BNC signals to travel over UTP (Cat6) twisted pair lines.</li><li><strong>Impedance Match:</strong> Adapts 75-ohm unbalanced coax impedance to 100-ohm balanced twisted-pair lines.</li></ul>" },
            @{ type="content"; title="Coaxial Distance Sizing Limits"; diagram="coax_loss"; bullets="<ul><li><strong>Distance Sizing:</strong> Standard RG59 cables support video runs up to 300m.</li><li><strong>Signal loss:</strong> Long coax runs attenuate high-frequency video signals, resulting in grainy images.</li></ul>" },
            @{ type="content"; title="Ethernet Sizing Limits"; diagram="ethernet_injector"; bullets="<ul><li><strong>IP Limit:</strong> Standard Cat6 cable links are strictly limited to 100m.</li><li><strong>PoE voltage drop:</strong> Sizing requires inline extenders or switches for runs extending past the 100m threshold.</li></ul>" },
            @{ type="content"; title="DVR, NVR & Hybrid Recorders"; diagram="xvr_hybrid"; bullets="<ul><li><strong>DVR (Digital Video Recorder):</strong> Encodes and compresses incoming raw analog camera feeds.</li><li><strong>NVR (Network Video Recorder):</strong> Simply records incoming pre-compressed network streams from IP cameras.</li><li><strong>XVR Hybrid:</strong> Accepts both analog BNC and IP camera inputs on the same chassis.</li></ul>" },
            @{ type="content"; title="Practical Lab Guide"; diagram="analog_ip_lab"; bullets="<div class='lab-block'><h3>Lab Work: Analog vs IP Setup</h3><ol><li>Crimp BNC terminal onto RG59 coax, wire analog camera to DVR.</li><li>Install video baluns to run analog signal over a Cat6 twisted pair.</li><li>Configure IP Dome on network switch, compare latency feeds on NVR screen.</li></ol></div>" }
        )
    },
    
    # Session 15: Camera Selection & Design
    @{
        num = 15
        title = "Camera Selection Design"
        accent_color = "#10b981"
        accent_glow = "rgba(16, 185, 129, 0.4)"
        diagram = "cam_form_factors"
        slides = @(
            @{ type="title"; title="Camera Selection & Design" },
            @{ type="content"; title="Dome Camera Enclosures"; diagram="dome_profile"; bullets="<ul><li><strong>Aesthetics:</strong> Low-profile design. Fits discreetly in indoor offices and retail settings.</li><li><strong>Vandal Resistance:</strong> IK10-rated polycarbonate glass dome shells protect lenses from physical attacks.</li></ul>" },
            @{ type="content"; title="Bullet Camera Enclosures"; diagram="bullet_profile"; bullets="<ul><li><strong>Deterrence:</strong> High-visibility housing. Discourages trespassers in outdoor areas.</li><li><strong>IP Ratings:</strong> IP66/IP67 weatherproofing standard with adjustable hoods to protect lenses from rain glare.</li></ul>" },
            @{ type="content"; title="Turret / Eyeball Cameras"; diagram="turret_profile"; bullets="<ul><li><strong>Flexible Direction:</strong> Ball-and-socket design allows multi-axis adjustment without taking off dome covers.</li><li><strong>No IR Reflection:</strong> Separate glass panes for lens and IR emitters prevent night halo glare.</li></ul>" },
            @{ type="content"; title="Low-Light Sensors & Lux Ratings"; diagram="lux_scale"; bullets="<ul><li><strong>Lux Scale:</strong> Standard of sensitivity (0 Lux = absolute dark).</li><li><strong>Sensors:</strong> Large aperture CMOS chips gather faint ambient light to output clear night frames.</li></ul>" },
            @{ type="content"; title="WDR (Wide Dynamic Range)"; diagram="wdr_comparison"; bullets="<ul><li><strong>Contrast:</strong> Combines multiple fast exposures to clear up dark shadow regions and bright window backlights.</li><li><strong>Sizing:</strong> Standard WDR is rated in Decibels (120dB standard for retail entrance glass doors).</li></ul>" },
            @{ type="content"; title="Infrared Night Illumination"; diagram="smart_ir_action"; bullets="<ul><li><strong>IR LEDs:</strong> Emitters output invisible 850nm light to illuminate dark outdoor areas.</li><li><strong>Smart IR:</strong> Adjusts IR intensity automatically as targets approach, preventing face overexposure.</li></ul>" },
            @{ type="content"; title="DORI Design Standards"; diagram="dori_ranges"; bullets="<ul><li><strong>DORI Specs:</strong> Enforces pixel densities on target fields:<ul><li><strong>Detect (25 px/m):</strong> Is there a person?</li><li><strong>Observe (63 px/m):</strong> What are they doing?</li><li><strong>Recognize (125 px/m):</strong> Can we recognize their face?</li><li><strong>Identify (250 px/m):</strong> Legal identification criteria.</li></ul></li></ul>" },
            @{ type="content"; title="Mounts & Brackets Sizing"; diagram="camera_mount_types"; bullets="<ul><li><strong>Brackets:</strong> Junction mount boxes, wall goosenecks, pole clamps, and corner brackets.</li><li><strong>Waterproofing:</strong> Enforce rubber gaskets and drip loops to prevent water from entering cable cavities.</li></ul>" },
            @{ type="content"; title="Practical Lab Guide"; diagram="camera_design_lab"; bullets="<div class='lab-block'><h3>Lab Work: Mount & WDR Setup</h3><ol><li>Secure bullet camera box bracket onto mock masonry block.</li><li>Aim camera at bright window backlight, enable True WDR, verify shadow detail.</li><li>Measure target face pixel density to audit DORI recognition limits.</li></ol></div>" }
        )
    },

    # Session 16: Lens & Field of View
    @{
        num = 16
        title = "Lens Field of View"
        accent_color = "#f59e0b"
        accent_glow = "rgba(245, 158, 11, 0.4)"
        diagram = "lens_fov"
        slides = @(
            @{ type="title"; title="Lens & Field of View" },
            @{ type="content"; title="Lens Focal Length"; diagram="focal_point"; bullets="<ul><li><strong>Focal Length:</strong> Sized in millimeters (mm). Distance from sensor to optical center.</li><li><strong>FOV Rule:</strong> Small mm focal lengths (2.8mm) yield wide angles; large mm (12mm) yield telephoto narrow zooms.</li></ul>" },
            @{ type="content"; title="Aperture (F-Stop)"; diagram="aperture_comparison"; bullets="<ul><li><strong>F-Stop Sizing:</strong> Ratio of focal length to entry diameter (e.g. f/1.2, f/2.0).</li><li><strong>Light intake:</strong> Lower F-stop values indicate wider lens apertures, gathering more light for night shots.</li></ul>" },
            @{ type="content"; title="Fixed vs. Varifocal Lenses"; diagram="fixed_vs_varifocal"; bullets="<ul><li><strong>Fixed Lens:</strong> Set focal distance (e.g. 3.6mm). Zero field alterations possible post-installation.</li><li><strong>Manual Varifocal:</strong> Focal distance is adjusted by turning adjustment screws during setup.</li></ul>" },
            @{ type="content"; title="Motorized Varifocal Lenses"; diagram="motorized_zoom_gears"; bullets="<ul><li><strong>Remote Control:</strong> Internal miniature zoom/focus motors control elements remotely via NVR control keys.</li><li><strong>Auto-Focus:</strong> Lens calibrates focus automatically after zoom changes are completed.</li></ul>" },
            @{ type="content"; title="Angle of View Calculations"; diagram="fov_angles"; bullets="<ul><li><strong>Vertical/Horizontal:</strong> FOV values listed in degrees.</li><li><strong>Coverage design:</strong> Wide lenses cover broad entry zones; narrow lenses focus down tight passageways.</li></ul>" },
            @{ type="content"; title="Optical vs. Digital Zoom"; diagram="optical_vs_digital"; bullets="<ul><li><strong>Optical Zoom:</strong> Physical movement of internal glass elements; retains full pixel resolution.</li><li><strong>Digital Zoom:</strong> Electronic cropping and interpolation; reduces detail and pixel resolution.</li></ul>" },
            @{ type="content"; title="Depth of Field (DOF)"; diagram="depth_of_field"; bullets="<ul><li><strong>Focus Range:</strong> The distance range in front of the lens that remains in sharp focus.</li><li><strong>Lighting factor:</strong> Apertures open wide in low light, shrinking the depth of field zone.</li></ul>" },
            @{ type="content"; title="Lens Calculation Software"; diagram="fov_calculator_ui"; bullets="<ul><li><strong>Tools:</strong> Sizing softwares calculate lens focal lengths based on target distance and target width inputs.</li><li><strong>Blueprint Import:</strong> Import layouts to map camera coverage cones before purchasing.</li></ul>" },
            @{ type="content"; title="Practical Lab Guide"; diagram="lens_fov_lab"; bullets="<div class='lab-block'><h3>Lab Work: FOV & Zoom Test</h3><ol><li>Deploy 2.8mm camera, document horizontal coverage limit.</li><li>Adjust a motorized varifocal lens to zoom down to a target plate 20m away.</li><li>Measure target details using NVR screen scale options.</li></ol></div>" }
        )
    },

    # Session 17: DVR, NVR & Hybrid Systems
    @{
        num = 17
        title = "DVR NVR Hybrid Systems"
        accent_color = "#ef4444"
        accent_glow = "rgba(239, 68, 68, 0.4)"
        diagram = "dvr_nvr_ports"
        slides = @(
            @{ type="title"; title="DVR, NVR & Hybrid Systems" },
            @{ type="content"; title="DVR Hardware Architecture"; diagram="dvr_block_diagram"; bullets="<ul><li><strong>Analog Processing:</strong> Motherboard features ADC chips to digitize incoming analog video currents.</li><li><strong>BNC Array:</strong> Rear panel holds arrays of BNC female coaxial sockets.</li></ul>" },
            @{ type="content"; title="NVR Hardware Architecture"; diagram="nvr_block_diagram"; bullets="<ul><li><strong>Network Engine:</strong> Main board operates as a high-speed network switch.</li><li><strong>PoE Switch Integration:</strong> Back panels feature built-in RJ45 PoE ports to power and connect IP cameras.</li></ul>" },
            @{ type="content"; title="Hybrid XVRs"; diagram="xvr_block"; bullets="<ul><li><strong>Dual Mode:</strong> Decodes both coax analog inputs and IP network streams.</li><li><strong>Upgrade Path:</strong> Ideal upgrade path for upgrading old coax networks to IP megapixel cams.</li></ul>" },
            @{ type="content"; title="SATA Storage Interfaces"; diagram="sata_connector"; bullets="<ul><li><strong>SATA ports:</strong> Internal power and data ribbon cables mount directly to motherboards.</li><li><strong>HDD Bays:</strong> Professional recorders hold multiple hard drive slots (2-bay, 4-bay, 8-bay options).</li></ul>" },
            @{ type="content"; title="Storage Sizing Parameters"; diagram="storage_factors"; bullets="<ul><li><strong>Variables:</strong> storage is calculated using: resolution (MP), compression codec, frame rate (FPS), and retention days.</li></ul>" },
            @{ type="content"; title="Thermal Cooling & Venting"; diagram="thermal_cooling"; bullets="<ul><li><strong>Surveillance HDDs:</strong> Generate high continuous operating temperatures.</li><li><strong>Enclosure Cooling:</strong> Internal chassis fans pull fresh air across drive bays to prevent chip lockups.</li></ul>" },
            @{ type="content"; title="PoE Power Budgets"; diagram="poe_budget_bar"; bullets="<ul><li><strong>Switch Rating:</strong> Built-in PoE switch budgets must accommodate target camera draws (e.g. 120W total).</li><li><strong>Watt Limits:</strong> Exceeding switch power ratings disables ports.</li></ul>" },
            @{ type="content"; title="Firmware Recording Profiles"; diagram="nvr_schedules"; bullets="<ul><li><strong>Continuous:</strong> Constant recording mode (24/7).</li><li><strong>Event Triggered:</strong> Records only during motion detection or AI line-crossing alarms to save storage space.</li></ul>" },
            @{ type="content"; title="Practical Lab Guide"; diagram="hdd_install_lab"; bullets="<div class='lab-block'><h3>Lab Work: Hard Drive Installation</h3><ol><li>Open NVR metal chassis cover, mount 2TB surveillance hard drive.</li><li>Terminate SATA data and power ribbons, secure drive with mounting bolts.</li><li>Boot NVR, format hard drive, configure motion-triggered recording schedules.</li></ol></div>" }
        )
    },

    # Session 18: RAID & Storage Design
    @{
        num = 18
        title = "RAID Storage Design"
        accent_color = "#3b82f6"
        accent_glow = "rgba(59, 130, 246, 0.4)"
        diagram = "raid_arrays"
        slides = @(
            @{ type="title"; title="RAID & Storage Design" },
            @{ type="content"; title="RAID 0 (Striping)"; diagram="raid0_striping"; bullets="<ul><li><strong>Mechanism:</strong> Splits data across drives for fast reading and writing speeds.</li><li><strong>Zero Redundancy:</strong> If a single drive fails, all video data in the array is lost.</li></ul>" },
            @{ type="content"; title="RAID 1 (Mirroring)"; diagram="raid1_mirroring"; bullets="<ul><li><strong>Mechanism:</strong> Clones data from drive 1 directly onto drive 2.</li><li><strong>Redundancy:</strong> Provides 100% data backup. Can survive a single hard drive failure without data loss.</li></ul>" },
            @{ type="content"; title="RAID 5 (Striping with Parity)"; diagram="raid5_parity"; bullets="<ul><li><strong>Mechanism:</strong> Distributes data and parity info across a minimum of 3 drives.</li><li><strong>Efficiency:</strong> Can survive one drive failure. Best balance of speed, space, and backup security.</li></ul>" },
            @{ type="content"; title="RAID 10 Nested Array"; diagram="raid10_nested"; bullets="<ul><li><strong>Combination:</strong> Combines RAID 1 mirroring and RAID 0 striping. Requires at least 4 drives.</li><li><strong>Speed & Safety:</strong> Offers maximum performance and security, but sacrifices 50% of total drive capacity.</li></ul>" },
            @{ type="content"; title="Hot-Swapping Drives"; diagram="hot_swap_status"; bullets="<ul><li><strong>Live Swap:</strong> Replacing a failed hard drive while the NVR/Server is running.</li><li><strong>Rebuilding Array:</strong> The RAID controller automatically rebuilds lost data onto the new drive using parity info.</li></ul>" },
            @{ type="content"; title="Surveillance-Grade vs. Desktop HDDs"; diagram="surveillance_hdd_internals"; bullets="<ul><li><strong>Desktop HDD:</strong> Engineered for 8/5 light workloads. Fails under constant surveillance pressure.</li><li><strong>Surveillance HDD:</strong> Sized for 24/7 write-heavy cycles. Features firmware to minimize frame loss.</li></ul>" },
            @{ type="content"; title="Calculating Retention Schedules"; diagram="storage_retention_days"; bullets="<ul><li><strong>Retention:</strong> Designing system storage capacity to meet legal retention standards (typically 30 days minimum).</li></ul>" },
            @{ type="content"; title="Storage Calculator Software"; diagram="storage_calc_tool"; bullets="<ul><li><strong>Design Tool:</strong> Sizing utilities calculate exact hard drive capacity required for system layouts.</li></ul>" },
            @{ type="content"; title="Practical Lab Guide"; diagram="raid_rebuild_lab"; bullets="<div class='lab-block'><h3>Lab Work: Configure RAID Array</h3><ol><li>Boot server console, select RAID configuration utility.</li><li>Link three disk drives to build a RAID 5 array.</li><li>Simulate disk failure by unplugging a drive, confirm live system continues running.</li></ol></div>" }
        )
    },

    # Session 19: ONVIF Standards
    @{
        num = 19
        title = "ONVIF Standards"
        accent_color = "#10b981"
        accent_glow = "rgba(16, 185, 129, 0.4)"
        diagram = "onvif_compatibility"
        slides = @(
            @{ type="title"; title="ONVIF Standards & Profiles" },
            @{ type="content"; title="What is ONVIF?"; diagram="onvif_organization"; bullets="<ul><li><strong>Definition:</strong> Open Network Video Interface Forum. Standardizes network protocols for IP security devices.</li><li><strong>Interoperability:</strong> Enables cross-brand communication (e.g. Dahua camera feeding Hikvision NVR).</li></ul>" },
            @{ type="content"; title="ONVIF Profile S"; diagram="profile_s_features"; bullets="<ul><li><strong>Video Streaming:</strong> Standardizes IP video feeds, audio transmission, and PTZ controls.</li><li><strong>Core standard:</strong> Mandatory profile for linking third-party cameras to NVRs.</li></ul>" },
            @{ type="content"; title="ONVIF Profile G"; diagram="profile_g_features"; bullets="<ul><li><strong>Edge Storage:</strong> Standardizes searching and retrieving video stored on camera SD cards.</li><li><strong>Redundancy:</strong> Restores lost NVR video from SD card backup when network links drop.</li></ul>" },
            @{ type="content"; title="ONVIF Profile T"; diagram="profile_t_features"; bullets="<ul><li><strong>Smart Analytics:</strong> Standardizes metadata exchange for advanced analytics (line crossing, face capture).</li><li><strong>H.265 Support:</strong> Integrates H.265 video compression support across third-party links.</li></ul>" },
            @{ type="content"; title="ONVIF Device Discovery"; diagram="discovery_multicast"; bullets="<ul><li><strong>Discovery:</strong> NVRs send multicast discovery packets (WS-Discovery) to locate third-party cameras.</li><li><strong>Subnet Rule:</strong> Devices must reside on the same network subnet to discover each other automatically.</li></ul>" },
            @{ type="content"; title="ONVIF User Accounts"; diagram="onvif_user_auth"; bullets="<ul><li><strong>Authentication:</strong> Third-party cameras require creating dedicated ONVIF users and passwords.</li><li><strong>Security:</strong> Standard camera logins are blocked by default for ONVIF links in modern firmware.</li></ul>" },
            @{ type="content"; title="Common Integration Pitfalls"; diagram="onvif_debugging_ports"; bullets="<ul><li><strong>Incompatibility:</strong> Mixed brands can cause PTZ control lag or loss of AI analytics profiles.</li><li><strong>Port Mismatch:</strong> ONVIF connection ports (typically 80, 8000, or 8080) must match NVR config settings.</li></ul>" },
            @{ type="content"; title="Troubleshooting Tools"; diagram="odm_software_gui"; bullets="<ul><li><strong>ONVIF Device Manager:</strong> Open-source PC tool to discover, configure, and audit third-party IP feeds.</li></ul>" },
            @{ type="content"; title="Practical Lab Guide"; diagram="onvif_setup_lab"; bullets="<div class='lab-block'><h3>Lab Work: Third-Party ONVIF Setup</h3><ol><li>Login to third-party IP camera web interface, create an ONVIF user account.</li><li>Configure ONVIF port settings on camera.</li><li>Add camera to main NVR using the custom ONVIF profile, verify video and PTZ controls.</li></ol></div>" }
        )
    },

    # Session 20: Video Compression
    @{
        num = 20
        title = "Video Compression"
        accent_color = "#f59e0b"
        accent_glow = "rgba(245, 158, 11, 0.4)"
        diagram = "compression_h265"
        slides = @(
            @{ type="title"; title="Video Compression (H.264/H.265)" },
            @{ type="content"; title="What is Compression?"; diagram="compression_ratio"; bullets="<ul><li><strong>Need:</strong> Raw high-definition video feeds consume massive amounts of network bandwidth and storage space.</li><li><strong>Codec:</strong> Compression algorithms shrink video file sizes without losing critical image details.</li></ul>" },
            @{ type="content"; title="H.264 Codec Standard"; diagram="h264_macroblock"; bullets="<ul><li><strong>Legacy Standard:</strong> Highly compatible codec. Sized for legacy IP networks.</li><li><strong>Bandwidth:</strong> High bitrates required for megapixel streams.</li></ul>" },
            @{ type="content"; title="H.265 Codec Standard"; diagram="h265_ctu"; bullets="<ul><li><strong>HEVC:</strong> High Efficiency Video Coding.</li><li><strong>Efficiency:</strong> Cuts bandwidth and storage requirements by 50% compared to H.264 while retaining identical resolution quality.</li></ul>" },
            @{ type="content"; title="Smart Codecs (H.265+)"; diagram="smart_codec_background"; bullets="<ul><li><strong>Adaptive Coding:</strong> Analyzes background scenes; updates only moving objects while keeping static backgrounds compressed.</li><li><strong>Extreme Savings:</strong> Reduces bandwidth by up to 80% on quiet security areas.</li></ul>" },
            @{ type="content"; title="I-Frames & P-Frames"; diagram="gop_structure"; bullets="<ul><li><strong>I-Frame:</strong> Intra-frame. A complete, uncompressed reference image frame.</li><li><strong>P-Frame:</strong> Predicted frame. Records only pixel changes since the last I-Frame.</li></ul>" },
            @{ type="content"; title="CBR vs. VBR Profiles"; diagram="cbr_vs_vbr"; bullets="<ul><li><strong>CBR (Constant Bitrate):</strong> Fixed bandwidth draw. Predictable storage sizing, but wastes bandwidth during quiet hours.</li><li><strong>VBR (Variable Bitrate):</strong> Adapts bandwidth based on scene activity. Saves storage during quiet periods.</li></ul>" },
            @{ type="content"; title="Frame Rate (FPS) Sizing"; diagram="fps_bandwidth"; bullets="<ul><li><strong>FPS (Frames Per Second):</strong> Sized for action (30 FPS = fluid, 15 FPS = security standard).</li><li><strong>Storage Impact:</strong> Higher frame rates double storage requirements.</li></ul>" },
            @{ type="content"; title="Resolution Impact on Bandwidth"; diagram="resolution_grid"; bullets="<ul><li><strong>Scaling:</strong> Megapixel scaling (2MP 1080p, 5MP, 8MP 4K).</li><li><strong>Sizing:</strong> Double resolution requires twice the data flow without codec adjustments.</li></ul>" },
            @{ type="content"; title="Practical Lab Guide"; diagram="compression_lab"; bullets="<div class='lab-block'><h3>Lab Work: Bandwidth Optimization</h3><ol><li>Connect IP camera, monitor live stream bandwidth draw under H.264.</li><li>Change camera compression profile to H.265, document bandwidth savings.</li><li>Enable smart codec (H.265+), measure bitrate drops during static scene.</li></ol></div>" }
        )
    },

    # Session 21: AI Analytics
    @{
        num = 21
        title = "AI Analytics"
        accent_color = "#ef4444"
        accent_glow = "rgba(239, 68, 68, 0.4)"
        diagram = "ai_analytics"
        slides = @(
            @{ type="title"; title="AI Analytics & Perimeter Security" },
            @{ type="content"; title="AI vs. Standard Motion Detection"; diagram="motion_pixel_grid"; bullets="<ul><li><strong>Motion Detection:</strong> Triggers on simple pixel changes (causes false alarms from rain, shadows, insects).</li><li><strong>AI Analytics:</strong> Identifies target attributes by matching shapes to trained neural network profiles.</li></ul>" },
            @{ type="content"; title="Line Crossing Detection"; diagram="line_crossing_tripwire"; bullets="<ul><li><strong>Tripwire:</strong> Virtual boundaries drawn on screens.</li><li><strong>Directional Filter:</strong> Triggers alerts only when objects cross in a specific direction (A to B, B to A, or both).</li></ul>" },
            @{ type="content"; title="Intrusion Zone Detection"; diagram="intrusion_zone_area"; bullets="<ul><li><strong>Area Defense:</strong> Drawing virtual boxes around secure perimeters.</li><li><strong>Dwell Time:</strong> Triggers alerts only if targets linger inside zones for more than a set time (e.g. 5 seconds).</li></ul>" },
            @{ type="content"; title="Object Classification"; diagram="object_classifier_labels"; bullets="<ul><li><strong>Human Filter:</strong> Filters out false alarms from wind and dogs, triggering only on human shapes.</li><li><strong>Vehicle Filter:</strong> Triggers alerts only on cars/bikes entering secure gates.</li></ul>" },
            @{ type="content"; title="False Alarm Filtering (AcuSense)"; diagram="leaf_wind_filter"; bullets="<ul><li><strong>Scene Analysis:</strong> Algorithms ignore background movement like swaying tree branches or falling leaves.</li><li><strong>Saves Time:</strong> Restricts alerts to real target threats.</li></ul>" },
            @{ type="content"; title="Smart Search Engine"; diagram="smart_search_results"; bullets="<ul><li><strong>Metadata:</strong> Video recorded with descriptive tags (e.g., Human, Red Vehicle).</li><li><strong>Retrieval:</strong> Allows operators to search through days of video instantly by filtering for tags.</li></ul>" },
            @{ type="content"; title="Alarm Action Triggers"; diagram="alarm_relay_wiring"; bullets="<ul><li><strong>Actions:</strong> Email notifications, NVR buzzer warnings, spotlight triggers, and physical relay lock controls.</li></ul>" },
            @{ type="content"; title="Designing Perimeter Zones"; diagram="camera_mounting_angle"; bullets="<ul><li><strong>Camera Sizing:</strong> Cameras must be mounted at proper heights and angles to prevent target overlap.</li></ul>" },
            @{ type="content"; title="Practical Lab Guide"; diagram="ai_analytics_lab"; bullets="<div class='lab-block'><h3>Lab Work: Smart Zone Setup</h3><ol><li>Access NVR smart menu, draw an intrusion zone around mock entryway.</li><li>Enable human classification filter.</li><li>Walk through zone, confirm system triggers alert buzzer only on human entry.</li></ol></div>" }
        )
    },

    # Session 22: ANPR
    @{
        num = 22
        title = "ANPR"
        accent_color = "#3b82f6"
        accent_glow = "rgba(59, 130, 246, 0.4)"
        diagram = "anpr_fov"
        slides = @(
            @{ type="title"; title="ANPR (Plate Recognition)" },
            @{ type="content"; title="ANPR Cameras"; diagram="anpr_camera_optics"; bullets="<ul><li><strong>ANPR Engine:</strong> Automatic Number Plate Recognition. Optimized optical sensors designed to isolate license plates.</li><li><strong>High Contrast:</strong> B&W sensor modes reject vehicle headlights to capture plate text.</li></ul>" },
            @{ type="content"; title="Shutter Speed Calibration"; diagram="shutter_speed_compare"; bullets="<ul><li><strong>High Speed:</strong> Normal camera shutter speeds (1/50s) produce blurred plates on moving cars.</li><li><strong>ANPR Shutter:</strong> Enforce fast shutter speeds (1/1000s minimum) to capture clean plates of vehicles in motion.</li></ul>" },
            @{ type="content"; title="Mounting Height & Angles"; diagram="mounting_angles_grid"; bullets="<ul><li><strong>Angle Limits:</strong> Vertical and horizontal camera mounting angles must not exceed 30 degrees.</li><li><strong>Alignment:</strong> Steeper camera angles distort plate text, causing recognition failures.</li></ul>" },
            @{ type="content"; title="License Plate Illumination"; diagram="plate_ir_reflection"; bullets="<ul><li><strong>Reflective plates:</strong> IR LEDs reflect off license plate coatings.</li><li><strong>Highlight Compensation:</strong> Restricts headlight glare from washing out plate details.</li></ul>" },
            @{ type="content"; title="ANPR Database Lists"; diagram="anpr_database_match"; bullets="<ul><li><strong>Whitelist:</strong> Registered client vehicles. Triggers relay to open boom barrier gates automatically.</li><li><strong>Blacklist:</strong> Flagged vehicles. Triggers immediate alarm alerts on security monitors.</li></ul>" },
            @{ type="content"; title="Barrier Relay Triggers"; diagram="gate_relay_control"; bullets="<ul><li><strong>Wiring:</strong> Connect camera relay output ports to boom barrier gate control boards.</li><li><strong>Trigger Logic:</strong> Logic rules pulse relay switch to open gates for whitelisted plates.</li></ul>" },
            @{ type="content"; title="Vehicle Statistics"; diagram="vehicle_flow_graph"; bullets="<ul><li><strong>Flow Sizing:</strong> ANPR servers log arrival timestamps, vehicle counts, and calculate average speed stats.</li></ul>" },
            @{ type="content"; title="Debugging ANPR Failures"; diagram="anpr_troubleshooting"; bullets="<ul><li><strong>Audit:</strong> Clean lenses, adjust shutter speeds for night glare, and check camera angles.</li></ul>" },
            @{ type="content"; title="Practical Lab Guide"; diagram="anpr_lab"; bullets="<div class='lab-block'><h3>Lab Work: Wire ANPR Gate Loop</h3><ol><li>Mount ANPR camera at entry gate template.</li><li>Set shutter speed to 1/1000s, adjust focus to target lane.</li><li>Load test license plate onto whitelist, wire relay port to gate controller to trigger open.</li></ol></div>" }
        )
    },

    # Session 23: Facial Recognition
    @{
        num = 23
        title = "Facial Recognition"
        accent_color = "#10b981"
        accent_glow = "rgba(16, 185, 129, 0.4)"
        diagram = "face_pixels"
        slides = @(
            @{ type="title"; title="Facial Recognition Diagnostics" },
            @{ type="content"; title="Face Detection vs. Recognition"; diagram="face_detection_box"; bullets="<ul><li><strong>Detection:</strong> Simply locates a human face inside a video frame.</li><li><strong>Recognition:</strong> Compares facial features against database templates to identify individuals.</li></ul>" },
            @{ type="content"; title="Pixel Sizing Criteria"; diagram="eye_pixel_distance"; bullets="<ul><li><strong>Resolution target:</strong> Requires a minimum of 80 to 120 pixels between eyes for accurate facial recognition.</li><li><strong>Calculations:</strong> Lens focal lengths must be sized to achieve this pixel density at target distances.</li></ul>" },
            @{ type="content"; title="Facial Database Enrollment"; diagram="database_groups"; bullets="<ul><li><strong>Database:</strong> Storing user face profiles with clear, front-facing passport photos.</li><li><strong>Group Lists:</strong> Segment databases (Staff, Blacklist, VIPs).</li></ul>" },
            @{ type="content"; title="Similarity Thresholds"; diagram="similarity_confidence"; bullets="<ul><li><strong>Confidence:</strong> Set similarity thresholds (e.g. 85%).</li><li><strong>False Match Tradeoff:</strong> Setting confidence values too high causes missed matches; too low causes false alarms.</li></ul>" },
            @{ type="content"; title="Lighting Compensation"; diagram="lighting_compensation"; bullets="<ul><li><strong>Backlight Issues:</strong> Shadows on faces degrade recognition accuracy.</li><li><strong>WDR & Lighting:</strong> Enforce front-facing fill lights and True WDR settings at entryways.</li></ul>" },
            @{ type="content"; title="Blacklist Alert Triggers"; diagram="blacklist_siren_trigger"; bullets="<ul><li><strong>Rules:</strong> System matches stranger faces to blacklists, instantly triggering email alerts or security buzzers.</li></ul>" },
            @{ type="content"; title="Searching by Face Image"; diagram="snapshot_search"; bullets="<ul><li><strong>Smart Query:</strong> Upload a snapshot of a stranger to search hours of NVR history for matches.</li></ul>" },
            @{ type="content"; title="Database Management"; diagram="gdpr_privacy"; bullets="<ul><li><strong>Privacy limits:</strong> Compliance regulations mandate secure encryption and auto-deletion policies for facial databases.</li></ul>" },
            @{ type="content"; title="Practical Lab Guide"; diagram="facial_rec_lab"; bullets="<div class='lab-block'><h3>Lab Work: Facial Database Config</h3><ol><li>Setup facial capture camera at doorway.</li><li>Enroll student photo profiles into NVR database.</li><li>Configure similarity threshold to 85%, test matching and blacklist buzzer triggers.</li></ol></div>" }
        )
    },

    # Session 24: ColorVu, AcuSense & Thermal
    @{
        num = 24
        title = "ColorVu AcuSense Thermal"
        accent_color = "#f59e0b"
        accent_glow = "rgba(245, 158, 11, 0.4)"
        diagram = "colorvu_thermal"
        slides = @(
            @{ type="title"; title="ColorVu, AcuSense & Thermal Cameras" },
            @{ type="content"; title="ColorVu Night Technology"; diagram="colorvu_lens_f1"; bullets="<ul><li><strong>Super Aperture:</strong> F1.0 lenses collect four times more light than standard security lenses.</li><li><strong>Supplemental Light:</strong> Soft warm LED lights provide illumination to capture full-color images in pitch darkness.</li></ul>" },
            @{ type="content"; title="AcuSense Analytics"; diagram="acusense_classification"; bullets="<ul><li><strong>Classification:</strong> Advanced chips classify humans and vehicles.</li><li><strong>False Alarms:</strong> Ignores background movements like rain, leaves, and animals.</li></ul>" },
            @{ type="content"; title="Thermal Imaging Physics"; diagram="thermal_sensor_core"; bullets="<ul><li><strong>IR Heat Waves:</strong> Measures far-infrared heat radiation emitted by objects instead of visible light.</li><li><strong>Zero Light Needed:</strong> Unaffected by smoke, fog, dust, or absolute darkness.</li></ul>" },
            @{ type="content"; title="Thermal Fire Detection"; diagram="thermal_fire_alert"; bullets="<ul><li><strong>Early Warning:</strong> Detects hot spots and temperature spikes before visible smoke or flames appear.</li><li><strong>Rules:</strong> Set temperature threshold alarms (e.g. alert if target rises above 60°C).</li></ul>" },
            @{ type="content"; title="Bi-Spectrum Cameras"; diagram="bispectrum_fusion"; bullets="<ul><li><strong>Dual Optical:</strong> Combines a visible lens and a thermal lens in one camera housing.</li><li><strong>Overlays:</strong> Overlays thermal heat maps onto standard video feeds.</li></ul>" },
            @{ type="content"; title="Long-Range Perimeter Protection"; diagram="perimeter_thermal_fence"; bullets="<ul><li><strong>Thermal Range:</strong> Thermal sensors can detect human shapes at distances exceeding 1km, ideal for border fences.</li></ul>" },
            @{ type="content"; title="Temperature Threshold Audits"; diagram="thermal_temp_graph"; bullets="<ul><li><strong>Industrial Use:</strong> Monitor high-voltage busbars, electrical panels, and transformers to prevent fires.</li></ul>" },
            @{ type="content"; title="Specialized Mounts & Alignments"; diagram="thermal_obstructions"; bullets="<ul><li><strong>Thermal Alignment:</strong> Align thermal sensors to clear physical obstructions that block heat waves.</li></ul>" },
            @{ type="content"; title="Practical Lab Guide"; diagram="thermal_lab"; bullets="<div class='lab-block'><h3>Lab Work: Thermal Hot Spot Setup</h3><ol><li>Connect bi-spectrum thermal camera to test monitor.</li><li>Draw a temperature measuring box over a target area.</li><li>Bring a heat source (soldering iron) into the box, verify NVR alarm triggers at set threshold.</li></ol></div>" }
        )
    },

    # Session 25: PTZ Cameras
    @{
        num = 25
        title = "PTZ Cameras"
        accent_color = "#ef4444"
        accent_glow = "rgba(239, 68, 68, 0.4)"
        diagram = "ptz_mechanics"
        slides = @(
            @{ type="title"; title="PTZ Cameras & Patrols" },
            @{ type="content"; title="PTZ pan/tilt mechanics"; diagram="ptz_slip_ring"; bullets="<ul><li><strong>Pan/Tilt Motors:</strong> Built-in geared servo motors allow cameras to rotate 360° continuously and tilt up/down.</li><li><strong>Slip Rings:</strong> Allow internal wires to spin continuously without twisting or breaking.</li></ul>" },
            @{ type="content"; title="Optical Zoom Ratios"; diagram="zoom_lenses"; bullets="<ul><li><strong>Zoom Rating:</strong> Rated in zoom multipliers (e.g. 25x, 32x, 48x).</li><li><strong>Telephoto range:</strong> A 32x optical zoom lens can read license plates from distances exceeding 200m.</li></ul>" },
            @{ type="content"; title="PTZ Preset Coordinates"; diagram="ptz_preset_coords"; bullets="<ul><li><strong>Presets:</strong> Programmed coordinate positions (Pan, Tilt, and Zoom values) saved in camera memory.</li><li><strong>Speed:</strong> Allows operators to jump to pre-defined view points instantly.</li></ul>" },
            @{ type="content"; title="Patrol Tours (Sequence)"; diagram="ptz_patrol_tour"; bullets="<ul><li><strong>Tours:</strong> Programming a sequence of presets for the camera to monitor in order (e.g., Preset 1 for 10s, then Preset 2 for 20s).</li></ul>" },
            @{ type="content"; title="Auto-Tracking AI Logic"; diagram="autotracking_logic"; bullets="<ul><li><strong>Tracking:</strong> Camera algorithms detect moving human/vehicle targets and automatically pan, tilt, and zoom to keep them centered in the frame.</li></ul>" },
            @{ type="content"; title="RS485 Serial Control"; diagram="rs485_pelco_wiring"; bullets="<ul><li><strong>Legacy wiring:</strong> Uses 2-wire RS485 lines running Pelco-D/P protocols to control pan/tilt commands.</li><li><strong>IP Control:</strong> Modern IP PTZ cameras send control commands directly over the ethernet line.</li></ul>" },
            @{ type="content"; title="Joystick Controller Desks"; diagram="ptz_joystick_desk"; bullets="<ul><li><strong>Manual Control:</strong> 3-axis joysticks allow analog control of pan, tilt, and zoom speeds.</li></ul>" },
            @{ type="content"; title="Mechanical Limit Stops"; diagram="mechanical_limit_stops"; bullets="<ul><li><strong>Stops:</strong> Physical internal limit switches prevent pan/tilt motors from over-rotating and hitting mounts.</li></ul>" },
            @{ type="content"; title="Practical Lab Guide"; diagram="ptz_patrol_lab"; bullets="<div class='lab-block'><h3>Lab Work: Program PTZ Patrol</h3><ol><li>Wire PTZ camera to PoE switch and NVR.</li><li>Save 4 different coordinate presets (Gate, Fence, Door, Parking).</li><li>Program a patrol tour linking the presets with 10-second dwell times.</li></ol></div>" }
        )
    },

    # Session 26: Remote Viewing & Cloud
    @{
        num = 26
        title = "Remote Viewing Cloud"
        accent_color = "#3b82f6"
        accent_glow = "rgba(59, 130, 246, 0.4)"
        diagram = "cloud_p2p"
        slides = @(
            @{ type="title"; title="Remote Viewing & Cloud Systems" },
            @{ type="content"; title="Cloud P2P Connection Engine"; diagram="p2p_handshake"; bullets="<ul><li><strong>P2P Service:</strong> Peer-to-Peer servers link local NVRs and remote mobile phones without complex router configurations.</li><li><strong>NAT Traversal:</strong> Securely bypasses firewall port blocks.</li></ul>" },
            @{ type="content"; title="QR Code Registration"; diagram="qr_code_scan"; bullets="<ul><li><strong>Registration:</strong> NVR outputs a unique QR code containing its serialized cloud ID.</li><li><strong>Mobile link:</strong> Scanning the QR code links the NVR to the mobile application instantly.</li></ul>" },
            @{ type="content"; title="Dynamic DNS (DDNS) Setup"; diagram="ddns_resolution"; bullets="<ul><li><strong>DDNS:</strong> Maps a dynamic WAN IP to a permanent domain name (e.g. cctv.ddns.org).</li><li><strong>Direct Link:</strong> Enforces direct client-to-NVR connection, bypassing cloud server relays.</li></ul>" },
            @{ type="content"; title="Port Forwarding Safety"; diagram="port_forwarding_tunnel"; bullets="<ul><li><strong>WAN to LAN rules:</strong> Forward only necessary ports (e.g. RTSP port 554, Server port 8000).</li><li><strong>Vulnerabilities:</strong> Open ports are targets for hackers; always change default port numbers.</li></ul>" },
            @{ type="content"; title="Stream Profiles: Main vs. Sub"; diagram="stream_profiles"; bullets="<ul><li><strong>Main Stream:</strong> High resolution/frame rate. Used for local recording.</li><li><strong>Sub Stream:</strong> Low resolution/bitrate. Used for multi-camera mobile layouts to conserve cellular data.</li></ul>" },
            @{ type="content"; title="Push Notifications Alert Rules"; diagram="push_notification_flow"; bullets="<ul><li><strong>Real-time alerts:</strong> Configures the NVR to send instant alerts to mobile apps when AI line-crossings trigger.</li></ul>" },
            @{ type="content"; title="Multi-Site VMS Client Software"; diagram="vms_central_station"; bullets="<ul><li><strong>VMS (Video Management Software):</strong> Central control software to view and manage multiple NVR locations from a single screen.</li></ul>" },
            @{ type="content"; title="Bandwidth Sizing Calculations"; diagram="isp_upload_bandwidth"; bullets="<ul><li><strong>ISP Upload Limit:</strong> Ensure the site's internet upload speed can support the remote sub-stream bandwidth requirements.</li></ul>" },
            @{ type="content"; title="Practical Lab Guide"; diagram="remote_viewing_lab"; bullets="<div class='lab-block'><h3>Lab Work: Cloud Mobile App Link</h3><ol><li>Connect NVR to internet router, verify cloud status reads Online.</li><li>Download mobile app, scan NVR QR code to link device.</li><li>Configure dual stream profiles, verify remote playback and mobile alerts.</li></ol></div>" }
        )
    },

    # Session 27: Cybersecurity
    @{
        num = 27
        title = "Cybersecurity"
        accent_color = "#10b981"
        accent_glow = "rgba(16, 185, 129, 0.4)"
        diagram = "cyber_security"
        slides = @(
            @{ type="title"; title="CCTV Cybersecurity Standards" },
            @{ type="content"; title="CCTV Vulnerabilities"; diagram="cctv_hacking_vectors"; bullets="<ul><li><strong>Targets:</strong> Default firmware and open ports are targets for botnets and hackers.</li><li><strong>Risks:</strong> Accessing camera feeds, hijacking local subnets, and NVR code exploits.</li></ul>" },
            @{ type="content"; title="Password Complexity Rules"; diagram="password_rules"; bullets="<ul><li><strong>Rules:</strong> Modern firmware blocks standard defaults (e.g., admin123).</li><li><strong>Pass Enforcements:</strong> Mandates complex passwords combining letters, numbers, and special characters.</li></ul>" },
            @{ type="content"; title="Changing Default Ports"; diagram="custom_port_mapping"; bullets="<ul><li><strong>Standard Ports:</strong> Ports 80 (HTTP), 8000 (Server), 554 (RTSP), 23 (Telnet).</li><li><strong>Port Customization:</strong> Change standard default ports to random high ports (e.g. HTTP to 8585) to block automated hackers.</li></ul>" },
            @{ type="content"; title="Disabling UPnP & Telnet"; diagram="upnp_vulnerability"; bullets="<ul><li><strong>UPnP Danger:</strong> Universal Plug and Play opens router ports automatically, bypassing firewalls. Disabling UPnP is critical.</li><li><strong>Telnet:</strong> Disable insecure telnet ports to prevent command terminal bypasses.</li></ul>" },
            @{ type="content"; title="HTTPS Certificate Installation"; diagram="https_ssl_handshake"; bullets="<ul><li><strong>Encryption:</strong> Standard HTTP sends credentials in plain text. Enabling HTTPS encrypts NVR login traffic.</li><li><strong>Certificates:</strong> Install self-signed security certificates on NVR motherboards.</li></ul>" },
            @{ type="content"; title="IP Address Access Filtering"; diagram="ip_whitelisting"; bullets="<ul><li><strong>Access Whitelisting:</strong> Limit NVR connection access to approved administrator IP addresses only.</li></ul>" },
            @{ type="content"; title="User Roles & Permissions"; diagram="user_privileges"; bullets="<ul><li><strong>Permissions:</strong> Restrict guest operators to live views only, blocking access to hard drive formatting or recording settings.</li></ul>" },
            @{ type="content"; title="Firmware Updates"; diagram="firmware_patching"; bullets="<ul><li><strong>Patches:</strong> Regularly flash the latest firmware updates to patch newly discovered security holes.</li></ul>" },
            @{ type="content"; title="Practical Lab Guide"; diagram="cybersecurity_lab"; bullets="<div class='lab-block'><h3>Lab Work: Hardening IP NVR</h3><ol><li>Login to NVR settings, disable UPnP options.</li><li>Change standard HTTP port 80 and server port 8000 to custom port numbers.</li><li>Create limited operator profiles with live-view-only permissions.</li></ol></div>" }
        )
    },

    # Session 28: Troubleshooting & Maintenance
    @{
        num = 28
        title = "Troubleshooting Maintenance"
        accent_color = "#ef4444"
        accent_glow = "rgba(239, 68, 68, 0.4)"
        diagram = "cctv_faults"
        slides = @(
            @{ type="title"; title="CCTV Troubleshooting & Maintenance" },
            @{ type="content"; title="No Video Diagnostics"; diagram="no_video_diagnostic"; bullets="<ul><li><strong>Checklist:</strong> Measure power supply output, audit switch PoE LEDs, test cable continuity, and check NVR channel status.</li></ul>" },
            @{ type="content"; title="IP Address Mismatch Clashes"; diagram="ip_clash_detection"; bullets="<ul><li><strong>Duplicate IPs:</strong> Mismatch when two cameras are assigned the same IP. Disconnects both.</li><li><strong>Resolution:</strong> Run IP scanners to find duplicate IP/MAC conflicts.</li></ul>" },
            @{ type="content"; title="Video Packet Loss Dropouts"; diagram="packet_loss_graph"; bullets="<ul><li><strong>Symptoms:</strong> Frame drops, video freeze, or stuttering feeds.</li><li><strong>Causes:</strong> High network traffic, damaged RJ45 terminations, or exceed PoE distance limits.</li></ul>" },
            @{ type="content"; title="IR Halo Ring Reflections"; diagram="ir_reflection_halo"; bullets="<ul><li><strong>Reflection:</strong> IR light reflecting off dust, scratches, or greasy fingerprints on dome glass covers.</li><li><strong>Solution:</strong> Clean covers, inspect foam lens ring seals, and adjust angles to avoid reflecting nearby walls.</li></ul>" },
            @{ type="content"; title="Ground Loop Video Hum Bars"; diagram="ground_loop_hum"; bullets="<ul><li><strong>Hum Bars:</strong> Scrolling horizontal lines on analog video.</li><li><strong>Causes:</strong> Voltage differences between ground points. Solved using ground loop isolators.</li></ul>" },
            @{ type="content"; title="Camera Focus Adjustments"; diagram="focus_drift"; bullets="<ul><li><strong>Calibration:</strong> Lenses drift out of focus over time from mechanical vibrations. Re-focus via NVR zoom settings.</li></ul>" },
            @{ type="content"; title="Firmware Recovery Loops"; diagram="tftp_firmware_recovery"; bullets="<ul><li><strong>Brick recovery:</strong> Recover NVRs frozen in boot loops using TFTP servers and serial consoles.</li></ul>" },
            @{ type="content"; title="Physical Cleaning & Maintenance Tools"; diagram="physical_cleaning_tools"; bullets="<ul><li><strong>Cleaning kit:</strong> Essential micro-cloth wipes, hand air-blowers, and cleaning sprays preserve image quality over time.</li></ul>" },
            @{ type="content"; title="Maintenance Schedules"; diagram="troubleshooting_lab"; bullets="<ul><li><strong>Periodic Tasks:</strong> Clean lenses, blow dust from NVR fan grills, verify backup battery potentials, and review hard drive SMART logs.</li></ul>" },
            @{ type="content"; title="Practical Lab Guide"; diagram="troubleshooting_lab"; bullets="<div class='lab-block'><h3>Lab Work: CCTV Fault Finding</h3><ol><li>Diagnose an offline camera using IP scanners.</li><li>Install a ground loop isolator to resolve analog hum bar noise.</li><li>Clean dome glass to resolve IR halo reflections.</li></ol></div>" }
        )
    }
)

# Loop and build files
foreach ($session in $sessions) {
    $slides_html = ""
    $s_idx = 1
    
    foreach ($slide in $session.slides) {
        $active_class = ""
        if ($s_idx -eq 1) { $active_class = " active" }
        
        if ($slide.type -eq "title") {
            $slides_html += @"
  <!-- Slide $s_idx -->
  <div class="slide$active_class title-slide">
    <div class="slide-tag">Module 2 - Session $($session.num)</div>
    <h1>$($slide.title)</h1>
    <h2>$($session.title)</h2>
    <div class="instructor-tag">Low-Voltage Systems & Automation Training Series</div>
  </div>
"@
        } else {
            $diag_type = $session.diagram
            if ($slide.diagram) { $diag_type = $slide.diagram }
            $svg_content = Get-DiagramSvg -type $diag_type
            $slides_html += @"
  <!-- Slide $s_idx -->
  <div class="slide$active_class">
    <div class="slide-header">
      <div class="slide-tag">Session $($session.num) - Slide $s_idx</div>
      <div class="slide-counter">Slide $s_idx of $($session.slides.Count)</div>
    </div>
    <h2 class="slide-title">$($slide.title)</h2>
    <div class="slide-body">
      <div class="text-content">
        $($slide.bullets)
      </div>
      <div class="visual-content">
        $svg_content
      </div>
    </div>
  </div>
"@
        }
        $s_idx++
    }
    
    $file_content = $template -replace '\{session_num\}', $session.num
    $file_content = $file_content -replace '\{session_title\}', $session.title
    $file_content = $file_content -replace '\{accent_color\}', $session.accent_color
    $file_content = $file_content -replace '\{accent_glow\}', $session.accent_glow
    $file_content = $file_content -replace '\{slides_html\}', $slides_html
    
    $filename = "m2_s$($session.num)_$($session.title.ToLower().Replace(' ', '_').Replace('&', '').Replace('__', '_')).html"
    $filepath = "$outputDir\$filename"
    Set-Content -Path $filepath -Value $file_content -Encoding utf8
    Write-Host "Generated $filename"
}

Write-Host "Module 2 Slide Generation completed successfully."
