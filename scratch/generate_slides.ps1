$outputDir = "c:\Users\asadu\Downloads\Quick Share\BotGI\slides"
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir -Force
}

# Clean old slides
Remove-Item -Path "$outputDir\m1_s*.html" -ErrorAction SilentlyContinue
Remove-Item -Path "$outputDir\m1_d*.html" -ErrorAction SilentlyContinue

$template = @"
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Session {session_num}: {session_title}</title>
<style>
  :root {
    --bg-color: #0b0f19;
    --card-bg: rgba(20, 30, 55, 0.6);
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
  localStorage.setItem('lastViewedModule', 'm1');
</script>
</body>
</html>
"@

function Get-DiagramSvg([string]$type) {
    switch ($type) {
        "two_way_switch" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="20" y="50" width="35" height="50" rx="4" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <circle cx="37" cy="60" r="3" fill="#3b82f6"/>
  <circle cx="37" cy="75" r="3" fill="#f59e0b"/>
  <circle cx="37" cy="90" r="3" fill="#3b82f6"/>
  <rect x="145" y="50" width="35" height="50" rx="4" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <circle cx="148" cy="60" r="3" fill="#3b82f6"/>
  <circle cx="148" cy="75" r="3" fill="#f59e0b"/>
  <circle cx="148" cy="90" r="3" fill="#3b82f6"/>
  <line x1="37" y1="60" x2="148" y2="60" stroke="#f3f4f6" stroke-width="1.5" stroke-dasharray="3 3"/>
  <line x1="37" y1="90" x2="148" y2="90" stroke="#f3f4f6" stroke-width="1.5" stroke-dasharray="3 3"/>
  <line x1="37" y1="75" x2="37" y2="60" stroke="#ef4444" stroke-width="2"/>
  <line x1="148" y1="75" x2="148" y2="90" stroke="#ef4444" stroke-width="2"/>
  <circle cx="92" cy="75" r="10" fill="none" stroke="#f59e0b" stroke-width="2"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Staircase SPDT Loop</text>
</svg>
"@
        }
        "wire_crimp_ferrule" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <!-- Stripped wire -->
  <rect x="15" y="45" width="60" height="8" fill="#3b82f6"/>
  <rect x="75" y="45" width="20" height="8" fill="#f59e0b"/> <!-- copper strands -->
  <!-- Ferrule sleeve -->
  <rect x="110" y="42" width="25" height="14" fill="#9ca3af" rx="2"/>
  <rect x="135" y="45" width="20" height="8" fill="#10b981"/> <!-- pin sleeve -->
  <!-- Crimp Jaws template -->
  <path d="M 60 100 L 70 85 L 90 85 L 100 100 L 90 115 L 70 115 Z" fill="none" stroke="#ef4444" stroke-width="2"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Wire Strip & Bootlace Crimp</text>
</svg>
"@
        }
        "atom" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="75" r="15" fill="#f59e0b" opacity="0.8"/>
  <circle cx="95" cy="70" r="6" fill="#ef4444"/>
  <circle cx="105" cy="78" r="6" fill="#3b82f6"/>
  <circle cx="102" cy="68" r="6" fill="#ef4444"/>
  <circle cx="94" cy="79" r="6" fill="#3b82f6"/>
  <ellipse cx="100" cy="75" rx="60" ry="25" fill="none" stroke="#6b7280" stroke-width="1.5" transform="rotate(30 100 75)"/>
  <ellipse cx="100" cy="75" rx="60" ry="25" fill="none" stroke="#6b7280" stroke-width="1.5" transform="rotate(-30 100 75)"/>
  <circle cx="48" cy="45" r="4" fill="#10b981"/>
  <circle cx="152" cy="105" r="4" fill="#10b981"/>
  <circle cx="48" cy="105" r="4" fill="#10b981"/>
  <circle cx="152" cy="45" r="4" fill="#10b981"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Atomic Structure Model</text>
</svg>
"@
        }
        "ohms_law" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <polygon points="100,20 40,120 160,120" fill="none" stroke="#3b82f6" stroke-width="3"/>
  <line x1="40" y1="75" x2="160" y2="75" stroke="#3b82f6" stroke-width="3"/>
  <line x1="100" y1="75" x2="100" y2="120" stroke="#3b82f6" stroke-width="3"/>
  <text x="100" y="55" fill="#f3f4f6" font-family="sans-serif" font-weight="bold" font-size="24" text-anchor="middle">V</text>
  <text x="70" y="105" fill="#ef4444" font-family="sans-serif" font-weight="bold" font-size="20" text-anchor="middle">I</text>
  <text x="130" y="105" fill="#f59e0b" font-family="sans-serif" font-weight="bold" font-size="20" text-anchor="middle">R</text>
  <text x="100" y="142" fill="#9ca3af" font-family="sans-serif" font-size="11" text-anchor="middle">V = I × R</text>
</svg>
"@
        }
        "resistance_heat" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <line x1="10" y1="75" x2="40" y2="75" stroke="#3b82f6" stroke-width="3"/>
  <path d="M 40 75 L 50 60 L 65 90 L 80 60 L 95 90 L 110 60 L 125 90 L 140 75" fill="none" stroke="url(#heatGradient)" stroke-width="4"/>
  <line x1="140" y1="75" x2="190" y2="75" stroke="#3b82f6" stroke-width="3"/>
  <path d="M 65 50 Q 70 40 65 30" fill="none" stroke="#ef4444" stroke-width="2" stroke-linecap="round"/>
  <path d="M 95 50 Q 100 40 95 30" fill="none" stroke="#f59e0b" stroke-width="2" stroke-linecap="round"/>
  <path d="M 125 50 Q 130 40 125 30" fill="none" stroke="#ef4444" stroke-width="2" stroke-linecap="round"/>
  <defs>
    <linearGradient id="heatGradient" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="#3b82f6"/>
      <stop offset="30%" stop-color="#ef4444"/>
      <stop offset="50%" stop-color="#f59e0b"/>
      <stop offset="70%" stop-color="#ef4444"/>
      <stop offset="100%" stop-color="#3b82f6"/>
    </linearGradient>
  </defs>
  <text x="100" y="125" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Heat Dissipation (I²R)</text>
</svg>
"@
        }
        "power_eq" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="70" r="50" fill="none" stroke="#10b981" stroke-width="3"/>
  <line x1="50" y1="70" x2="150" y2="70" stroke="#10b981" stroke-width="3"/>
  <line x1="100" y1="70" x2="100" y2="120" stroke="#10b981" stroke-width="3"/>
  <text x="100" y="55" fill="#f3f4f6" font-family="sans-serif" font-weight="bold" font-size="24" text-anchor="middle">P</text>
  <text x="75" y="102" fill="#3b82f6" font-family="sans-serif" font-weight="bold" font-size="20" text-anchor="middle">V</text>
  <text x="125" y="102" fill="#ef4444" font-family="sans-serif" font-weight="bold" font-size="20" text-anchor="middle">I</text>
  <text x="100" y="142" fill="#9ca3af" font-family="sans-serif" font-size="11" text-anchor="middle">P = V × I (Watts)</text>
</svg>
"@
        }
        "ac_dc_ripple" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <line x1="20" y1="10" x2="20" y2="130" stroke="#4b5563" stroke-width="1.5"/>
  <line x1="20" y1="70" x2="190" y2="70" stroke="#4b5563" stroke-width="1.5"/>
  <path d="M 20 70 Q 45 20 70 70 T 120 70" fill="none" stroke="#3b82f6" stroke-width="2" opacity="0.6"/>
  <line x1="20" y1="35" x2="190" y2="35" stroke="#10b981" stroke-width="2.5"/>
  <path d="M 20 50 Q 35 40 50 50 T 80 50 T 110 50 T 140 50 T 170 50" fill="none" stroke="#f59e0b" stroke-width="2"/>
  <text x="160" y="30" fill="#10b981" font-family="sans-serif" font-size="9">Pure DC</text>
  <text x="160" y="60" fill="#f59e0b" font-family="sans-serif" font-size="9">Ripple DC</text>
  <text x="45" y="105" fill="#3b82f6" font-family="sans-serif" font-size="9">AC Wave</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Conversion Profiles</text>
</svg>
"@
        }
        "color_code" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="30" y="55" width="140" height="40" rx="15" fill="#d1fae5" stroke="#10b981" stroke-width="2"/>
  <line x1="10" y1="75" x2="30" y2="75" stroke="#9ca3af" stroke-width="3"/>
  <line x1="170" y1="75" x2="190" y2="75" stroke="#9ca3af" stroke-width="3"/>
  <rect x="55" y="55" width="8" height="40" fill="#ef4444"/>
  <rect x="75" y="55" width="8" height="40" fill="#7c2d12"/>
  <rect x="95" y="55" width="8" height="40" fill="#eab308"/>
  <rect x="135" y="55" width="8" height="40" fill="#d4af37"/>
  <text x="100" y="125" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">4-Band Color Code</text>
</svg>
"@
        }
        "series_parallel" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <path d="M 15 45 L 30 45 L 35 35 L 45 55 L 55 35 L 65 55 L 70 45 L 85 45 L 90 35 L 100 55 L 110 35 L 120 55 L 125 45 L 140 45" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <text x="75" y="25" fill="#3b82f6" font-family="sans-serif" font-size="9" text-anchor="middle">Series (R1 + R2)</text>
  <line x1="15" y1="110" x2="35" y2="110" stroke="#10b981" stroke-width="2"/>
  <line x1="35" y1="95" x2="35" y2="125" stroke="#10b981" stroke-width="2"/>
  <path d="M 35 95 L 45 95 L 50 85 L 60 105 L 70 85 L 80 105 L 85 95 L 95 95" fill="none" stroke="#10b981" stroke-width="2"/>
  <path d="M 35 125 L 45 125 L 50 115 L 60 135 L 70 115 L 80 135 L 85 125 L 95 125" fill="none" stroke="#10b981" stroke-width="2"/>
  <line x1="95" y1="95" x2="95" y2="125" stroke="#10b981" stroke-width="2"/>
  <line x1="95" y1="110" x2="115" y2="110" stroke="#10b981" stroke-width="2"/>
  <text x="65" y="80" fill="#10b981" font-family="sans-serif" font-size="9" text-anchor="middle">Parallel (1/R_eq)</text>
  <text x="100" y="145" fill="#f3f4f6" font-family="sans-serif" font-size="10" text-anchor="middle">Resistor Configurations</text>
</svg>
"@
        }
        "circuit_loops" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="15" y="25" width="70" height="60" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <circle cx="35" cy="55" r="8" fill="rgba(245,158,11,0.2)" stroke="#f59e0b" stroke-width="1.5"/>
  <circle cx="65" cy="55" r="8" fill="rgba(245,158,11,0.2)" stroke="#f59e0b" stroke-width="1.5"/>
  <text x="50" y="105" fill="#3b82f6" font-family="sans-serif" font-size="9" text-anchor="middle">Series Loop</text>
  <rect x="110" y="25" width="70" height="60" fill="none" stroke="#10b981" stroke-width="2"/>
  <line x1="145" y1="25" x2="145" y2="85" stroke="#10b981" stroke-width="2"/>
  <circle cx="127" cy="55" r="8" fill="rgba(245,158,11,0.2)" stroke="#f59e0b" stroke-width="1.5"/>
  <circle cx="162" cy="55" r="8" fill="rgba(245,158,11,0.2)" stroke="#f59e0b" stroke-width="1.5"/>
  <text x="145" y="105" fill="#10b981" font-family="sans-serif" font-size="9" text-anchor="middle">Parallel Loop</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Electrical Circuits</text>
</svg>
"@
        }
        "circuit" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="10" y="10" width="180" height="130" fill="none" stroke="#3b82f6" stroke-width="3" stroke-dasharray="5 3"/>
  <line x1="10" y1="75" x2="60" y2="75" stroke="#3b82f6" stroke-width="3"/>
  <line x1="80" y1="75" x2="130" y2="75" stroke="#3b82f6" stroke-width="3"/>
  <line x1="60" y1="60" x2="60" y2="90" stroke="#f59e0b" stroke-width="4"/>
  <line x1="70" y1="68" x2="70" y2="82" stroke="#f59e0b" stroke-width="2"/>
  <line x1="80" y1="60" x2="80" y2="90" stroke="#f59e0b" stroke-width="4"/>
  <path d="M 130 75 L 140 65 L 150 85 L 160 65 L 170 85 L 180 75" fill="none" stroke="#ef4444" stroke-width="3"/>
  <line x1="180" y1="75" x2="190" y2="75" stroke="#3b82f6" stroke-width="3"/>
  <text x="70" y="45" fill="#f3f4f6" font-family="sans-serif" font-size="12" text-anchor="middle">DC Supply</text>
  <text x="155" y="45" fill="#f3f4f6" font-family="sans-serif" font-size="12" text-anchor="middle">Load (R)</text>
</svg>
"@
        }
        "earth_loop" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <line x1="10" y1="30" x2="190" y2="30" stroke="#ef4444" stroke-width="2"/>
  <line x1="10" y1="50" x2="190" y2="50" stroke="#3b82f6" stroke-width="2"/>
  <line x1="10" y1="120" x2="190" y2="120" stroke="#10b981" stroke-width="2"/>
  <rect x="60" y="70" width="80" height="35" rx="5" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <path d="M 70 30 L 70 70" stroke="#ef4444" stroke-width="1.5" stroke-dasharray="3 3"/>
  <path d="M 130 95 L 130 120" stroke="#10b981" stroke-width="2"/>
  <text x="100" y="88" fill="#9ca3af" font-family="sans-serif" font-size="9" text-anchor="middle">Metal Body</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Fault Loop Bypass</text>
</svg>
"@
        }
        "earth_types" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="20" y="80" width="30" height="40" fill="#f59e0b" opacity="0.8"/>
  <line x1="35" y1="30" x2="35" y2="80" stroke="#f59e0b" stroke-width="2"/>
  <text x="35" y="135" fill="#f59e0b" font-family="sans-serif" font-size="8" text-anchor="middle">Plate</text>
  <rect x="90" y="50" width="8" height="70" fill="#9ca3af"/>
  <line x1="94" y1="30" x2="94" y2="50" stroke="#9ca3af" stroke-width="2"/>
  <text x="94" y="135" fill="#9ca3af" font-family="sans-serif" font-size="8" text-anchor="middle">Pipe (GI)</text>
  <rect x="150" y="40" width="12" height="80" fill="none" stroke="#10b981" stroke-width="2"/>
  <line x1="156" y1="30" x2="156" y2="40" stroke="#10b981" stroke-width="2"/>
  <text x="156" y="135" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">Chemical Rod</text>
  <text x="100" y="15" fill="#f3f4f6" font-family="sans-serif" font-size="10" text-anchor="middle">Earthing Methods</text>
</svg>
"@
        }
        "earth_pit" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="30" y="30" width="140" height="110" fill="none" stroke="#4b5563" stroke-width="2" stroke-dasharray="3 3"/>
  <rect x="31" y="40" width="138" height="25" fill="#78350f" opacity="0.3"/>
  <rect x="31" y="65" width="138" height="25" fill="#1f2937" opacity="0.8"/>
  <rect x="31" y="90" width="138" height="25" fill="#f3f4f6" opacity="0.2"/>
  <rect x="96" y="20" width="8" height="110" fill="#9ca3af"/>
  <text x="100" y="146" fill="#f3f4f6" font-family="sans-serif" font-size="10" text-anchor="middle">Charcoal & Salt Layers</text>
</svg>
"@
        }
        "earth_meter" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <path d="M 40 100 A 70 70 0 0 1 160 100" fill="none" stroke="#ef4444" stroke-width="8"/>
  <path d="M 80 50 A 70 70 0 0 1 160 100" fill="none" stroke="#10b981" stroke-width="8"/>
  <line x1="100" y1="120" x2="130" y2="60" stroke="#f3f4f6" stroke-width="3" stroke-linecap="round"/>
  <circle cx="100" cy="120" r="8" fill="#9ca3af"/>
  <text x="55" y="80" fill="#ef4444" font-family="sans-serif" font-size="9">Fail</text>
  <text x="145" y="80" fill="#10b981" font-family="sans-serif" font-size="9">Pass</text>
  <text x="100" y="138" fill="#f3f4f6" font-family="sans-serif" font-weight="bold" font-size="14" text-anchor="middle">1.2 Ohms</text>
</svg>
"@
        }
        "lightning_rod" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="98" y="40" width="4" height="90" fill="#9ca3af"/>
  <circle cx="90" cy="50" r="6" fill="#f59e0b"/>
  <line x1="100" y1="20" x2="100" y2="40" stroke="#f3f4f6" stroke-width="3"/>
  <line x1="95" y1="25" x2="105" y2="25" stroke="#f3f4f6" stroke-width="1.5"/>
  <path d="M 102 30 L 105 130" fill="none" stroke="#10b981" stroke-width="2"/>
  <path d="M 120 5 L 105 15 L 100 20" fill="none" stroke="#eab308" stroke-width="3"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Spike & Ground Pathway</text>
</svg>
"@
        }
        "spd_wave" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <line x1="20" y1="75" x2="190" y2="75" stroke="#4b5563" stroke-width="1.5"/>
  <path d="M 20 75 Q 50 10 70 20 T 110 75" fill="none" stroke="#ef4444" stroke-width="2" stroke-dasharray="3 3"/>
  <path d="M 20 75 Q 50 50 70 50 L 90 50 Q 100 50 110 75" fill="none" stroke="#10b981" stroke-width="3"/>
  <text x="130" y="45" fill="#10b981" font-family="sans-serif" font-size="9">Clamped Level</text>
  <text x="60" y="15" fill="#ef4444" font-family="sans-serif" font-size="9">Surge Spike</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Transient Over-Voltage Clamping</text>
</svg>
"@
        }
        "spd_wiring" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="70" y="25" width="60" height="90" rx="4" fill="none" stroke="#f59e0b" stroke-width="3"/>
  <line x1="85" y1="10" x2="85" y2="25" stroke="#ef4444" stroke-width="2"/>
  <line x1="115" y1="10" x2="115" y2="25" stroke="#3b82f6" stroke-width="2"/>
  <line x1="100" y1="115" x2="100" y2="135" stroke="#10b981" stroke-width="2"/>
  <text x="85" y="45" fill="#ef4444" font-family="monospace" font-size="9" text-anchor="middle">L</text>
  <text x="115" y="45" fill="#3b82f6" font-family="monospace" font-size="9" text-anchor="middle">N</text>
  <text x="100" y="98" fill="#10b981" font-family="monospace" font-size="9" text-anchor="middle">PE</text>
  <text x="100" y="145" fill="#f3f4f6" font-family="sans-serif" font-size="10" text-anchor="middle">DIN-Rail SPD Connections</text>
</svg>
"@
        }
        "rack_ground" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="50" y="15" width="100" height="110" fill="none" stroke="#9ca3af" stroke-width="3"/>
  <rect x="60" y="115" width="80" height="5" fill="#10b981"/>
  <path d="M 65 30 L 65 115" stroke="#10b981" stroke-width="1.5"/>
  <path d="M 135 60 L 135 115" stroke="#10b981" stroke-width="1.5"/>
  <text x="100" y="70" fill="#9ca3af" font-family="sans-serif" font-size="11" text-anchor="middle">ELV Rack</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Frame Earth Bonding</text>
</svg>
"@
        }
        "test_lamp_circuit" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="50" r="16" fill="rgba(245, 158, 11, 0.2)" stroke="#f59e0b" stroke-width="2"/>
  <line x1="88" y1="38" x2="112" y2="62" stroke="#f59e0b" stroke-width="2"/>
  <line x1="88" y1="62" x2="112" y2="38" stroke="#f59e0b" stroke-width="2"/>
  <path d="M 84 50 L 30 110" fill="none" stroke="#ef4444" stroke-width="2"/>
  <path d="M 116 50 L 170 110" fill="none" stroke="#111827" stroke-width="2" stroke-dasharray="1 1"/>
  <circle cx="30" cy="110" r="4" fill="#ef4444"/>
  <circle cx="170" cy="110" r="4" fill="#111827" stroke="#9ca3af"/>
  <text x="30" y="130" fill="#ef4444" font-family="sans-serif" font-size="9" text-anchor="middle">Phase</text>
  <text x="170" y="130" fill="#9ca3af" font-family="sans-serif" font-size="9" text-anchor="middle">Earth</text>
  <text x="100" y="145" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Test Lamp Circuit</text>
</svg>
"@
        }
        "dmm_anatomy" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="65" y="15" width="70" height="115" rx="8" fill="none" stroke="#f59e0b" stroke-width="3"/>
  <rect x="75" y="25" width="50" height="25" fill="#1f2937" stroke="#4b5563"/>
  <text x="100" y="42" fill="#10b981" font-family="monospace" font-weight="bold" font-size="12" text-anchor="middle">0.00</text>
  <circle cx="100" cy="75" r="16" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <line x1="100" y1="75" x2="100" y2="62" stroke="#f59e0b" stroke-width="2.5" stroke-linecap="round"/>
  <circle cx="85" cy="115" r="4" fill="#ef4444"/>
  <circle cx="100" cy="115" r="4" fill="#1f2937" stroke="#9ca3af"/>
  <circle cx="115" cy="115" r="4" fill="#ef4444"/>
  <text x="100" y="145" fill="#f3f4f6" font-family="sans-serif" font-size="10" text-anchor="middle">DMM Anatomy</text>
</svg>
"@
        }
        "dmm_dial" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="70" r="45" fill="none" stroke="#4b5563" stroke-width="2"/>
  <text x="100" y="20" fill="#f3f4f6" font-family="sans-serif" font-size="9" text-anchor="middle">OFF</text>
  <text x="145" y="55" fill="#3b82f6" font-family="sans-serif" font-weight="bold" font-size="10">V~</text>
  <text x="135" y="95" fill="#ef4444" font-family="sans-serif" font-weight="bold" font-size="10">V=</text>
  <text x="65" y="95" fill="#f59e0b" font-family="sans-serif" font-weight="bold" font-size="10">Ω</text>
  <text x="50" y="55" fill="#10b981" font-family="sans-serif" font-weight="bold" font-size="9">BUZZ</text>
  <circle cx="100" cy="70" r="20" fill="#1f2937" stroke="#9ca3af"/>
  <line x1="100" y1="70" x2="100" y2="35" stroke="#f59e0b" stroke-width="4" stroke-linecap="round"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Function Dial</text>
</svg>
"@
        }
        "dmm_ports" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="30" y="45" width="140" height="60" rx="6" fill="none" stroke="#4b5563" stroke-width="2"/>
  <circle cx="55" cy="75" r="8" fill="#1f2937" stroke="#ef4444" stroke-width="2"/>
  <text x="55" y="60" fill="#ef4444" font-family="monospace" font-size="7" text-anchor="middle">10A</text>
  <circle cx="100" cy="75" r="8" fill="#1f2937" stroke="#9ca3af" stroke-width="2"/>
  <text x="100" y="60" fill="#9ca3af" font-family="monospace" font-size="7" text-anchor="middle">COM</text>
  <circle cx="145" cy="75" r="8" fill="#1f2937" stroke="#ef4444" stroke-width="2"/>
  <text x="145" y="60" fill="#ef4444" font-family="monospace" font-size="7" text-anchor="middle">V-Ω-mA</text>
  <text x="100" y="130" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Lead Input Ports</text>
</svg>
"@
        }
        "volt_measure" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="70" y="55" width="60" height="35" rx="3" fill="none" stroke="#f59e0b" stroke-width="2"/>
  <line x1="50" y1="72" x2="70" y2="72" stroke="#ef4444" stroke-width="2"/>
  <line x1="130" y1="72" x2="150" y2="72" stroke="#3b82f6" stroke-width="2"/>
  <line x1="50" y1="72" x2="50" y2="110" stroke="#ef4444" stroke-width="2"/>
  <line x1="150" y1="72" x2="150" y2="110" stroke="#3b82f6" stroke-width="2"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Parallel Voltage Measurement</text>
</svg>
"@
        }
        "ohm_measure" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="70" y="55" width="60" height="35" rx="3" fill="none" stroke="#f59e0b" stroke-width="2"/>
  <line x1="40" y1="72" x2="70" y2="72" stroke="#ef4444" stroke-width="2"/>
  <line x1="130" y1="72" x2="160" y2="72" stroke="#ef4444" stroke-width="2"/>
  <line x1="30" y1="72" x2="40" y2="72" stroke="#4b5563" stroke-width="1.5" stroke-dasharray="3 3"/>
  <line x1="160" y1="72" x2="170" y2="72" stroke="#4b5563" stroke-width="1.5" stroke-dasharray="3 3"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Power-OFF Isolated Measurement</text>
</svg>
"@
        }
        "continuity_test" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <path d="M 30 75 Q 100 75 170 75" fill="none" stroke="#10b981" stroke-width="2.5"/>
  <path d="M 90 45 Q 100 35 110 45" fill="none" stroke="#f59e0b" stroke-width="2"/>
  <path d="M 85 40 Q 100 25 115 40" fill="none" stroke="#f59e0b" stroke-width="1.5"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Audible Path Verification</text>
</svg>
"@
        }
        "socket_test" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="50" r="12" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <circle cx="80" cy="85" r="10" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <circle cx="120" cy="85" r="10" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Socket Terminal Probe Points</text>
</svg>
"@
        }
        "eol_loop" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="35" y="45" width="130" height="60" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <path d="M 85 45 L 95 45 L 100 35 L 105 55 L 110 35 L 115 55 L 120 45 L 130 45" fill="none" stroke="#f59e0b" stroke-width="2"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Supervised EOL Loop</text>
</svg>
"@
        }
        "multimeter" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="25" width="150" height="95" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <line x1="50" y1="50" x2="150" y2="50" stroke="#f3f4f6" stroke-width="1.5"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Diagnostics Terminal Verification</text>
</svg>
"@
        }
        "shock_path" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="30" r="10" fill="none" stroke="#f3f4f6" stroke-width="2"/>
  <line x1="100" y1="40" x2="100" y2="90" stroke="#f3f4f6" stroke-width="2"/>
  <line x1="100" y1="50" x2="60" y2="70" stroke="#f3f4f6" stroke-width="2"/>
  <line x1="100" y1="50" x2="140" y2="70" stroke="#ef4444" stroke-width="2.5"/>
  <line x1="100" y1="90" x2="80" y2="130" stroke="#ef4444" stroke-width="2.5"/>
  <line x1="100" y1="90" x2="120" y2="130" stroke="#f3f4f6" stroke-width="2"/>
  <line x1="140" y1="70" x2="170" y2="70" stroke="#ef4444" stroke-width="2"/>
  <path d="M 80 130 L 80 145" stroke="#ef4444" stroke-width="2" stroke-linecap="round"/>
  <text x="140" y="60" fill="#ef4444" font-family="sans-serif" font-size="8">Phase Contact</text>
  <text x="100" y="145" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Shock Current Path</text>
</svg>
"@
        }
        "shock_scale" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <line x1="50" y1="20" x2="50" y2="130" stroke="#f3f4f6" stroke-width="2"/>
  <circle cx="50" cy="120" r="4" fill="#10b981"/>
  <circle cx="50" cy="90" r="4" fill="#3b82f6"/>
  <circle cx="50" cy="60" r="4" fill="#f59e0b"/>
  <circle cx="50" cy="30" r="4" fill="#ef4444"/>
  <text x="65" y="123" fill="#10b981" font-family="sans-serif" font-size="8">1mA - Threshold of Sensation</text>
  <text x="65" y="93" fill="#3b82f6" font-family="sans-serif" font-size="8">10mA - Can't Let Go Limit</text>
  <text x="65" y="63" fill="#f59e0b" font-family="sans-serif" font-size="8">30mA - Breathing Stops</text>
  <text x="65" y="33" fill="#ef4444" font-family="sans-serif" font-size="8">100mA - Heart Ventricle Arrest</text>
  <text x="100" y="145" fill="#f3f4f6" font-family="sans-serif" font-size="10" text-anchor="middle">Current Physiological Impact</text>
</svg>
"@
        }
        "loto_tag" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="35" y="65" width="40" height="40" rx="4" fill="none" stroke="#ef4444" stroke-width="3"/>
  <path d="M 45 65 L 45 45 A 10 10 0 0 1 65 45 L 65 65" fill="none" stroke="#ef4444" stroke-width="3"/>
  <polygon points="120,40 160,40 165,45 165,110 120,110" fill="none" stroke="#f59e0b" stroke-width="2"/>
  <circle cx="130" cy="50" r="3" fill="#f59e0b"/>
  <text x="142" y="75" fill="#ef4444" font-family="sans-serif" font-weight="bold" font-size="8" text-anchor="middle">DANGER</text>
  <text x="142" y="90" fill="#f3f4f6" font-family="sans-serif" font-size="7" text-anchor="middle">LOCKED OUT</text>
  <text x="100" y="138" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">LOTO Device Isolation</text>
</svg>
"@
        }
        "overload_short" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <line x1="15" y1="40" x2="90" y2="40" stroke="#f59e0b" stroke-width="2.5" stroke-dasharray="3 3"/>
  <circle cx="50" cy="40" r="10" fill="none" stroke="#f59e0b" stroke-width="2"/>
  <text x="50" y="20" fill="#f59e0b" font-family="sans-serif" font-size="9" text-anchor="middle">Overload (Slow Heat)</text>
  <line x1="110" y1="40" x2="190" y2="40" stroke="#ef4444" stroke-width="3"/>
  <path d="M 145 40 L 150 25 L 140 25 L 155 10" fill="none" stroke="#ef4444" stroke-width="2"/>
  <text x="150" y="20" fill="#ef4444" font-family="sans-serif" font-size="9" text-anchor="middle">Short Circuit (Instant Spark)</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Fault Profiles</text>
</svg>
"@
        }
        "mcb_cutaway" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="50" y="25" width="100" height="95" rx="5" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <line x1="70" y1="45" x2="70" y2="85" stroke="#ef4444" stroke-width="4"/>
  <line x1="74" y1="45" x2="74" y2="85" stroke="#f59e0b" stroke-width="2"/>
  <path d="M 120 45 C 110 45, 110 55, 120 55 C 110 55, 110 65, 120 65 C 110 65, 110 75, 120 75" fill="none" stroke="#9ca3af" stroke-width="2.5"/>
  <text x="70" y="110" fill="#f59e0b" font-family="sans-serif" font-size="8" text-anchor="middle">Thermal (Overload)</text>
  <text x="120" y="110" fill="#3b82f6" font-family="sans-serif" font-size="8" text-anchor="middle">Magnetic (Short)</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Internal MCB Elements</text>
</svg>
"@
        }
        "rccb_balance" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="70" r="30" fill="none" stroke="#9ca3af" stroke-width="6"/>
  <path d="M 50 50 Q 80 50 90 70 Q 100 90 150 90" fill="none" stroke="#ef4444" stroke-width="2"/>
  <path d="M 50 90 Q 80 90 90 70 Q 100 50 150 50" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <path d="M 100 40 L 100 30 L 115 30" fill="none" stroke="#eab308" stroke-width="1.5"/>
  <circle cx="115" cy="30" r="3" fill="#eab308"/>
  <text x="100" y="125" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Current Balance Loop</text>
</svg>
"@
        }
        "shock_compare" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="35" width="60" height="70" fill="none" stroke="#4b5563" stroke-width="2"/>
  <text x="55" y="25" fill="#4b5563" font-family="sans-serif" font-size="9" text-anchor="middle">MCB Only</text>
  <text x="55" y="70" fill="#ef4444" font-family="sans-serif" font-size="10" text-anchor="middle">No Trip</text>
  <rect x="115" y="35" width="60" height="70" fill="none" stroke="#10b981" stroke-width="2"/>
  <line x1="125" y1="45" x2="135" y2="85" stroke="#10b981" stroke-width="3"/>
  <text x="145" y="25" fill="#10b981" font-family="sans-serif" font-size="9" text-anchor="middle">RCCB Protection</text>
  <text x="145" y="75" fill="#10b981" font-family="sans-serif" font-weight="bold" font-size="10" text-anchor="middle">TRIP (30ms)</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Shock Protection Comparison</text>
</svg>
"@
        }
        "db_panel" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="30" y="20" width="140" height="110" rx="4" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <rect x="50" y="45" width="30" height="60" rx="3" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <rect x="95" y="45" width="50" height="60" rx="3" fill="none" stroke="#10b981" stroke-width="2"/>
  <rect x="125" y="55" width="12" height="12" fill="#ef4444"/>
  <text x="131" y="63" fill="#f3f4f6" font-family="sans-serif" font-size="7" text-anchor="middle">T</text>
  <text x="100" y="145" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Distribution Panelboard</text>
</svg>
"@
        }
        "safety" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="25" width="150" height="95" fill="none" stroke="#4b5563" stroke-width="2"/>
  <line x1="45" y1="10" x2="45" y2="120" stroke="#ef4444" stroke-width="2.5"/>
  <line x1="85" y1="10" x2="85" y2="120" stroke="#3b82f6" stroke-width="2.5"/>
  <line x1="145" y1="10" x2="145" y2="120" stroke="#10b981" stroke-width="2.5"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Panel Terminal Board Wiring</text>
</svg>
"@
        }
        "drawing" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="20" y="20" width="160" height="110" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <circle cx="50" cy="75" r="10" fill="none" stroke="#f59e0b" stroke-width="3"/>
  <line x1="60" y1="75" x2="100" y2="75" stroke="#f59e0b" stroke-width="2"/>
  <line x1="100" y1="55" x2="140" y2="40" stroke="#ef4444" stroke-width="3"/>
  <circle cx="100" cy="55" r="4" fill="#ef4444"/>
  <circle cx="140" cy="55" r="4" fill="#ef4444"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Schematic Legend</text>
</svg>
"@
        }
        "cable" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="20" y="55" width="160" height="40" rx="10" fill="none" stroke="#3b82f6" stroke-width="3"/>
  <line x1="10" y1="65" x2="190" y2="65" stroke="#ef4444" stroke-width="3"/>
  <line x1="10" y1="75" x2="190" y2="75" stroke="#10b981" stroke-width="3"/>
  <line x1="10" y1="85" x2="190" y2="85" stroke="#f59e0b" stroke-width="3"/>
  <text x="100" y="125" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Conduit Separation</text>
</svg>
"@
        }
        "smps" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="15" y="45" width="45" height="40" fill="rgba(239, 68, 68, 0.1)" stroke="#ef4444" stroke-width="2"/>
  <text x="37" y="70" fill="#f3f4f6" font-family="sans-serif" font-size="9" text-anchor="middle">AC IN</text>
  <rect x="75" y="45" width="55" height="40" fill="rgba(59, 130, 246, 0.1)" stroke="#3b82f6" stroke-width="2"/>
  <text x="102" y="70" fill="#f3f4f6" font-family="sans-serif" font-size="8" text-anchor="middle">MOSFET</text>
  <rect x="145" y="45" width="40" height="40" fill="rgba(16, 185, 129, 0.1)" stroke="#10b981" stroke-width="2"/>
  <text x="165" y="70" fill="#f3f4f6" font-family="sans-serif" font-size="9" text-anchor="middle">DC OUT</text>
  <text x="100" y="125" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">SMPS Topology</text>
</svg>
"@
        }
        "smps_schema" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="10" y="30" width="180" height="85" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <line x1="50" y1="30" x2="50" y2="115" stroke="#4b5563" stroke-width="1.5"/>
  <line x1="105" y1="30" x2="105" y2="115" stroke="#4b5563" stroke-width="1.5"/>
  <line x1="150" y1="30" x2="150" y2="115" stroke="#4b5563" stroke-width="1.5"/>
  <text x="30" y="75" fill="#ef4444" font-family="sans-serif" font-size="8" text-anchor="middle">Filter</text>
  <text x="77" y="75" fill="#3b82f6" font-family="sans-serif" font-size="8" text-anchor="middle">Switch</text>
  <text x="127" y="75" fill="#f59e0b" font-family="sans-serif" font-size="8" text-anchor="middle">Coil</text>
  <text x="170" y="75" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">Filter</text>
  <text x="100" y="140" fill="#f3f4f6" font-family="sans-serif" font-size="10" text-anchor="middle">SMPS Operational Stages</text>
</svg>
"@
        }
        "smps_plate" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="25" width="150" height="95" rx="5" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="35" y="45" fill="#10b981" font-family="monospace" font-size="8">INPUT: 100-240VAC 50/60Hz</text>
  <text x="35" y="65" fill="#ef4444" font-family="monospace" font-size="8">OUTPUT: 12.0VDC = 10.0A</text>
  <text x="35" y="85" fill="#f59e0b" font-family="monospace" font-size="8">MAX WATTAGE: 120W</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">SMPS Specification Label</text>
</svg>
"@
        }
        "smps_pot" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="65" r="25" fill="none" stroke="#f59e0b" stroke-width="3"/>
  <line x1="82" y1="65" x2="118" y2="65" stroke="#f3f4f6" stroke-width="3"/>
  <line x1="50" y1="115" x2="90" y2="75" stroke="#9ca3af" stroke-width="4"/>
  <rect x="35" y="115" width="20" height="15" fill="#ef4444"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">DC Calibration Trim Pot</text>
</svg>
"@
        }
        "battery_charge" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="20" y="40" width="50" height="40" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <polygon points="100,50 100,70 115,60" fill="#ef4444"/>
  <line x1="115" y1="50" x2="115" y2="70" stroke="#ef4444" stroke-width="2"/>
  <rect x="135" y="40" width="45" height="40" fill="none" stroke="#10b981" stroke-width="2"/>
  <text x="45" y="65" fill="#3b82f6" font-family="sans-serif" font-size="8" text-anchor="middle">SMPS</text>
  <text x="157" y="65" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">Battery</text>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Float Charging Diode Lock</text>
</svg>
"@
        }
        "battery_sizing" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="70" r="45" fill="none" stroke="#10b981" stroke-width="3"/>
  <line x1="55" y1="70" x2="145" y2="70" stroke="#10b981" stroke-width="2"/>
  <line x1="100" y1="70" x2="100" y2="115" stroke="#10b981" stroke-width="2"/>
  <text x="100" y="55" fill="#f3f4f6" font-family="sans-serif" font-weight="bold" font-size="16" text-anchor="middle">Capacity (Ah)</text>
  <text x="77" y="98" fill="#3b82f6" font-family="sans-serif" font-size="12" text-anchor="middle">Load (A)</text>
  <text x="123" y="98" fill="#ef4444" font-family="sans-serif" font-size="12" text-anchor="middle">Hours</text>
  <text x="100" y="142" fill="#9ca3af" font-family="sans-serif" font-size="10" text-anchor="middle">Ah = [Load Amps × Hours] / 0.7</text>
</svg>
"@
        }
        "smps_faults" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="40" y="45" width="35" height="50" rx="3" fill="none" stroke="#10b981" stroke-width="2"/>
  <line x1="40" y1="45" x2="75" y2="45" stroke="#10b981" stroke-width="2"/>
  <text x="57" y="115" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">Flat (Good)</text>
  <rect x="120" y="45" width="35" height="50" rx="3" fill="none" stroke="#ef4444" stroke-width="2"/>
  <path d="M 120 45 Q 137 35 155 45" fill="none" stroke="#ef4444" stroke-width="2"/>
  <text x="137" y="115" fill="#ef4444" font-family="sans-serif" font-size="8" text-anchor="middle">Swollen (Burnt)</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Capacitor Bulging Check</text>
</svg>
"@
        }
        "dist_panel" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="30" y="30" width="140" height="85" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <rect x="45" y="45" width="8" height="20" fill="#ef4444"/>
  <rect x="75" y="45" width="8" height="20" fill="#ef4444"/>
  <rect x="105" y="45" width="8" height="20" fill="#ef4444"/>
  <rect x="135" y="45" width="8" height="20" fill="#ef4444"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Individual Port Fuses</text>
</svg>
"@
        }
        "smps_calibration" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="50" y="30" width="100" height="70" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <path d="M 60 70 L 30 110" fill="none" stroke="#ef4444" stroke-width="1.5"/>
  <path d="M 140 70 L 170 110" fill="none" stroke="#111827" stroke-width="1.5" stroke-dasharray="1 1"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Measuring Terminal DC Voltage</text>
</svg>
"@
        }
        "legend_symbols" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="30" y="25" width="30" height="15" fill="none" stroke="#f3f4f6" stroke-width="1.5"/>
  <text x="75" y="37" fill="#9ca3af" font-family="sans-serif" font-size="8">Coil</text>
  <line x1="30" y1="75" x2="60" y2="75" stroke="#f3f4f6" stroke-width="1.5"/>
  <circle cx="45" cy="75" r="3" fill="#10b981"/>
  <text x="75" y="78" fill="#9ca3af" font-family="sans-serif" font-size="8">NC Switch</text>
  <line x1="30" y1="115" x2="45" y2="115" stroke="#f3f4f6" stroke-width="1.5"/>
  <line x1="45" y1="115" x2="58" y2="105" stroke="#f3f4f6" stroke-width="1.5"/>
  <text x="75" y="118" fill="#9ca3af" font-family="sans-serif" font-size="8">NO Switch</text>
  <text x="150" y="75" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Standard Icons</text>
</svg>
"@
        }
        "relay_working" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="35" y="55" width="35" height="45" fill="rgba(59,130,246,0.1)" stroke="#3b82f6" stroke-width="2"/>
  <path d="M 40 60 C 50 60, 50 70, 40 70 C 50 70, 50 80, 40 80 C 50 80, 50 90, 40 90" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <line x1="70" y1="65" x2="100" y2="65" stroke="#9ca3af" stroke-width="1.5" stroke-dasharray="2 2"/>
  <circle cx="120" cy="75" r="4" fill="#f59e0b"/>
  <circle cx="160" cy="50" r="4" fill="#ef4444"/>
  <circle cx="160" cy="100" r="4" fill="#10b981"/>
  <line x1="123" y1="75" x2="157" y2="52" stroke="#f3f4f6" stroke-width="2.5"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Electromagnetic Switch Action</text>
</svg>
"@
        }
        "relay_types" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="35" cy="65" r="3" fill="#f59e0b"/>
  <circle cx="65" cy="50" r="3" fill="#ef4444"/>
  <circle cx="65" cy="80" r="3" fill="#10b981"/>
  <line x1="37" y1="65" x2="62" y2="52" stroke="#f3f4f6" stroke-width="1.5"/>
  <text x="50" y="110" fill="#3b82f6" font-family="sans-serif" font-size="9" text-anchor="middle">SPDT Loop</text>
  <circle cx="125" cy="50" r="3" fill="#f59e0b"/>
  <circle cx="125" cy="80" r="3" fill="#f59e0b"/>
  <circle cx="155" cy="40" r="3" fill="#ef4444"/>
  <circle cx="155" cy="60" r="3" fill="#10b981"/>
  <circle cx="155" cy="70" r="3" fill="#ef4444"/>
  <circle cx="155" cy="90" r="3" fill="#10b981"/>
  <line x1="127" y1="50" x2="152" y2="42" stroke="#f3f4f6" stroke-width="1.5"/>
  <line x1="127" y1="80" x2="152" y2="72" stroke="#f3f4f6" stroke-width="1.5"/>
  <text x="140" y="110" fill="#10b981" font-family="sans-serif" font-size="9" text-anchor="middle">DPDT Loop</text>
  <text x="100" y="138" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Relay Configurations</text>
</svg>
"@
        }
        "digital_signal_wave" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <!-- Graph grids -->
  <line x1="20" y1="20" x2="20" y2="120" stroke="#4b5563" stroke-width="1.5"/>
  <line x1="20" y1="120" x2="190" y2="120" stroke="#4b5563" stroke-width="1.5"/>
  <!-- Square wave (0/1) -->
  <path d="M 20 120 L 50 120 L 50 40 L 90 40 L 90 120 L 130 120 L 130 40 L 170 40" fill="none" stroke="#10b981" stroke-width="3" stroke-linejoin="miter"/>
  <text x="70" y="30" fill="#10b981" font-family="sans-serif" font-weight="bold" font-size="10" text-anchor="middle">1 (12V)</text>
  <text x="110" y="135" fill="#ef4444" font-family="sans-serif" font-weight="bold" font-size="10" text-anchor="middle">0 (0V)</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Digital Square Wave Concept</text>
</svg>
"@
        }
        "dry_wet_contacts" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <!-- Dry Contact (Switch only) -->
  <rect x="15" y="35" width="70" height="70" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <line x1="30" y1="70" x2="70" y2="70" stroke="#ef4444" stroke-width="2"/>
  <circle cx="50" cy="70" r="4" fill="#ef4444"/>
  <text x="50" y="25" fill="#3b82f6" font-family="sans-serif" font-size="8" text-anchor="middle">Dry (Volt-Free)</text>
  <!-- Wet Contact (Supply connected) -->
  <rect x="115" y="35" width="70" height="70" fill="none" stroke="#10b981" stroke-width="2"/>
  <line x1="130" y1="70" x2="170" y2="70" stroke="#10b981" stroke-width="2"/>
  <circle cx="150" cy="70" r="4" fill="#10b981"/>
  <line x1="150" y1="45" x2="150" y2="66" stroke="#ef4444" stroke-width="1.5"/>
  <text x="150" y="42" fill="#ef4444" font-family="sans-serif" font-size="7" text-anchor="middle">12V DC</text>
  <text x="150" y="25" fill="#10b981" font-family="sans-serif" font-size="8" text-anchor="middle">Wet (12V Output)</text>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Triggers Types Comparison</text>
</svg>
"@
        }
        "sld_power" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <line x1="100" y1="15" x2="100" y2="120" stroke="#f3f4f6" stroke-width="3"/>
  <line x1="100" y1="50" x2="140" y2="50" stroke="#3b82f6" stroke-width="2"/>
  <line x1="100" y1="90" x2="60" y2="90" stroke="#ef4444" stroke-width="2"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Single Line Path</text>
</svg>
"@
        }
        "grid_coordinates" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="25" width="150" height="95" fill="none" stroke="#4b5563" stroke-width="1"/>
  <text x="15" y="45" fill="#9ca3af" font-family="sans-serif" font-size="8">A</text>
  <text x="15" y="85" fill="#9ca3af" font-family="sans-serif" font-size="8">B</text>
  <text x="60" y="18" fill="#9ca3af" font-family="sans-serif" font-size="8">1</text>
  <text x="130" y="18" fill="#9ca3af" font-family="sans-serif" font-size="8">2</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Plan Reference Grid</text>
</svg>
"@
        }
        "wire_ferrule" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="15" y="65" width="130" height="20" fill="#3b82f6"/>
  <rect x="80" y="60" width="30" height="30" fill="#eab308" rx="2"/>
  <text x="95" y="80" fill="#111827" font-family="monospace" font-weight="bold" font-size="12" text-anchor="middle">104</text>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Numbered Wire Sleeve</text>
</svg>
"@
        }
        "relay_contacts" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="30" y="55" width="30" height="40" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <line x1="60" y1="75" x2="90" y2="75" stroke="#9ca3af" stroke-width="1.5" stroke-dasharray="2 2"/>
  <circle cx="110" cy="75" r="4" fill="#f59e0b"/>
  <circle cx="150" cy="55" r="4" fill="#ef4444"/>
  <circle cx="150" cy="95" r="4" fill="#10b981"/>
  <line x1="112" y1="75" x2="146" y2="57" stroke="#f3f4f6" stroke-width="2"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Relay Internal Contacts</text>
</svg>
"@
        }
        "door_schematic" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="15" y="45" width="35" height="50" rx="3" fill="none" stroke="#9ca3af" stroke-width="1.5"/>
  <rect x="80" y="50" width="40" height="40" fill="none" stroke="#f59e0b" stroke-width="1.5"/>
  <rect x="150" y="55" width="35" height="30" fill="none" stroke="#ef4444" stroke-width="1.5"/>
  <path d="M 50 70 L 80 70" fill="none" stroke="#ef4444" stroke-width="1.5"/>
  <path d="M 120 70 L 150 70" fill="none" stroke="#10b981" stroke-width="1.5"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Access Circuit Layout</text>
</svg>
"@
        }
        "fire_trigger" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="45" width="60" height="50" fill="none" stroke="#ef4444" stroke-width="2"/>
  <text x="55" y="75" fill="#ef4444" font-family="sans-serif" font-size="9" text-anchor="middle">Fire Panel</text>
  <line x1="85" y1="70" x2="125" y2="70" stroke="#f59e0b" stroke-width="2"/>
  <line x1="125" y1="70" x2="140" y2="50" stroke="#ef4444" stroke-width="2"/>
  <line x1="145" y1="70" x2="185" y2="70" stroke="#10b981" stroke-width="2"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Fire Alarm Emergency Cutoff</text>
</svg>
"@
        }
        "drawings_diag" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="30" y="30" width="140" height="80" fill="none" stroke="#9ca3af" stroke-width="1.5"/>
  <path d="M 45 70 L 155 70" fill="none" stroke="#10b981" stroke-width="3"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Tracing Blueprint Connections</text>
</svg>
"@
        }
        "door_layout" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="65" y="25" width="70" height="95" fill="none" stroke="#9ca3af" stroke-width="3"/>
  <rect x="85" y="25" width="30" height="8" fill="#ef4444"/>
  <rect x="40" y="65" width="15" height="25" fill="#3b82f6"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Completed Lock Installation</text>
</svg>
"@
        }
        "solid_stranded" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="55" cy="65" r="20" fill="#38bdf8"/>
  <text x="55" y="115" fill="#38bdf8" font-family="sans-serif" font-size="9" text-anchor="middle">Solid Core</text>
  <circle cx="145" cy="65" r="7" fill="#f43f5e"/>
  <circle cx="132" cy="55" r="7" fill="#f43f5e"/>
  <circle cx="158" cy="55" r="7" fill="#f43f5e"/>
  <circle cx="132" cy="75" r="7" fill="#f43f5e"/>
  <circle cx="158" cy="75" r="7" fill="#f43f5e"/>
  <circle cx="145" cy="50" r="7" fill="#f43f5e"/>
  <circle cx="145" cy="80" r="7" fill="#f43f5e"/>
  <text x="145" y="115" fill="#f43f5e" font-family="sans-serif" font-size="9" text-anchor="middle">Stranded Cores</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Cable Core Profiles</text>
</svg>
"@
        }
        "volt_drop_chart" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <line x1="30" y1="20" x2="30" y2="120" stroke="#4b5563" stroke-width="1.5"/>
  <line x1="30" y1="120" x2="190" y2="120" stroke="#4b5563" stroke-width="1.5"/>
  <path d="M 30 40 Q 90 90 180 110" fill="none" stroke="#ef4444" stroke-width="2"/>
  <text x="135" y="60" fill="#ef4444" font-family="sans-serif" font-size="8">Voltage Drop</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Voltage Drop vs Cable Distance</text>
</svg>
"@
        }
        "cable_profiles" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="35" width="150" height="15" rx="3" fill="#3b82f6"/>
  <circle cx="45" cy="42" r="4" fill="#eab308"/>
  <circle cx="75" cy="42" r="4" fill="#10b981"/>
  <circle cx="105" cy="42" r="4" fill="#ef4444"/>
  <circle cx="135" cy="42" r="4" fill="#f3f4f6"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Multi-Pair Shielded Profiles</text>
</svg>
"@
        }
        "conduit_pull" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="20" y="55" width="160" height="40" rx="4" fill="none" stroke="#9ca3af" stroke-width="3"/>
  <path d="M 10 75 Q 100 75 190 75" fill="none" stroke="#ef4444" stroke-width="2" stroke-linecap="round"/>
  <text x="100" y="125" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Conduit Cable Pulling</text>
</svg>
"@
        }
        "fill_rule" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <circle cx="100" cy="70" r="45" fill="none" stroke="#9ca3af" stroke-width="3"/>
  <circle cx="90" cy="70" r="10" fill="#ef4444"/>
  <circle cx="110" cy="60" r="10" fill="#3b82f6"/>
  <circle cx="110" cy="80" r="10" fill="#10b981"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">40% Max Cross-Section Fill</text>
</svg>
"@
        }
        "pipe_bend" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <path d="M 30 115 A 80 80 0 0 1 115 30" fill="none" stroke="#9ca3af" stroke-width="15"/>
  <path d="M 32 113 A 78 78 0 0 1 113 32" fill="none" stroke="#f59e0b" stroke-width="6" stroke-dasharray="3 3"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Spring Insertion for PVC Bends</text>
</svg>
"@
        }
        "separation_lines" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <line x1="20" y1="45" x2="180" y2="45" stroke="#ef4444" stroke-width="3"/>
  <line x1="20" y1="105" x2="180" y2="105" stroke="#3b82f6" stroke-width="3"/>
  <line x1="100" y1="48" x2="100" y2="102" stroke="#eab308" stroke-width="1.5"/>
  <polygon points="100,48 96,55 104,55" fill="#eab308"/>
  <polygon points="100,102 96,95 104,95" fill="#eab308"/>
  <text x="112" y="80" fill="#eab308" font-family="sans-serif" font-weight="bold" font-size="9">300 mm</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Data / Power Conduit Separation</text>
</svg>
"@
        }
        "splice_types" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <line x1="15" y1="40" x2="60" y2="40" stroke="#f3f4f6" stroke-width="2"/>
  <path d="M 60 40 L 70 30 L 75 50 L 80 30 L 85 50 L 95 40" fill="none" stroke="#f3f4f6" stroke-width="2"/>
  <line x1="95" y1="40" x2="140" y2="40" stroke="#f3f4f6" stroke-width="2"/>
  <text x="80" y="20" fill="#f3f4f6" font-family="sans-serif" font-size="8" text-anchor="middle">Western Union Joint</text>
  <line x1="45" y1="105" x2="90" y2="105" stroke="#3b82f6" stroke-width="2"/>
  <line x1="45" y1="115" x2="90" y2="105" stroke="#ef4444" stroke-width="2"/>
  <path d="M 90 105 L 110 95 L 115 110 L 120 95" fill="none" stroke="#eab308" stroke-width="2"/>
  <text x="80" y="85" fill="#f3f4f6" font-family="sans-serif" font-size="8" text-anchor="middle">Pigtail Joint</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Splicing Standards</text>
</svg>
"@
        }
        "conduit_mockup" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="25" width="150" height="95" fill="none" stroke="#4b5563" stroke-width="2"/>
  <line x1="35" y1="40" x2="165" y2="40" stroke="#9ca3af" stroke-width="4"/>
  <line x1="35" y1="80" x2="165" y2="80" stroke="#9ca3af" stroke-width="4"/>
  <rect x="55" y="35" width="5" height="14" fill="#3b82f6"/>
  <rect x="135" y="35" width="5" height="14" fill="#3b82f6"/>
  <rect x="55" y="75" width="5" height="14" fill="#3b82f6"/>
  <rect x="135" y="75" width="5" height="14" fill="#3b82f6"/>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Completed Conduit Layout</text>
</svg>
"@
        }
        "ip_octets" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="10" y="45" width="35" height="25" fill="none" stroke="#3b82f6" stroke-width="1.5"/>
  <rect x="55" y="45" width="35" height="25" fill="none" stroke="#3b82f6" stroke-width="1.5"/>
  <rect x="100" y="45" width="35" height="25" fill="none" stroke="#3b82f6" stroke-width="1.5"/>
  <rect x="145" y="45" width="45" height="25" fill="none" stroke="#10b981" stroke-width="1.5"/>
  <text x="27" y="60" fill="#f3f4f6" font-family="monospace" font-size="8" text-anchor="middle">192</text>
  <text x="72" y="60" fill="#f3f4f6" font-family="monospace" font-size="8" text-anchor="middle">168</text>
  <text x="117" y="60" fill="#f3f4f6" font-family="monospace" font-size="8" text-anchor="middle">1</text>
  <text x="167" y="60" fill="#10b981" font-family="monospace" font-size="8" text-anchor="middle">100</text>
  <text x="65" y="90" fill="#3b82f6" font-family="sans-serif" font-size="9" text-anchor="middle">Network ID</text>
  <text x="155" y="90" fill="#10b981" font-family="sans-serif" font-size="9" text-anchor="middle">Host ID</text>
  <text x="100" y="130" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">IPv4 Address Architecture</text>
</svg>
"@
        }
        "subnet_mask" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="20" y="30" width="70" height="40" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <text x="55" y="55" fill="#3b82f6" font-family="monospace" font-size="9" text-anchor="middle">255.255.255.0</text>
  <rect x="110" y="30" width="70" height="40" fill="none" stroke="#ef4444" stroke-width="2"/>
  <text x="145" y="55" fill="#ef4444" font-family="monospace" font-size="9" text-anchor="middle">255.255.255.240</text>
  <text x="55" y="95" fill="#9ca3af" font-family="sans-serif" font-size="8" text-anchor="middle">/24 (256 hosts)</text>
  <text x="145" y="95" fill="#9ca3af" font-family="sans-serif" font-size="8" text-anchor="middle">/28 (16 hosts)</text>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Subnet Mask Partitioning</text>
</svg>
"@
        }
        "cidr_slices" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <!-- Pie chart slices representation -->
  <circle cx="100" cy="70" r="45" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <line x1="100" y1="25" x2="100" y2="115" stroke="#3b82f6" stroke-width="2"/>
  <line x1="55" y1="70" x2="145" y2="70" stroke="#3b82f6" stroke-width="2"/>
  <text x="70" y="55" fill="#f3f4f6" font-family="sans-serif" font-size="8">VLAN 10</text>
  <text x="130" y="55" fill="#f3f4f6" font-family="sans-serif" font-size="8">VLAN 20</text>
  <text x="70" y="95" fill="#f3f4f6" font-family="sans-serif" font-size="8">VLAN 30</text>
  <text x="130" y="95" fill="#f3f4f6" font-family="sans-serif" font-size="8">VLAN 40</text>
  <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Subnet Slicing</text>
</svg>
"@
        }
        "router_ports" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="25" y="45" width="150" height="50" rx="3" fill="none" stroke="#4b5563" stroke-width="2"/>
  <!-- WAN port -->
  <rect x="35" y="55" width="20" height="20" fill="#3b82f6" rx="1"/>
  <text x="45" y="88" fill="#3b82f6" font-family="sans-serif" font-size="7" text-anchor="middle">WAN</text>
  <!-- LAN ports -->
  <rect x="75" y="55" width="20" height="20" fill="#10b981" rx="1"/>
  <rect x="105" y="55" width="20" height="20" fill="#10b981" rx="1"/>
  <rect x="135" y="55" width="20" height="20" fill="#10b981" rx="1"/>
  <text x="115" y="88" fill="#10b981" font-family="sans-serif" font-size="7" text-anchor="middle">LAN Ports</text>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Standard Router Back Panel</text>
</svg>
"@
        }
        "nat_flow" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="80" y="45" width="40" height="40" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <line x1="20" y1="65" x2="80" y2="65" stroke="#ef4444" stroke-width="2"/>
  <line x1="120" y1="65" x2="180" y2="65" stroke="#10b981" stroke-width="2"/>
  <text x="50" y="55" fill="#ef4444" font-family="monospace" font-size="7" text-anchor="middle">192.168.1.10</text>
  <text x="150" y="55" fill="#10b981" font-family="monospace" font-size="7" text-anchor="middle">122.15.6.8</text>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Network Address Translation</text>
</svg>
"@
        }
        "vlan_logical" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="30" y="30" width="140" height="80" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <line x1="100" y1="30" x2="100" y2="110" stroke="#f59e0b" stroke-width="2" stroke-dasharray="3 3"/>
  <text x="65" y="75" fill="#3b82f6" font-family="sans-serif" font-size="10" text-anchor="middle">VLAN 10</text>
  <text x="135" y="75" fill="#10b981" font-family="sans-serif" font-size="10" text-anchor="middle">VLAN 20</text>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Logical Switch Segments</text>
</svg>
"@
        }
        "poe_cable" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <!-- Cat6 cable outline -->
  <rect x="25" y="55" width="150" height="30" rx="6" fill="#4b5563"/>
  <text x="100" y="45" fill="#ef4444" font-family="sans-serif" font-weight="bold" font-size="9" text-anchor="middle">Data + 48V DC Power</text>
  <text x="100" y="125" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Composite PoE Feed</text>
</svg>
"@
        }
        "poe_split" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="80" y="45" width="40" height="50" rx="3" fill="none" stroke="#3b82f6" stroke-width="2"/>
  <line x1="20" y1="70" x2="80" y2="70" stroke="#f3f4f6" stroke-width="2"/>
  <!-- splits -->
  <line x1="120" y1="60" x2="170" y2="60" stroke="#ef4444" stroke-width="2"/> <!-- DC -->
  <line x1="120" y1="80" x2="170" y2="80" stroke="#3b82f6" stroke-width="2"/> <!-- Data -->
  <text x="150" y="52" fill="#ef4444" font-family="monospace" font-size="7">12V DC</text>
  <text x="100" y="130" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">PoE Splitter Module</text>
</svg>
"@
        }
        "fiber_light" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="20" y="55" width="160" height="35" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <!-- Light bouncing -->
  <path d="M 20 72 L 50 60 L 80 85 L 110 60 L 140 85 L 170 60" fill="none" stroke="#ef4444" stroke-width="2"/>
  <text x="100" y="125" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Internal Total Reflection</text>
</svg>
"@
        }
        "sfp_module" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="55" y="45" width="90" height="40" rx="2" fill="none" stroke="#4b5563" stroke-width="2"/>
  <rect x="60" y="50" width="20" height="30" fill="#3b82f6"/>
  <text x="100" y="130" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Optical SFP Transceiver</text>
</svg>
"@
        }
        "rj45_crimp_standard" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <defs>
    <!-- Patterns for half colored / half white wires -->
    <pattern id="stripe-orange-a" width="6" height="6" patternUnits="userSpaceOnUse" patternTransform="rotate(45)">
      <rect width="3" height="6" fill="#f97316"/>
      <rect x="3" width="3" height="6" fill="#ffffff"/>
    </pattern>
    <pattern id="stripe-green-a" width="6" height="6" patternUnits="userSpaceOnUse" patternTransform="rotate(45)">
      <rect width="3" height="6" fill="#22c55e"/>
      <rect x="3" width="3" height="6" fill="#ffffff"/>
    </pattern>
    <pattern id="stripe-blue-a" width="6" height="6" patternUnits="userSpaceOnUse" patternTransform="rotate(45)">
      <rect width="3" height="6" fill="#3b82f6"/>
      <rect x="3" width="3" height="6" fill="#ffffff"/>
    </pattern>
    <pattern id="stripe-brown-a" width="6" height="6" patternUnits="userSpaceOnUse" patternTransform="rotate(45)">
      <rect width="3" height="6" fill="#854d0e"/>
      <rect x="3" width="3" height="6" fill="#ffffff"/>
    </pattern>
  </defs>

  <!-- T568A Plug (Left) -->
  <text x="50" y="20" fill="#f3f4f6" font-family="sans-serif" font-weight="bold" font-size="9" text-anchor="middle">T568A</text>
  <rect x="15" y="25" width="70" height="85" rx="4" fill="none" stroke="#9ca3af" stroke-width="1.5"/>
  <!-- Pins 1 to 8 for T568A -->
  <rect x="20" y="28" width="5" height="35" fill="url(#stripe-green-a)"/>
  <rect x="27" y="28" width="5" height="35" fill="#22c55e"/>
  <rect x="35" y="28" width="5" height="35" fill="url(#stripe-orange-a)"/>
  <rect x="42" y="28" width="5" height="35" fill="#3b82f6"/>
  <rect x="50" y="28" width="5" height="35" fill="url(#stripe-blue-a)"/>
  <rect x="57" y="28" width="5" height="35" fill="#f97316"/>
  <rect x="65" y="28" width="5" height="35" fill="url(#stripe-brown-a)"/>
  <rect x="72" y="28" width="5" height="35" fill="#854d0e"/>

  <!-- T568B Plug (Right) -->
  <text x="150" y="20" fill="#f3f4f6" font-family="sans-serif" font-weight="bold" font-size="9" text-anchor="middle">T568B</text>
  <rect x="115" y="25" width="70" height="85" rx="4" fill="none" stroke="#9ca3af" stroke-width="1.5"/>
  <!-- Pins 1 to 8 for T568B -->
  <rect x="120" y="28" width="5" height="35" fill="url(#stripe-orange-a)"/>
  <rect x="128" y="28" width="5" height="35" fill="#f97316"/>
  <rect x="136" y="28" width="5" height="35" fill="url(#stripe-green-a)"/>
  <rect x="143" y="28" width="5" height="35" fill="#3b82f6"/>
  <rect x="151" y="28" width="5" height="35" fill="url(#stripe-blue-a)"/>
  <rect x="158" y="28" width="5" height="35" fill="#22c55e"/>
  <rect x="166" y="28" width="5" height="35" fill="url(#stripe-brown-a)"/>
  <rect x="173" y="28" width="5" height="35" fill="#854d0e"/>

  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="10" text-anchor="middle">RJ45 Pin Colors (Stripe = Half/Half)</text>
</svg>
"@
        }
        "rj11_crimp_standard" {
            return @"
<svg viewBox="0 0 200 150" width="100%">
  <rect x="50" y="35" width="100" height="75" rx="4" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <!-- 4 active pins in 6P4C -->
  <rect x="75" y="40" width="8" height="25" fill="#000000"/>
  <rect x="88" y="40" width="8" height="25" fill="#ef4444"/>
  <rect x="101" y="40" width="8" height="25" fill="#22c55e"/>
  <rect x="114" y="40" width="8" height="25" fill="#eab308"/>
  <text x="100" y="135" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">RJ11 (6P4C) Telephone Pinout</text>
</svg>
"@
        }
    }
}

$sessions = @(
    # Session 1: Electrical Fundamentals AC/DC
    @{
        num = 1
        title = "Electrical Fundamentals AC DC"
        accent_color = "#3b82f6"
        accent_glow = "rgba(59, 130, 246, 0.4)"
        diagram = "circuit"
        slides = @(
            @{ type="title"; title="Electrical Fundamentals (AC/DC)" },
            @{ type="content"; title="Atomic Level Properties"; diagram="atom"; bullets="<ul><li><strong>Atomic Structure:</strong> Matter consists of atoms containing a central nucleus (protons & neutrons) orbited by electrons.</li><li><strong>Free Electrons:</strong> Valency electrons in the outermost orbit can break free easily, creating current flow in conductors like copper.</li><li><strong>Insulators:</strong> Materials with tightly bound outer electrons (rubber, PVC) that block current flow.</li></ul>" },
            @{ type="content"; title="Voltage & Ohm's Law"; diagram="ohms_law"; bullets="<ul><li><strong>Voltage (V):</strong> The potential difference or electrical pressure that drives charge.</li><li><strong>Current (I):</strong> The rate of flow of charge (electrons) per second through a conductor.</li><li><strong>Ohm's Law:</strong> Current is directly proportional to voltage and inversely proportional to resistance.</li></ul><div class='highlight-block'>Equation: V = I × R</div>" },
            @{ type="content"; title="Resistance & Heat"; diagram="resistance_heat"; bullets="<ul><li><strong>Resistance (R):</strong> opposition to electron movement. Opposes the path of current.</li><li><strong>Heat Generation:</strong> Collision of moving electrons with atomic structures generates thermal energy.</li><li><strong>Joule's Heating:</strong> Heat generated is proportional to the square of current multiplied by resistance (I<sup>2</sup>R).</li></ul>" },
            @{ type="content"; title="Power & Watt's Law"; diagram="power_eq"; bullets="<ul><li><strong>Electrical Power (P):</strong> The rate at which electrical energy is consumed or converted to other forms (heat/light). Sized in Watts.</li><li><strong>Power Equation:</strong> Power is voltage multiplied by current.</li></ul><div class='highlight-block'>Equation: P = V × I</div>" },
            @{ type="content"; title="AC, DC & DC Ripple Profiles"; diagram="ac_dc_ripple"; bullets="<ul><li><strong>Alternating Current (AC):</strong> Bidirectional flow switching polarity (230V AC, 50Hz grid standard).</li><li><strong>Direct Current (DC):</strong> Unidirectional straight-line flow (12V battery power).</li><li><strong>DC Ripple:</strong> Residual AC voltage pulsations left in DC outputs after rectification, smoothed using filter capacitors.</li></ul>" },
            @{ type="content"; title="Resistor Types & Color Code"; diagram="color_code"; bullets="<ul><li><strong>Resistor Sizing:</strong> Fixed value carbon resistors and variable pots used to regulate low-voltage signals.</li><li><strong>Color Band System:</strong> Reading values via 4-band systems (Digit-Digit-Multiplier-Tolerance).</li><li><strong>Tolerance:</strong> Allowed margin of error (Gold = ±5%, Silver = ±10%).</li></ul>" },
            @{ type="content"; title="Resistor Series & Parallel Connections"; diagram="series_parallel"; bullets="<ul><li><strong>Series Connections:</strong> Total resistance is the sum of all ($R_{total} = R_1 + R_2$). Current remains the same.</li><li><strong>Parallel Connections:</strong> Voltage remains the same. Total resistance decreases ($1/R_{total} = 1/R_1 + 1/R_2$).</li></ul>" },
            @{ type="content"; title="Electrical Series & Parallel Circuits"; diagram="circuit_loops"; bullets="<ul><li><strong>Series Circuits:</strong> Current flows through one single path. Voltage splits across loads ($V_{total} = V_1 + V_2$). If one load breaks, the entire circuit stops operating.</li><li><strong>Parallel Circuits:</strong> Each load is connected on a separate branch. Voltage is equal across all loads ($V_{total} = V_1 = V_2$). If one branch breaks, other branches remain active.</li></ul>" },
            @{ type="content"; title="Two-Way Switch Connection (Staircase)"; diagram="two_way_switch"; bullets="<ul><li><strong>Logic:</strong> Controlling a single load (light/fan) from two different physical switches.</li><li><strong>Switch Type:</strong> Single Pole Double Throw (SPDT / 3-Terminal switches) replace standard 2-terminal SPST switches.</li><li><strong>Travelers:</strong> Two parallel 'traveler' wires cross-connect L1 and L2 terminals of both switches. Common terminal on switch 1 takes phase input, switch 2 common goes to load.</li></ul>" },
            @{ type="content"; title="Wire Crimping & Ferrule Standards"; diagram="wire_crimp_ferrule"; bullets="<ul><li><strong>Preparation:</strong> Cleanly strip wire insulation without cutting or scraping the inner copper strands.</li><li><strong>Bootlace Ferrules:</strong> Circular metal sleeves crimped over stranded wire ends. Prevents wire fraying and guarantees maximum contact area inside terminals.</li><li><strong>Crimping Tools:</strong> Enforce ratchet crimping tools that apply balanced, standard pressure rather than squeezing terminals flat with pliers.</li></ul>" },
            @{ type="content"; title="Lab Session Work"; diagram="circuit"; bullets="<div class='lab-block'><h3>Lab Work: Switchboard & Staircase Layout</h3><ol><li>Mount modular switches, bulb socket, and 3-pin outlet onto PVC board.</li><li>Wire AC line loop from switch to socket using copper wire.</li><li>Assemble two SPDT switches on board, wire traveler routes, and test dual control bulb.</li></ol></div>" }
        )
    },
    
    # Session 2: Earthing & Surge Protection
    @{
        num = 2
        title = "Earthing & Surge Protection"
        accent_color = "#10b981"
        accent_glow = "rgba(16, 185, 129, 0.4)"
        diagram = "earth_loop"
        slides = @(
            @{ type="title"; title="Earthing & Surge Protection" },
            @{ type="content"; title="What is Earthing?"; diagram="earth_loop"; bullets="<ul><li><strong>Definition:</strong> Direct low-impedance electrical connection from metal casings to the body of the Earth.</li><li><strong>Safety Loop:</strong> Routes stray fault currents away from human contact directly into the ground.</li><li><strong>Breaker Trip Trigger:</strong> Forces high current flow during shorts, instantly triggering MCB/RCCB safety breakers.</li></ul>" },
            @{ type="content"; title="Earthing Topologies"; diagram="earth_types"; bullets="<ul><li><strong>Plate Earthing:</strong> Copper or GI plate buried deep. Standard for substation sub-panels.</li><li><strong>Pipe Earthing:</strong> Perforated GI pipe driven vertically (2.5 meters depth). Most common Kerala field installation.</li><li><strong>Chemical Rod Earthing:</strong> Copper-bonded steel rod backfilled with moisture-retaining chemical compounds (Zero maintenance).</li></ul>" },
            @{ type="content"; title="Soil Resistivity & Moisture"; diagram="earth_pit"; bullets="<ul><li><strong>Soil Influence:</strong> Clay/loam has low resistance; dry sand/rocky ground has extremely high resistance.</li><li><strong>Moisture Retention:</strong> Adding alternating backfill layers of charcoal and salt to pull water and increase soil conductivity.</li><li><strong>Chemical Earth:</strong> Bentonite/graphite backfill powder replaces salt to avoid electrode corrosion.</li></ul>" },
            @{ type="content"; title="Earth Resistance Target Thresholds"; diagram="earth_meter"; bullets="<ul><li><strong>Electronic Equipment:</strong> Target earth resistance value is $<1\,\Omega$ for data racks, servers, and DVRs.</li><li><strong>Domestic/Commercial:</strong> Safety target is $<5\,\Omega$ for general mains sockets.</li><li><strong>Neutral-to-Earth Voltage:</strong> Must measure $< 2\text{V AC}$ to prevent micro-controller chips from burning.</li></ul>" },
            @{ type="content"; title="Lightning Protection Systems (LPS)"; diagram="lightning_rod"; bullets="<ul><li><strong>Air Terminals:</strong> Copper lightning spikes mounted on building roofs and high CCTV camera poles.</li><li><strong>Down-Conductor:</strong> Bare copper tape (25x3 mm) or insulated cables running straight down without sharp bends.</li><li><strong>Isolation:</strong> Diverting mega-amp strikes to ground before they can search for path through signal wires.</li></ul>" },
            @{ type="content"; title="Surge Protection Devices (SPDs)"; diagram="spd_wave"; bullets="<ul><li><strong>Surge Causes:</strong> Lightning induction on overhead lines, heavy motor switching, power grid fluctuations.</li><li><strong>SPD Core (MOV):</strong> Metal Oxide Varistors display infinite resistance at normal voltage; instantly drop resistance to divert surges.</li><li><strong>SPD Classes:</strong> Class I (Mains DB), Class II (Sub DB), Class III (Point of use, e.g. rack power strip).</li></ul>" },
            @{ type="content"; title="Wiring SPDs in DB Panels"; diagram="spd_wiring"; bullets="<ul><li><strong>Parallel Connection:</strong> SPDs connect in parallel between Live/Neutral lines and Earth bus bar.</li><li><strong>50 cm Lead Length Rule:</strong> Connecting wires must not exceed 50 cm. Longer wires create high inductive impedance, blocking discharge path.</li><li><strong>Indicator Status:</strong> Green flag = working; Red flag = internal MOV burnt, replace immediately.</li></ul>" },
            @{ type="content"; title="Earthing in Security & ELV Systems"; diagram="rack_ground"; bullets="<ul><li><strong>Ground Loops:</strong> Created when CCTV cameras are grounded at different potentials, producing scrolling video noise (hum bars).</li><li><strong>Rack Bonding:</strong> Earth bonding ELV rack doors and chassis back to main structural earth bar.</li><li><strong>Shielding Ground:</strong> Ground STP/FTP shielded cables at the switch end only to prevent loop current induction.</li></ul>" },
            @{ type="content"; title="Practical Lab Guide"; diagram="test_lamp_circuit"; bullets="<div class='lab-block'><h3>Lab Work: Earth Audit</h3><ol><li>Secure copper wire clamp to GI earth pipe using brass bolts.</li><li>Wire DB ground bus bar to earth pit.</li><li>Measure Phase-Earth loop using multimeter and series test lamp.</li></ol></div>" }
        )
    },
    
    # Session 3: Multimeter Diagnostics
    @{
        num = 3
        title = "Multimeter Diagnostics"
        accent_color = "#f59e0b"
        accent_glow = "rgba(245, 158, 11, 0.4)"
        diagram = "dmm_anatomy"
        slides = @(
            @{ type="title"; title="Multimeter & Diagnostics" },
            @{ type="content"; title="What is a Multimeter?"; diagram="dmm_anatomy"; bullets="<ul><li><strong>Anatomy:</strong> A diagnostic tool for measuring electrical values: Voltage, Current, and Resistance.</li><li><strong>Digital DMM:</strong> Features a high-contrast LCD screen, auto-ranging internal chips, and robust overload protection fuses.</li><li><strong>Prerequisites:</strong> Essential tool for security technicians to audit power feeds and locate wire faults.</li></ul>" },
            @{ type="content"; title="Selector Dial Symbols"; diagram="dmm_dial"; bullets="<ul><li><strong>AC Voltage ($\sim\text{V}$):</strong> Dial setting for utility mains, transformers, and socket outputs (typically 230V).</li><li><strong>DC Voltage ($=\text{V}$):</strong> Dial setting for batteries, power adapters, and camera board feeds (12V/5V).</li><li><strong>Resistance ($\Omega$):</strong> Dial setting to measure resistors and component impedance.</li><li><strong>Continuity (Buzzer):</strong> Bleep test mode to verify paths.</li></ul>" },
            @{ type="content"; title="Lead Port Connections"; diagram="dmm_ports"; bullets="<ul><li><strong>COM (Black):</strong> Common terminal. Connect black probe lead here for all measurements.</li><li><strong>V-Ω-mA (Red):</strong> Main measurement terminal. Connect red probe lead here for Voltage, Resistance, and Continuity.</li><li><strong>10A Terminal (Red):</strong> For high current measurement only. <strong>Caution:</strong> Probing voltage while in this port creates a direct short, blowing DMM fuses.</li></ul>" },
            @{ type="content"; title="Measuring Voltage Safely"; diagram="volt_measure"; bullets="<ul><li><strong>Parallel Rules:</strong> Always connect meter probes in parallel across the power source or load.</li><li><strong>Auto-Ranging:</strong> Modern DMMs automatically select decimal precision; manual meters require setting dial higher than target voltage.</li><li><strong>Live Probing:</strong> Ensure fingers stay behind the protective plastic guards on probe handles.</li></ul>" },
            @{ type="content"; title="Measuring Resistance"; diagram="ohm_measure"; bullets="<ul><li><strong>Dead Circuit Rule:</strong> Never measure resistance on an active, powered circuit. Doing so destroys the DMM.</li><li><strong>Isolation Rule:</strong> Disconnect at least one wire lead of the target component. Prevents current taking alternate parallel loops.</li><li><strong>Unit Values:</strong> Read values: Ohm ($\Omega$), Kilo-Ohm ($\text{K}\Omega = 1,000\,\Omega$), Mega-Ohm ($\text{M}\Omega = 1,000,000\,\Omega$).</li></ul>" },
            @{ type="content"; title="Continuity Testing"; diagram="continuity_test"; bullets="<ul><li><strong>Buzzer Output:</strong> DMM emits a continuous beep if path resistance is low (typically $< 30\,\Omega$).</li><li><strong>Line Integrity:</strong> Trace long cable paths by shorting pairs at one end and checking for beeps at the other.</li><li><strong>Short Detection:</strong> Touch probes between different cores in a cable; a beep indicates a damaged short-circuit fault.</li></ul>" },
            @{ type="content"; title="Diagnostic: Socket Voltage Audit"; diagram="socket_test"; bullets="<ul><li><strong>Mains Test standard:</strong> Measure socket terminals directly:<ul><li>Phase-to-Neutral: $230\text{V AC} \pm10\%$ (Grid feed).</li><li>Phase-to-Earth: $230\text{V AC} \pm10\%$ (Earthing line path).</li><li>Neutral-to-Earth: $< 2\text{V AC}$ (Confirming a balanced neutral).</li></ul></li></ul>" },
            @{ type="content"; title="Diagnostic: Security EOL Loops"; diagram="eol_loop"; bullets="<ul><li><strong>EOL Resistors:</strong> Intrusion panels monitor zone loops using End-of-Line resistors to detect tampering.</li><li><strong>Loop Values:</strong> Measure loop resistance to find fault states:<ul><li>$1\text{K}\Omega$ to $4.7\text{K}\Omega$ = Normal (Secure).</li><li>$0\,\Omega$ = Short circuit fault (Wire bypass).</li><li>$\infty\,\Omega$ (OL) = Open loop fault (Cut cable).</li></ul></li></ul>" },
            @{ type="content"; title="Practical Lab Guide"; diagram="multimeter"; bullets="<div class='lab-block'><h3>Lab Work: Fault Finding</h3><ol><li>Verify socket voltages: Phase-Neutral, Phase-Earth, Neutral-Earth.</li><li>Trace open and short faults in test junction box loops.</li><li>Check insulation resistance values.</li></ol></div>" }
        )
    },
    
    # Session 4: Electrical Safety & Breakers
    @{
        num = 4
        title = "Electrical Safety & Breakers"
        accent_color = "#ef4444"
        accent_glow = "rgba(239, 68, 68, 0.4)"
        diagram = "shock_path"
        slides = @(
            @{ type="title"; title="Electrical Safety & Breakers" },
            @{ type="content"; title="Danger of Electricity"; diagram="shock_path"; bullets="<ul><li><strong>Highlight:</strong> Current passing through tissues blocks standard cardiac nervous control signals.</li><li><strong>Voltage vs Current:</strong> Voltage acts as the force, but current (Amperage) determines actual physical severity.</li><li><strong>Hand-to-Hand Path:</strong> The most dangerous path because current crosses the heart cavity directly.</li></ul>" },
            @{ type="content"; title="Current Damage Thresholds"; diagram="shock_scale"; bullets="<ul><li><strong>1mA:</strong> Perception threshold; slight tickle.</li><li><strong>10mA:</strong> Muscle contraction limit. Motor control is lost; victim cannot release grip on wire.</li><li><strong>30mA:</strong> Thoracic contraction; respiration stops. (RCCB trip threshold).</li><li><strong>100mA:</strong> Ventricular fibrillation of the heart. Fatal in seconds if not immediately cleared.</li></ul>" },
            @{ type="content"; title="Lockout-Tagout (LOTO) Rules"; diagram="loto_tag"; bullets="<ul><li><strong>De-energize:</strong> Switch off and isolate main isolator breakers before starting site work.</li><li><strong>Lock:</strong> Apply padlocks to isolation switches to prevent accidental restart.</li><li><strong>Tag:</strong> Hang warning tags stating name and active work info.</li><li><strong>Verify:</strong> Always use a validated DMM or tester to check for zero potential on terminals.</li></ul>" },
            @{ type="content"; title="Overcurrent: Overload vs Short"; diagram="overload_short"; bullets="<ul><li><strong>Overload:</strong> Connecting too many loads to a circuit beyond wire current capacity. Slowly heats up wiring insulation (Fire risk).</li><li><strong>Short Circuit:</strong> A zero-resistance contact between Phase and Neutral. Results in an instant, massive current spike (Arc explosion risk).</li></ul>" },
            @{ type="content"; title="Miniature Circuit Breakers (MCBs)"; diagram="mcb_cutaway"; bullets="<ul><li><strong>Purpose:</strong> Protects copper wiring from overheating damage. Does NOT protect against human shock.</li><li><strong>Thermal Trip:</strong> Bi-metallic strip bends under sustained moderate current overload, mechanical releasing contacts.</li><li><strong>Magnetic Trip:</strong> Internal solenoid pull-pin instantly releases contacts during dead shorts.</li></ul>" },
            @{ type="content"; title="Residual Current Breakers (RCCBs)"; diagram="rccb_balance"; bullets="<ul><li><strong>Toroidal Transformer:</strong> Continuously compares current entering Phase line with current returning through Neutral line.</li><li><strong>Balance Rule:</strong> Phase Current = Neutral Current. Any mismatch means current is leaking to Earth.</li><li><strong>Sensitivity:</strong> A leakage of $\ge 30\text{mA}$ triggers the breaker coil, tripping the panel in under 30 milliseconds.</li></ul>" },
            @{ type="content"; title="Leakage Protection standard"; diagram="shock_compare"; bullets="<ul><li><strong>MCB Limitation:</strong> A human shock draws only 100mA, which is far too low to trip a 16A MCB.</li><li><strong>RCCB Advantage:</strong> RCCBs detect this minor mismatch instantly.</li><li><strong>Regulation:</strong> RCCB protection is mandatory for all wet areas, sockets, and security panel feeds.</li></ul>" },
            @{ type="content"; title="Breaker Testing & Audits"; diagram="db_panel"; bullets="<ul><li><strong>Test Button:</strong> Mechanical test lever on the RCCB face bypasses current internally to simulate leakage. Must be checked monthly.</li><li><strong>Field Audit:</strong> Bridge Phase to Earth at terminal outlets using a series test lamp to verify RCCB trips.</li></ul>" },
            @{ type="content"; title="Practical Lab Guide"; diagram="safety"; bullets="<div class='lab-block'><h3>Lab Work: Breaker DB Assembly</h3><ol><li>Mount double-pole MCB and 30mA RCCB onto DIN rail inside DB.</li><li>Wire DB inputs, route output lines to switchboard load terminals.</li><li>Simulate leakage with test lamp, verify RCCB safety trip response.</li></ol></div>" }
        )
    },

    # Session 5: Power Supply & SMPS
    @{
        num = 5
        title = "Power Supply & SMPS"
        accent_color = "#3b82f6"
        accent_glow = "rgba(59, 130, 246, 0.4)"
        diagram = "smps"
        slides = @(
            @{ type="title"; title="Power Supply & SMPS" },
            @{ type="content"; title="Linear vs. Switch-Mode (SMPS)"; diagram="smps"; bullets="<ul><li><strong>Linear PSU:</strong> Bulky copper transformers step down AC voltage before rectification. Low efficiency (60%), high heat.</li><li><strong>SMPS PSU:</strong> Rectifies AC mains directly, then switches it at high frequency (100kHz) through a tiny ferrite transformer. High efficiency (90%), lightweight.</li></ul>" },
            @{ type="content"; title="Inside an SMPS"; diagram="smps_schema"; bullets="<ul><li><strong>AC Input Filter:</strong> Suppresses incoming mains noise and surge spikes.</li><li><strong>MOSFET Switch:</strong> Toggles high-voltage DC at 100kHz.</li><li><strong>Schottky Rectifiers:</strong> Convert high-frequency AC to clean, low-voltage DC.</li><li><strong>Filter Capacitors:</strong> Smooth out residual AC ripple to output pure DC.</li></ul>" },
            @{ type="content"; title="SMPS Specification Plates"; diagram="smps_plate"; bullets="<ul><li><strong>Input Range:</strong> Dual-voltage input switch (110V/230VAC).</li><li><strong>Output Rating:</strong> Rated voltage and max current (e.g. 12VDC, 10A).</li><li><strong>Derating factor:</strong> Max capacity drops in high-temperature environments (standard in metal outdoor enclosures).</li></ul>" },
            @{ type="content"; title="Output Voltage Calibration"; diagram="smps_pot"; bullets="<ul><li><strong>Trim Potentiometer:</strong> An adjustable dial (trim pot) on the output block.</li><li><strong>Voltage Drop Compensation:</strong> Stepping up output to 13.5V to offset voltage drops on long cable runs, ensuring 12V arrives at camera terminals.</li></ul>" },
            @{ type="content"; title="Backup Battery Charging"; diagram="battery_charge"; bullets="<ul><li><strong>Float Charge:</strong> Continual charge voltage (13.8V) to keep standby batteries active.</li><li><strong>Blocking Diode:</strong> Prevents battery current from feeding backward into SMPS components during blackouts.</li><li><strong>Instant Cutover:</strong> Relays/diodes route battery backup power to loads instantly when mains power drops.</li></ul>" },
            @{ type="content"; title="SLA Battery Runtime Sizing"; diagram="battery_sizing"; bullets="<ul><li><strong>SLA Batteries:</strong> Sealed Lead Acid batteries are standard backup cells.</li><li><strong>Backup Formula:</strong><div class='highlight-block'>Capacity (Ah) = [Load Amps × Hours] / 0.7</div></li><li><strong>Derating:</strong> Divide by 0.7 to compensate for 30% power loss inside batteries.</li></ul>" },
            @{ type="content"; title="Troubleshooting SMPS Faults"; diagram="smps_faults"; bullets="<ul><li><strong>Capacitor Failure:</strong> Swollen, bulging tops on electrolyte filter caps cause voltage ripple.</li><li><strong>Flickering LED:</strong> Indicates short-circuit overload or regulator loop failure.</li><li><strong>No Output:</strong> Check input fuse continuity and MOSFET shorts.</li></ul>" },
            @{ type="content"; title="Multi-Output Distribution Panels"; diagram="dist_panel"; bullets="<ul><li><strong>PTC Fuses:</strong> Self-resetting thermal fuses protect individual camera feeds. They reset automatically after shorts are cleared.</li><li><strong>Glass Fuses:</strong> Standard glass tube fuses blow instantly, requiring manual replacement.</li><li><strong>Isolation:</strong> Independent fuses prevent single camera short circuits from disabling other cameras.</li></ul>" },
            @{ type="content"; title="Practical Lab Guide"; diagram="smps_calibration"; bullets="<div class='lab-block'><h3>Lab Work: SMPS Pot Adjustment</h3><ol><li>Wire AC inputs to mains utility power.</li><li>Set DMM to DC Voltage, adjust trim pot until output reads 12.2V DC.</li><li>Simulate utility power cut, verify backup battery routes power to 12V cameras.</li></ol></div>" }
        )
    },

    # Session 6: Reading Drawings
    @{
        num = 6
        title = "Reading Drawings"
        accent_color = "#f59e0b"
        accent_glow = "rgba(245, 158, 11, 0.4)"
        diagram = "legend_symbols"
        slides = @(
            @{ type="title"; title="Reading Drawings & Schematics" },
            @{ type="content"; title="Schematic Symbol Legends"; diagram="legend_symbols"; bullets="<ul><li><strong>Relay Coil:</strong> Actuator triggers internal NO/NC states.</li><li><strong>Normally Open (NO):</strong> Circuit disconnected until relay turns active.</li><li><strong>Normally Closed (NC):</strong> Circuit active until relay turns active.</li></ul>" },
            @{ type="content"; title="Single Line Diagrams (SLDs)"; diagram="sld_power"; bullets="<ul><li><strong>Block Representation:</strong> High-level system blueprints mapping primary cables and block terminals.</li><li><strong>Field Paths:</strong> Traces routes of main lines without cluttering layout with individual conductors.</li></ul>" },
            @{ type="content"; title="Schematic Grid Coordinates"; diagram="grid_coordinates"; bullets="<ul><li><strong>Grid Coordinates:</strong> Standard sheet coordinate grids (A-H, 1-8).</li><li><strong>Cross Reference:</strong> Helps installers trace wire connections running across multiple sheets of architectural drawings.</li></ul>" },
            @{ type="content"; title="Wiring Tagging & Ferruling Standards"; diagram="wire_ferrule"; bullets="<ul><li><strong>Ferrules:</strong> Metal sleeves crimped onto stripped wire ends to prevent fraying and ensure high-surface contact.</li><li><strong>Wire Tagging:</strong> Numbered plastic sleeves matching blueprint wire numbers (e.g. wire tag 102).</li></ul>" },
            @{ type="content"; title="What is a Relay & How It Works"; diagram="relay_working"; bullets="<ul><li><strong>Definition:</strong> An electromagnetic switch controlled by a low-voltage electrical signal.</li><li><strong>Components:</strong> Coils, armature magnet, mechanical spring, and contact points.</li><li><strong>Working Logic:</strong> Energizing the coil creates a magnetic field that pulls the armature down, closing the Normally Open (NO) terminal and breaking the Normally Closed (NC) loop.</li></ul>" },
            @{ type="content"; title="Types of Relays"; diagram="relay_types"; bullets="<ul><li><strong>SPST vs SPDT:</strong> Single Pole Single Throw (simple switch) vs Single Pole Double Throw (switches COM between two paths).</li><li><strong>DPDT:</strong> Double Pole Double Throw features two isolated SPDT switches inside a single housing, triggered by one coil.</li><li><strong>Solid State Relays (SSRs):</strong> Optically coupled semiconductor switches. Silent operation, no moving parts, extreme lifecycle.</li></ul>" },
            @{ type="content"; title="The 0/1 Digital Signal Concept"; diagram="digital_signal_wave"; bullets="<ul><li><strong>Binary Logic:</strong> Circuits process states in binary where `0` = Low (0V) and `1` = High (5V or 12V).</li><li><strong>Logical High/Low:</strong> Access controllers read high-voltage inputs as logic state 1, ground links as logic 0.</li><li><strong>Active Low:</strong> Many trigger circuits default to 5V and activate when grounded to 0V (Active Low standard).</li></ul>" },
            @{ type="content"; title="Switching Triggers: Dry vs. Wet"; diagram="dry_wet_contacts"; bullets="<ul><li><strong>Dry Contacts:</strong> Volt-free switch terminals. Isolated contact switches that do not supply voltage (e.g. relay contacts, exit buttons).</li><li><strong>Wet Contacts:</strong> Ports that actively output driving voltage (e.g. 12V output port to power lock directly).</li><li><strong>Safety:</strong> Connecting a voltage source to a dry contact zone panel input can destroy the micro-chips instantly.</li></ul>" },
            @{ type="content"; title="Relays & Electromagnetic Locks"; diagram="relay_contacts"; bullets="<ul><li><strong>EM Lock Wiring:</strong> Requires NC wiring loop. Activating relay breaks circuit, cutting power to release magnet.</li><li><strong>Exit Button:</strong> Connected in series to lock circuit, physically interrupting NC line during egress.</li></ul>" },
            @{ type="content"; title="Access Control Loop Blueprint"; diagram="door_schematic"; bullets="<ul><li><strong>Door Blueprint:</strong> Keypad reader, egress button, EM lock, backup PSU, and alarm terminals.</li><li><strong>Schematic Mapping:</strong> Tracing terminal block pins to make correct field inputs.</li></ul>" },
            @{ type="content"; title="Fire Alarm Relay Integration"; diagram="fire_trigger"; bullets="<ul><li><strong>Safety override:</strong> Fire alarm panel auxiliary dry contacts wired in series to lock power supply line.</li><li><strong>Fail-Safe State:</strong> When fire alarm triggers, circuit breaks, releasing locks automatically for egress.</li></ul>" },
            @{ type="content"; title="Blueprint Troubleshooting"; diagram="drawings_diag"; bullets="<ul><li><strong>Wiring Audit:</strong> Using blueprints to verify terminal potentials using DMM probe leads.</li><li><strong>Loop Isolation:</strong> Tracing specific lines on schematics to locate broken connections or ground loops.</li></ul>" },
            @{ type="content"; title="Practical Lab Guide"; diagram="door_layout"; bullets="<div class='lab-block'><h3>Lab Work: Relay Blueprint Assembly</h3><ol><li>Trace door lock schematic paths.</li><li>Wire keypad, exit push button, and EM lock through relay board.</li><li>Verify fire alarm emergency override logic.</li></ol></div>" }
        )
    },

    # Session 7: Cable Selection & Conduits
    @{
        num = 7
        title = "Cable Selection Conduits"
        accent_color = "#3b82f6"
        accent_glow = "rgba(59, 130, 246, 0.4)"
        diagram = "solid_stranded"
        slides = @(
            @{ type="title"; title="Cable Selection & Conduits" },
            @{ type="content"; title="Wire Sizing Standards"; diagram="solid_stranded"; bullets="<ul><li><strong>Metric sizing:</strong> Cross-section area sized in square millimeters (e.g. 1.5 sq mm).</li><li><strong>Solid Core:</strong> High copper conductivity, low bending flex. Best for structural mains run.</li><li><strong>Stranded Core:</strong> High flexing capability, resistant to metal fatigue. Best for movable security connections.</li></ul>" },
            @{ type="content"; title="Line Voltage Drop Calculations"; diagram="volt_drop_chart"; bullets="<ul><li><strong>Cable Resistance:</strong> Long cable runs act as inline resistors, dropping terminal voltages.</li><li><strong>Drop Calculation:</strong> Select thicker cables for long runs to ensure target operating voltage arrives at load.</li></ul>" },
            @{ type="content"; title="ELV Cable Selection Profiles"; diagram="cable_profiles"; bullets="<ul><li><strong>Coaxial RG59:</strong> For analog video signals.</li><li><strong>Cat6 UTP/FTP:</strong> For high-speed ethernet networks. FTP features aluminum foil shield to block RF noise.</li><li><strong>Multi-core Shielded:</strong> For low-power alarm loops and sensors.</li></ul>" },
            @{ type="content"; title="PVC & GI Conduits"; diagram="conduit_pull"; bullets="<ul><li><strong>Conduits:</strong> Rigid PVC/GI pipes mount to walls to protect cables from moisture, impact, and pests.</li><li><strong>Flexible Pipes:</strong> Corrugated PVC hoses route cables across corners, doors, and moving joint gaps.</li></ul>" },
            @{ type="content"; title="The 40% Fill Rule"; diagram="fill_rule"; bullets="<ul><li><strong>NEC Rule:</strong> Copper cable cross-section area must not exceed 40% of conduit inner area.</li><li><strong>Airflow space:</strong> Leaves 60% empty volume to prevent cable friction during pulls and ensure thermal ventilation.</li></ul>" },
            @{ type="content"; title="Bending & Saddling PVC Pipes"; diagram="pipe_bend"; bullets="<ul><li><strong>Spring Bending:</strong> Bending springs inserted inside PVC conduits allow smooth 90 degree curves without kinks.</li><li><strong>Spacing:</strong> Conduit spacer saddles must secure pipes to wall at regular intervals (every 1 meter).</li></ul>" },
            @{ type="content"; title="Separation of Services"; diagram="separation_lines"; bullets="<ul><li><strong>Noise Isolation:</strong> AC mains emit high-voltage electromagnetic interference fields.</li><li><strong>Spacing Rule:</strong> Low-voltage data conduits must run at least 300 mm away from parallel power pipes.</li></ul>" },
            @{ type="content"; title="Splicing & Jointing Standards"; diagram="splice_types"; bullets="<ul><li><strong>Western Union:</strong> High tensile splice for inline cable extensions.</li><li><strong>Pigtail Joint:</strong> Standard twist joint inside junction boxes.</li><li><strong>Insulation:</strong> Always wrap joints with quality PVC electrical tape or heat-shrink sleeves.</li></ul>" },
            @{ type="content"; title="Practical Lab Guide"; diagram="conduit_mockup"; bullets="<div class='lab-block'><h3>Lab Work: Conduit Pipe Layout</h3><ol><li>Bend 90 degree curves on PVC pipes using bending spring.</li><li>Mount conduits on wall board using saddles, fish Cat6 wires through routes.</li><li>Perform Western Union splice joints inside junction boxes.</li></ol></div>" }
        )
    },

    # Session 8: IP Addressing & Subnetting
    @{
        num = 8
        title = "IP Addressing Subnetting"
        accent_color = "#3b82f6"
        accent_glow = "rgba(59, 130, 246, 0.4)"
        diagram = "ip_octets"
        slides = @(
            @{ type="title"; title="IP Addressing & Subnetting" },
            @{ type="content"; title="What is an IP Address?"; diagram="ip_octets"; bullets="<ul><li><strong>IPv4 Structure:</strong> A 32-bit address split into 4 octets (numbers 0-255).</li><li><strong>Network vs Host:</strong> The Network ID locates the subnet, while the Host ID identifies the individual device (camera, NVR).</li></ul>" },
            @{ type="content"; title="The Subnet Mask"; diagram="subnet_mask"; bullets="<ul><li><strong>Subnet Mask:</strong> A filter that tells the operating system where the network section ends and host section begins.</li><li><strong>Standard Mask:</strong> Class C standard (255.255.255.0) limits local hosts to 254 devices.</li></ul>" },
            @{ type="content"; title="CIDR Classless Notation"; diagram="cidr_slices"; bullets="<ul><li><strong>Slash Notation:</strong> Combines IP address and mask bits (e.g. 192.168.1.0/24).</li><li><strong>Subnet Slicing:</strong> Slicing larger IP ranges into smaller blocks (e.g. /28 offers 16 IPs, /29 offers 8 IPs).</li></ul>" },
            @{ type="content"; title="Private vs. Public IP Ranges"; diagram="router_ports"; bullets="<ul><li><strong>Private IP (RFC 1918):</strong> Intended for local LAN use (e.g. 192.168.x.x, 10.x.x.x). Cannot route on the internet.</li><li><strong>Public IP:</strong> Unique global address assigned by ISPs, allowing servers to trace internet route directions.</li></ul>" },
            @{ type="content"; title="Gateway & DNS Basics"; diagram="nat_flow"; bullets="<ul><li><strong>Default Gateway:</strong> The local exit interface router port IP (usually 192.168.1.1). Routes out-of-subnet packets.</li><li><strong>DNS Server:</strong> Domain Name System converts URL text into web IPs (Google DNS standard: 8.8.8.8).</li></ul>" },
            @{ type="content"; title="Static IP vs. DHCP Dynamic"; diagram="ip_octets"; bullets="<ul><li><strong>DHCP Server:</strong> Automatically leases temporary IP addresses to user laptops and phones.</li><li><strong>Static IP Standard:</strong> Critical security devices (NVR, cameras, servers) must have permanent static IPs.</li></ul>" },
            @{ type="content"; title="Sizing a CCTV Subnet"; diagram="cidr_slices"; bullets="<ul><li><strong>Subnet Calculation:</strong> Ensure CIDR blocks offer enough host spaces for all cameras and workstations.</li><li><strong>IP Conservation:</strong> Prevents network conflicts and IP address exhaustion on large multi-camera systems.</li></ul>" },
            @{ type="content"; title="Common Configuration Errors"; diagram="subnet_mask"; bullets="<ul><li><strong>Invalid IP:</strong> Setting an IP address that lies outside the defined subnet gateway block range.</li><li><strong>Mismatched Masks:</strong> Restricts target devices from listening to NVR requests.</li></ul>" },
            @{ type="content"; title="Lab Session Work"; diagram="ip_octets"; bullets="<div class='lab-block'><h3>Lab Work: Setup Local Subnet</h3><ol><li>Connect two workstations via switch, manually configure static IPs inside /24 subnet.</li><li>Execute ping command tests to confirm link setup.</li><li>Alter subnet mask on one host, observe and resolve failure.</li></ol></div>" }
        )
    },

    # Session 9: Router & Switch Configuration
    @{
        num = 9
        title = "Router Switch Configuration"
        accent_color = "#10b981"
        accent_glow = "rgba(16, 185, 129, 0.4)"
        diagram = "router_ports"
        slides = @(
            @{ type="title"; title="Router & Switch Configuration" },
            @{ type="content"; title="Router vs. Switch"; diagram="router_ports"; bullets="<ul><li><strong>Router:</strong> Directs traffic between separate networks (WAN/LAN routing).</li><li><strong>Switch:</strong> Links local hosts together inside the same network (MAC-based forwarding).</li></ul>" },
            @{ type="content"; title="WAN vs. LAN Interfaces"; diagram="router_ports"; bullets="<ul><li><strong>WAN Port:</strong> Takes the ISP public IP feed link.</li><li><strong>LAN Ports:</strong> Distribute local switch connections using private IP subnets.</li></ul>" },
            @{ type="content"; title="NAT (Network Address Translation)"; diagram="nat_flow"; bullets="<ul><li><strong>Function:</strong> Translates local private IP requests to single public WAN IP.</li><li><strong>Protection:</strong> Shields LAN hosts from direct unauthorized external internet scanning.</li></ul>" },
            @{ type="content"; title="Port Forwarding Rules"; diagram="nat_flow"; bullets="<ul><li><strong>Incoming Access:</strong> Forwards external requests on target ports (e.g. port 80 for NVR) to local IPs.</li><li><strong>DDNS:</strong> Dynamic DNS updates public IP tags automatically.</li></ul>" },
            @{ type="content"; title="IP Reservation (Static DHCP)"; diagram="ip_octets"; bullets="<ul><li><strong>Logic:</strong> Bind a device MAC address to a specific permanent IP within router DHCP database.</li><li><strong>Benefit:</strong> Devices retain fixed IP addresses without manual static configuration on client firmware.</li></ul>" },
            @{ type="content"; title="Wi-Fi Channel Spacing"; diagram="ac_dc_ripple"; bullets="<ul><li><strong>2.4GHz Band:</strong> Overlapping frequencies can cause signal drops. Enforce clean channels (1, 6, 11).</li><li><strong>5GHz Band:</strong> Offers high-throughput speed and clean, non-overlapping channels (best for IP camera loops).</li></ul>" },
            @{ type="content"; title="Wi-Fi Security standards"; diagram="loto_tag"; bullets="<ul><li><strong>WPA2/WPA3:</strong> Standard encryption methods. Avoid weak WEP formats.</li><li><strong>WPS Danger:</strong> Disable Wi-Fi Protected Setup to block pin-hacking tools.</li></ul>" },
            @{ type="content"; title="Switch Backplane Bandwidth"; diagram="dist_panel"; bullets="<ul><li><strong>Backplane Capacity:</strong> Maximum internal speed capacity of a switch chassis.</li><li><strong>Congestion:</strong> Ensure backplane bandwidth can support aggregate camera megabit feeds.</li></ul>" },
            @{ type="content"; title="Lab Session Work"; diagram="router_ports"; bullets="<div class='lab-block'><h3>Lab Work: Router Port Rules</h3><ol><li>Login to local router admin portal, customize DHCP address range.</li><li>Create port forwarding paths for an simulated NVR target.</li><li>Setup WPA2 security keys and analyze Wi-Fi channel signals.</li></ol></div>" }
        )
    },

    # Session 10: VLAN Basics
    @{
        num = 10
        title = "VLAN Basics"
        accent_color = "#f59e0b"
        accent_glow = "rgba(245, 158, 11, 0.4)"
        diagram = "vlan_logical"
        slides = @(
            @{ type="title"; title="VLAN Basics & Segmentation" },
            @{ type="content"; title="What is a VLAN?"; diagram="vlan_logical"; bullets="<ul><li><strong>VLAN Definition:</strong> Virtual LAN partitions a physical switch into multiple isolated logical sub-networks.</li><li><strong>Broadcast Domain:</strong> Restricts network search packets within specific VLAN boundaries.</li></ul>" },
            @{ type="content"; title="Why Segment CCTV Traffic?"; diagram="vlan_logical"; bullets="<ul><li><strong>Performance:</strong> Isolates massive continuous video data streams from general corporate LAN traffic.</li><li><strong>Security:</strong> Restricts user hosts from tracing, intercepting, or hacking NVR cameras and recorders.</li></ul>" },
            @{ type="content"; title="Access Switch Ports"; diagram="router_ports"; bullets="<ul><li><strong>Access Port:</strong> Configured for a single dedicated VLAN. Used to connect camera devices or office PCs.</li><li><strong>Untagged:</strong> End device frames enter and leave the port without VLAN ID headers.</li></ul>" },
            @{ type="content"; title="Trunk Switch Ports"; diagram="wire_ferrule"; bullets="<ul><li><strong>Trunk Port:</strong> Uplink link that carries data streams for multiple VLANs simultaneously over one wire.</li><li><strong>802.1Q Tagging:</strong> Switch appends a 4-byte header tag listing VLAN ID to identify network paths.</li></ul>" },
            @{ type="content"; title="Layer 2 vs. Layer 3 Switches"; diagram="vlan_logical"; bullets="<ul><li><strong>L2 Switch:</strong> Forwards traffic only within the same VLAN. Cannot cross boundaries.</li><li><strong>L3 Switch:</strong> Features internal IP routing, allowing data routing between segmented VLANs.</li></ul>" },
            @{ type="content"; title="Inter-VLAN Routing"; diagram="nat_flow"; bullets="<ul><li><strong>Routing Logic:</strong> Uses a router sub-interface link or L3 switch to forward packets across VLANs.</li><li><strong>Access Control:</strong> Enforces rules defining which clients are allowed to view NVR servers.</li></ul>" },
            @{ type="content"; title="VLAN Security Rules"; diagram="loto_tag"; bullets="<ul><li><strong>IP isolation:</strong> Unused open ports must be disabled or assigned to isolated dummy VLAN pools.</li><li><strong>Device Binding:</strong> Enforce MAC security to prevent user laptops from spoofing camera ports.</li></ul>" },
            @{ type="content"; title="Managed Switch Interface"; diagram="router_ports"; bullets="<ul><li><strong>Admin Console:</strong> Access CLI commands or web GUI to configure port mappings.</li><li><strong>Tag Configuration:</strong> Explicitly assign trunk links between rack distribution switches.</li></ul>" },
            @{ type="content"; title="Lab Session Work"; diagram="vlan_logical"; bullets="<div class='lab-block'><h3>Lab Work: Switch VLAN Configuration</h3><ol><li>Access managed switch GUI panel via admin laptop.</li><li>Create VLAN 10 (Office Data) and VLAN 20 (CCTV camera line).</li><li>Set specific ports to Access, configure trunk port between switches.</li></ol></div>" }
        )
    },

    # Session 11: PoE & PoE Switches
    @{
        num = 11
        title = "PoE PoE Switches"
        accent_color = "#ef4444"
        accent_glow = "rgba(239, 68, 68, 0.4)"
        diagram = "poe_cable"
        slides = @(
            @{ type="title"; title="PoE & PoE Switches" },
            @{ type="content"; title="What is PoE?"; diagram="poe_cable"; bullets="<ul><li><strong>Power over Ethernet:</strong> Delivers DC power and ethernet data simultaneously over single Cat6 cable.</li><li><strong>Advantages:</strong> Eliminates the need for separate local AC adapters and mains cabling at camera spots.</li></ul>" },
            @{ type="content"; title="PoE Standards: af, at, bt"; diagram="poe_cable"; bullets="<ul><li><strong>802.3af (PoE):</strong> Supplies up to 15.4W. Suitable for standard IP domes.</li><li><strong>802.3at (PoE+):</strong> Supplies up to 30W. Required for PTZ cameras and heated shells.</li><li><strong>802.3bt (PoE++):</strong> Supplies up to 60W/90W. Required for high-power infrared domes.</li></ul>" },
            @{ type="content"; title="Power Budget Calculations"; diagram="dist_panel"; bullets="<ul><li><strong>Switch Budget:</strong> The maximum cumulative wattage capacity of the PoE switch.</li><li><strong>Overload Risks:</strong> Exceeding budget causes random camera reboots when IR LEDs turn on at night.</li></ul>" },
            @{ type="content"; title="Active vs. Passive PoE"; diagram="nat_flow"; bullets="<ul><li><strong>Active (802.3af/at):</strong> Performs handshake checks. Protects non-PoE laptops from damage.</li><li><strong>Passive PoE:</strong> Delivers constant static DC voltage (usually 24V or 48V) without handshake validation.</li></ul>" },
            @{ type="content"; title="PoE Pinout Wiring Modes"; diagram="rj45_crimp_standard"; bullets="<ul><li><strong>Mode A:</strong> Power combined on data pins (1, 2, 3, 6).</li><li><strong>Mode B:</strong> Power routed over unused spare pins (4, 5, 7, 8).</li></ul>" },
            @{ type="content"; title="PoE Splitters & Extenders"; diagram="poe_split"; bullets="<ul><li><strong>PoE Splitter:</strong> Extracts DC power (12V) and data from PoE line for non-PoE devices.</li><li><strong>PoE Extender:</strong> Inline repeater to bypass standard 100m distance limits.</li></ul>" },
            @{ type="content"; title="Distance Limits & Voltage Drop"; diagram="volt_drop_chart"; bullets="<ul><li><strong>Standard Range:</strong> Max distance is 100m.</li><li><strong>Resistance Drop:</strong> Long runs increase resistance, dropping voltage below camera operating thresholds.</li></ul>" },
            @{ type="content"; title="PoE Switch Port Diagnostics"; diagram="router_ports"; bullets="<ul><li><strong>Indicator LED status:</strong> Confirm steady link speeds, yellow draw status, and overload flashing.</li><li><strong>GUI Monitor:</strong> Review real-time port wattage draws on switch dashboards.</li></ul>" },
            @{ type="content"; title="Lab Session Work"; diagram="poe_split"; bullets="<div class='lab-block'><h3>Lab Work: PoE Sizing & Wiring</h3><ol><li>Compute total load budget for an 8-camera NVR layout.</li><li>Wire a non-PoE IP camera using inline PoE splitter module.</li><li>Audit port draws on managed switch utility tab.</li></ol></div>" }
        )
    },

    # Session 12: Fiber Optic Basics
    @{
        num = 12
        title = "Fiber Optic Basics"
        accent_color = "#3b82f6"
        accent_glow = "rgba(59, 130, 246, 0.4)"
        diagram = "fiber_light"
        slides = @(
            @{ type="title"; title="Fiber Optic Basics" },
            @{ type="content"; title="Copper vs. Fiber Optic"; diagram="volt_drop_chart"; bullets="<ul><li><strong>Range comparison:</strong> Cat6 copper limit is 100m; fiber runs extend past 10km.</li><li><strong>Noise Immunity:</strong> Fiber uses light pulse signals, immune to high-voltage EMI interference.</li></ul>" },
            @{ type="content"; title="Single-Mode vs. Multi-Mode"; diagram="fiber_light"; bullets="<ul><li><strong>Single-Mode (SM):</strong> Narrow core (9 microns), laser source. Long distances (up to 40km).</li><li><strong>Multi-Mode (MM):</strong> Wider core (50 microns), LED source. Short runs (up to 550m).</li></ul>" },
            @{ type="content"; title="SFP Transceiver Modules"; diagram="sfp_module"; bullets="<ul><li><strong>SFP:</strong> Small Form-factor Pluggable modular transceiver slots on switches.</li><li><strong>Media Speeds:</strong> Configure Gigabit SFP or 10G SFP+ to handle backhaul fiber lines.</li></ul>" },
            @{ type="content"; title="Fiber Connector Types"; diagram="sfp_module"; bullets="<ul><li><strong>LC Connector:</strong> Snap-in clip connector. Standard on SFP transceiver inserts.</li><li><strong>SC Connector:</strong> Square push-pull socket standard on media converters.</li></ul>" },
            @{ type="content"; title="Fiber Media Converters"; diagram="router_ports"; bullets="<ul><li><strong>Purpose:</strong> Convert copper RJ45 electrical signals to fiber light signals.</li><li><strong>Application:</strong> Extends network reach for outlying security poles beyond 100m.</li></ul>" },
            @{ type="content"; title="Optical Insertion Loss & Audits"; diagram="fiber_light"; bullets="<ul><li><strong>Loss Attenuation:</strong> Signal strength drop caused by joints, dust, and bends.</li><li><strong>Contamination:</strong> Dust particles on connector faces block laser light transmission. Clean with optical fluid.</li></ul>" },
            @{ type="content"; title="Enclosures & Splicing (LIU)"; diagram="dist_panel"; bullets="<ul><li><strong>LIU Panel:</strong> Light Interface Unit. Protects optical splicing trays and splits.</li><li><strong>Fusion Splicing:</strong> Welding glass cores together using high-voltage arcs.</li></ul>" },
            @{ type="content"; title="Laser Safety & Handling Rules"; diagram="loto_tag"; bullets="<ul><li><strong>Eye Danger:</strong> Never look directly into optical ports or active fiber tips. Laser light is invisible IR and burns retinas instantly.</li><li><strong>Handling:</strong> Properly dispose of glass fiber shards after stripping.</li></ul>" },
            @{ type="content"; title="Lab Session Work"; diagram="sfp_module"; bullets="<div class='lab-block'><h3>Lab Work: Fiber Uplink Setup</h3><ol><li>Install SFP transceivers into gigabit managed switches.</li><li>Connect switches using LC duplex optical patch cords.</li><li>Verify status LEDs on fiber media converter units.</li></ol></div>" }
        )
    },

    # Session 13: Network Troubleshooting
    @{
        num = 13
        title = "Network Troubleshooting"
        accent_color = "#f59e0b"
        accent_glow = "rgba(245, 158, 11, 0.4)"
        diagram = "rj45_crimp_standard"
        slides = @(
            @{ type="title"; title="Network Troubleshooting" },
            @{ type="content"; title="RJ45 Ethernet Crimping (T568A & T568B)"; diagram="rj45_crimp_standard"; bullets="<ul><li><strong>Two Wiring Standards:</strong> T568A and T568B define how copper pins map to plug contacts. T568B is the commercial standard.</li><li><strong>Color Codes (Pin 1 to 8):</strong><ul><li><strong>T568A:</strong> Stripe Green (Half Green/White), Green, Stripe Orange (Half Orange/White), Blue, Stripe Blue (Half Blue/White), Orange, Stripe Brown (Half Brown/White), Brown.</li><li><strong>T568B:</strong> Stripe Orange (Half Orange/White), Orange, Stripe Green (Half Green/White), Blue, Stripe Blue (Half Blue/White), Green, Stripe Brown (Half Brown/White), Brown.</li></ul></li><li><strong>Straight-Through vs Crossover:</strong> Straight-through uses the same standard at both ends. Crossover uses T568A at one end and T568B at the other.</li></ul>" },
            @{ type="content"; title="RJ11 Telephone Crimping Standard"; diagram="rj11_crimp_standard"; bullets="<ul><li><strong>RJ11 Connector:</strong> Enforces 6P4C or 6P2C modular plugs. Used for intercoms and analog phone lines.</li><li><strong>Pin Sequence:</strong> Central active wire pairs (standard color sequence: Black, Red, Green, Yellow).</li></ul>" },
            @{ type="content"; title="Network Cable Testers"; diagram="rj45_crimp_standard"; bullets="<ul><li><strong>Continuity Test:</strong> Verifies pin-to-pin links. Locates broken cores and short circuits.</li><li><strong>Wiremap Faults:</strong> Identifies crossed pairs, split pairs, and pin reversals.</li></ul>" },
            @{ type="content"; title="Diagnostic: Ping Command"; diagram="nat_flow"; bullets="<ul><li><strong>CMD ping:</strong> Utility to test network end-to-end device reachability.</li><li><strong>Latency stats:</strong> Measures response time in milliseconds, helps locate bad connections.</li></ul>" },
            @{ type="content"; title="Diagnostic: Traceroute (tracert)"; diagram="nat_flow"; bullets="<ul><li><strong>Tracert Command:</strong> Maps network routing hop paths to identify gateway blockages.</li><li><strong>Isolate faults:</strong> Shows where data packets drop or get blocked by firewall rules.</li></ul>" },
            @{ type="content"; title="IP Network Scanner Audits"; diagram="ip_octets"; bullets="<ul><li><strong>IP Scanning:</strong> Audits all active IP addresses and MAC cards on subnet.</li><li><strong>Audit Check:</strong> Locates missing cameras and identifies unauthorized device links.</li></ul>" },
            @{ type="content"; title="Resolving IP Address Conflicts"; diagram="ip_octets"; bullets="<ul><li><strong>IP Collision:</strong> Mismatch when two devices are assigned the same IP. Disconnects both.</li><li><strong>Resolution:</strong> Set up permanent DHCP MAC reservations on router.</li></ul>" },
            @{ type="content"; title="Switch Loops & Spanning Tree"; diagram="vlan_logical"; bullets="<ul><li><strong>Network Loops:</strong> Double uplink loops block switches with broadcast storms, freezing the network.</li><li><strong>STP Protocol:</strong> Spanning Tree Protocol detects and disables loop links automatically.</li></ul>" },
            @{ type="content"; title="Lab Session Work"; diagram="rj45_crimp_standard"; bullets="<div class='lab-block'><h3>Lab Work: Crimping & Troubleshooting</h3><ol><li>Crimp Cat6 RJ45 patch cable (T568B), verify with LAN tester.</li><li>Crimp RJ11 phone connector (6P4C), verify pinouts.</li><li>Execute ping and tracert command diagnostics to locate failed links.</li></ol></div>" }
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
    <div class="slide-tag">Module 1 - Session $($session.num)</div>
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
    
    $filename = "m1_s0$($session.num)_$($session.title.ToLower().Replace(' ', '_').Replace('&', '').Replace('__', '_')).html"
    if ($session.num -ge 10) {
        $filename = "m1_s$($session.num)_$($session.title.ToLower().Replace(' ', '_').Replace('&', '').Replace('__', '_')).html"
    }
    $filepath = "$outputDir\$filename"
    Set-Content -Path $filepath -Value $file_content -Encoding utf8
    Write-Host "Generated $filename"
}

# Now generate updated index
$index_template = @"
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Module 1 Slide Decks - Index</title>
<style>
  :root {
    --bg-color: #0b0f19;
    --card-bg: rgba(20, 30, 55, 0.6);
    --accent-color: #3b82f6;
    --accent-glow: rgba(59, 130, 246, 0.4);
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
    padding: 50px 20px;
    max-width: 1200px;
    margin: 0 auto;
    min-height: 100vh;
  }

  h1 {
    font-size: 36px;
    font-weight: 800;
    margin-bottom: 10px;
    text-align: center;
    color: #ffffff;
  }

  h2.sub {
    font-size: 18px;
    color: var(--text-muted);
    font-weight: 500;
    text-align: center;
    margin-bottom: 50px;
  }

  .grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 30px;
  }

  .card {
    background: var(--card-bg);
    border: 1px solid var(--border-color);
    border-radius: 12px;
    padding: 30px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    transition: all 0.3s ease;
    text-decoration: none;
    color: var(--text-main);
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
  }

  .card:hover {
    border-color: var(--accent-color);
    box-shadow: 0 10px 25px var(--accent-glow);
    transform: translateY(-5px);
  }

  .day-tag {
    font-size: 12px;
    font-weight: 700;
    color: var(--accent-color);
    text-transform: uppercase;
    margin-bottom: 15px;
    letter-spacing: 1px;
  }

  .title {
    font-size: 20px;
    font-weight: 700;
    margin-bottom: 10px;
    color: #ffffff;
  }

  .desc {
    font-size: 14px;
    color: var(--text-muted);
    line-height: 1.5;
    margin-bottom: 25px;
    flex-grow: 1;
  }

  .btn {
    background: rgba(255, 255, 255, 0.05);
    border: 1px solid var(--border-color);
    color: var(--text-main);
    padding: 10px 16px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 600;
    text-align: center;
    transition: all 0.2s ease;
  }

  .card:hover .btn {
    background: var(--accent-color);
    border-color: var(--accent-color);
  }
</style>
</head>
<body>

<h1>Module 1: Electrical & Networking</h1>
<h2 class="sub">Session 1 to 13 Interactive Slide Decks with 2-Column Vector Diagrams</h2>

<div class="grid">
  <!-- Session 1 -->
  <a href="m1_s01_electrical_fundamentals_ac_dc.html" class="card">
    <div>
      <div class="day-tag">Session 1</div>
      <div class="title">Electrical Fundamentals</div>
      <div class="desc">Voltage, Current, Resistance, Ohm's Law, SPDT Staircase switches, and crimping ferrules.</div>
    </div>
    <div class="btn">Open Presentation</div>
  </a>

  <!-- Session 2 -->
  <a href="m1_s02_earthing_surge_protection.html" class="card" style="--accent-color: #10b981; --accent-glow: rgba(16, 185, 129, 0.4);">
    <div>
      <div class="day-tag">Session 2</div>
      <div class="title">Earthing & Surge Protection</div>
      <div class="desc">GI ground pipe pit layers, SPDs down-conductors, and test lamp earth conductivity checks.</div>
    </div>
    <div class="btn">Open Presentation</div>
  </a>

  <!-- Session 3 -->
  <a href="m1_s03_multimeter_diagnostics.html" class="card" style="--accent-color: #f59e0b; --accent-glow: rgba(245, 158, 11, 0.4);">
    <div>
      <div class="day-tag">Session 3</div>
      <div class="title">Multimeter & Diagnostics</div>
      <div class="desc">DMM probe ports and selector dials, continuity trace loops, and short circuit fault-finding practicals.</div>
    </div>
    <div class="btn">Open Presentation</div>
  </a>

  <!-- Session 4 -->
  <a href="m1_s04_electrical_safety_breakers.html" class="card" style="--accent-color: #ef4444; --accent-glow: rgba(239, 68, 68, 0.4);">
    <div>
      <div class="day-tag">Session 4</div>
      <div class="title">Electrical Safety & Breakers</div>
      <div class="desc">Shock current impact thresholds, LOTO safety guidelines, MCB/RCCB and series test lamp trip tests.</div>
    </div>
    <div class="btn">Open Presentation</div>
  </a>

  <!-- Session 5 -->
  <a href="m1_s05_power_supply_smps.html" class="card" style="--accent-color: #3b82f6; --accent-glow: rgba(59, 130, 246, 0.4);">
    <div>
      <div class="day-tag">Session 5</div>
      <div class="title">Power Supply & SMPS</div>
      <div class="desc">High-frequency converters, specification plates, SLA battery runtime formulas, and SMPS pot calibrations.</div>
    </div>
    <div class="btn">Open Presentation</div>
  </a>

  <!-- Session 6 -->
  <a href="m1_s06_reading_drawings.html" class="card" style="--accent-color: #f59e0b; --accent-glow: rgba(245, 158, 11, 0.4);">
    <div>
      <div class="day-tag">Session 6</div>
      <div class="title">Reading Drawings</div>
      <div class="desc">Legend symbols, single line diagrams, wire ferruling tags, relays working, dry/wet contacts and lock blueprints.</div>
    </div>
    <div class="btn">Open Presentation</div>
  </a>

  <!-- Session 7 -->
  <a href="m1_s07_cable_selection_conduits.html" class="card">
    <div>
      <div class="day-tag">Session 7</div>
      <div class="title">Cable Selection & Conduits</div>
      <div class="desc">AWG vs Metric, conduit fill calculations, AC/DC line separation, and manual spring bending practicals.</div>
    </div>
    <div class="btn">Open Presentation</div>
  </a>

  <!-- Session 8 -->
  <a href="m1_s08_ip_addressing_subnetting.html" class="card" style="--accent-color: #3b82f6; --accent-glow: rgba(59, 130, 246, 0.4);">
    <div>
      <div class="day-tag">Session 8</div>
      <div class="title">IP Addressing & Subnetting</div>
      <div class="desc">IPv4 Octets, CIDR slash masks, gateway routes, Static vs DHCP and network mapping.</div>
    </div>
    <div class="btn">Open Presentation</div>
  </a>

  <!-- Session 9 -->
  <a href="m1_s09_router_switch_configuration.html" class="card" style="--accent-color: #10b981; --accent-glow: rgba(16, 185, 129, 0.4);">
    <div>
      <div class="day-tag">Session 9</div>
      <div class="title">Router & Switch Configuration</div>
      <div class="desc">WAN vs LAN, NAT translation flows, port forwarding tunnels, and Wi-Fi SSID channels setup.</div>
    </div>
    <div class="btn">Open Presentation</div>
  </a>

  <!-- Session 10 -->
  <a href="m1_s10_vlan_basics.html" class="card" style="--accent-color: #f59e0b; --accent-glow: rgba(245, 158, 11, 0.4);">
    <div>
      <div class="day-tag">Session 10</div>
      <div class="title">VLAN Basics</div>
      <div class="desc">Virtual LAN segments, 802.1Q tagged trunks, L2/L3 routes and port access groups.</div>
    </div>
    <div class="btn">Open Presentation</div>
  </a>

  <!-- Session 11 -->
  <a href="m1_s11_poe_poe_switches.html" class="card" style="--accent-color: #ef4444; --accent-glow: rgba(239, 68, 68, 0.4);">
    <div>
      <div class="day-tag">Session 11</div>
      <div class="title">PoE & PoE Switches</div>
      <div class="desc">802.3af/at/bt standards, active vs passive handshakes, power budgets and pinout wiring modes.</div>
    </div>
    <div class="btn">Open Presentation</div>
  </a>

  <!-- Session 12 -->
  <a href="m1_s12_fiber_optic_basics.html" class="card" style="--accent-color: #3b82f6; --accent-glow: rgba(59, 130, 246, 0.4);">
    <div>
      <div class="day-tag">Session 12</div>
      <div class="title">Fiber Optic Basics</div>
      <div class="desc">SM vs MM cores, SFP modular ports, SC/LC fiber links, media converters and laser safety rules.</div>
    </div>
    <div class="btn">Open Presentation</div>
  </a>

  <!-- Session 13 -->
  <a href="m1_s13_network_troubleshooting.html" class="card" style="--accent-color: #f59e0b; --accent-glow: rgba(245, 158, 11, 0.4);">
    <div>
      <div class="day-tag">Session 13</div>
      <div class="title">Network Troubleshooting</div>
      <div class="desc">RJ45 T568B and RJ11 crimping, wiremap tester diagnostic commands, IP collisions and switch loop storms.</div>
    </div>
    <div class="btn">Open Presentation</div>
  </a>
</div>

</body>
</html>
"@

# Set-Content -Path "$outputDir\slides_index.html" -Value $index_template -Encoding utf8
Write-Host "Slides Index generation skipped in this script."
