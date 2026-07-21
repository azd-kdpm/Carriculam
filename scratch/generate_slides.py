import os

# Define the slides directory
output_dir = r"C:\Users\asadu\.gemini\antigravity\brain\e8179a66-1e06-4b01-aa03-b57af1713c43\slides"
os.makedirs(output_dir, exist_ok=True)

# Common Slide Template
template = """<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Session {session_num}: {session_title}</title>
<style>
  :root {{
    --bg-color: #0b0f19;
    --card-bg: rgba(20, 30, 55, 0.6);
    --accent-color: {accent_color};
    --accent-glow: {accent_glow};
    --text-main: #f3f4f6;
    --text-muted: #9ca3af;
    --border-color: rgba(255, 255, 255, 0.08);
  }}

  * {{
    box-sizing: border-box;
    margin: 0;
    padding: 0;
  }}

  body {{
    background-color: var(--bg-color);
    color: var(--text-main);
    font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, Roboto, sans-serif;
    overflow: hidden;
    height: 100vh;
    width: 100vw;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
  }}

  .deck {{
    flex-grow: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    padding: 30px;
  }}

  .slide {{
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
  }}

  .slide.active {{
    display: flex;
  }}

  .slide-header {{
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    border-bottom: 1px solid var(--border-color);
    padding-bottom: 15px;
  }}

  .slide-tag {{
    background: rgba(255, 255, 255, 0.05);
    color: var(--accent-color);
    font-weight: 700;
    font-size: 11px;
    padding: 4px 10px;
    border-radius: 20px;
    text-transform: uppercase;
    letter-spacing: 1px;
    border: 1px solid var(--accent-color);
  }}

  .slide-title {{
    font-size: 28px;
    font-weight: 700;
    color: #ffffff;
    margin-bottom: 15px;
  }}

  /* 2-Column Layout */
  .slide-body {{
    display: grid;
    grid-template-columns: 1.2fr 0.8fr;
    gap: 30px;
    font-size: 17px;
    line-height: 1.5;
    color: var(--text-main);
    flex-grow: 1;
    overflow: hidden;
  }}

  .text-content {{
    overflow-y: auto;
    padding-right: 10px;
  }}

  .visual-content {{
    display: flex;
    align-items: center;
    justify-content: center;
    background: rgba(0, 0, 0, 0.2);
    border: 1px solid var(--border-color);
    border-radius: 12px;
    padding: 20px;
    position: relative;
    overflow: hidden;
  }}

  .visual-content svg {{
    max-width: 100%;
    max-height: 100%;
  }}

  ul, ol {{
    margin-left: 20px;
    margin-bottom: 15px;
  }}

  li {{
    margin-bottom: 10px;
  }}

  li strong {{
    color: var(--accent-color);
  }}

  .highlight-block {{
    background: rgba(255, 255, 255, 0.02);
    border-left: 4px solid var(--accent-color);
    padding: 12px;
    border-radius: 0 8px 8px 0;
    margin: 15px 0;
    font-style: italic;
    font-size: 15px;
  }}

  .lab-block {{
    background: rgba(16, 185, 129, 0.08);
    border: 1px solid rgba(16, 185, 129, 0.3);
    border-left: 4px solid #10b981;
    padding: 15px;
    border-radius: 8px;
    margin: 15px 0;
  }}

  .lab-block h3 {{
    color: #10b981;
    font-size: 18px;
    margin-bottom: 8px;
  }}

  table {{
    width: 100%;
    border-collapse: collapse;
    margin: 15px 0;
    font-size: 13px;
  }}

  th {{
    background-color: rgba(255, 255, 255, 0.03);
    color: var(--accent-color);
    border: 1px solid var(--border-color);
    padding: 6px;
    text-align: left;
  }}

  td {{
    border: 1px solid var(--border-color);
    padding: 6px;
  }}

  .controls-bar {{
    height: 60px;
    background: rgba(15, 22, 40, 0.8);
    border-top: 1px solid var(--border-color);
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 40px;
    z-index: 100;
  }}

  .nav-buttons {{
    display: flex;
    gap: 15px;
  }}

  .btn {{
    background: rgba(255, 255, 255, 0.05);
    border: 1px solid var(--border-color);
    color: var(--text-main);
    padding: 6px 12px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 600;
    transition: all 0.2s ease;
  }}

  .btn:hover {{
    background: var(--accent-color);
    border-color: var(--accent-color);
    box-shadow: 0 0 10px var(--accent-glow);
  }}

  .btn:disabled {{
    opacity: 0.3;
    cursor: not-allowed;
    background: transparent;
  }}

  .slide-counter {{
    font-size: 13px;
    color: var(--text-muted);
  }}

  .progress-container {{
    width: 100%;
    height: 4px;
    background: rgba(255, 255, 255, 0.05);
    position: absolute;
    bottom: 0;
    left: 0;
  }}

  .progress-bar {{
    height: 100%;
    background: var(--accent-color);
    width: 0%;
    transition: width 0.3s ease;
  }}

  @keyframes fadeIn {{
    from {{ opacity: 0; transform: translateY(10px); }}
    to {{ opacity: 1; transform: translateY(0); }}
  }}

  .title-slide {{
    justify-content: center;
    align-items: center;
    text-align: center;
  }}

  .title-slide h1 {{
    font-size: 42px;
    font-weight: 800;
    color: #ffffff;
    margin-bottom: 15px;
  }}

  .title-slide h2 {{
    font-size: 18px;
    color: var(--text-muted);
    font-weight: 500;
    margin-bottom: 30px;
  }}
</style>
</head>
<body>

<div class="deck">
{slides_html}
</div>

<div class="controls-bar">
  <div class="nav-buttons">
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
    slides.forEach((slide, index) => {{
      if (index === currentSlide) {{
        slide.classList.add('active');
      }} else {{
        slide.classList.remove('active');
      }}
    }});

    prevBtn.disabled = currentSlide === 0;
    nextBtn.disabled = currentSlide === slides.length - 1;

    const progress = (currentSlide / (slides.length - 1)) * 100;
    progressBar.style.width = `${progress}%`;
  }}

  prevBtn.addEventListener('click', () => {{
    if (currentSlide > 0) {{
      currentSlide--;
      updateSlides();
    }}
  }});

  nextBtn.addEventListener('click', () => {{
    if (currentSlide < slides.length - 1) {{
      currentSlide++;
      updateSlides();
    }}
  }});

  document.addEventListener('keydown', (e) => {{
    if (e.key === 'ArrowRight' || e.key === ' ' || e.key === 'PageDown') {{
      if (currentSlide < slides.length - 1) {{
        currentSlide++;
        updateSlides();
      }}
    }} else if (e.key === 'ArrowLeft' || e.key === 'PageUp') {{
      if (currentSlide > 0) {{
        currentSlide--;
        updateSlides();
      }}
    }}
  }});

  fullscreenBtn.addEventListener('click', () => {{
    if (!document.fullscreenElement) {{
      document.documentElement.requestFullscreen().catch(err => {{
        alert(`Error enabling fullscreen: ${{err.message}}`);
      }});
    }} else {{
      document.exitFullscreen();
    }}
  }});
</script>
</body>
</html>
"""

# Simple helper to generate SVGs
def get_svg(diagram_type):
    if diagram_type == "circuit":
        return """<svg viewBox="0 0 200 150" width="100%">
          <rect x="10" y="10" width="180" height="130" fill="none" stroke="#3b82f6" stroke-width="3" stroke-dasharray="5 3"/>
          <line x1="10" y1="75" x2="60" y2="75" stroke="#3b82f6" stroke-width="3"/>
          <line x1="80" y1="75" x2="130" y2="75" stroke="#3b82f6" stroke-width="3"/>
          <!-- Battery symbol -->
          <line x1="60" y1="60" x2="60" y2="90" stroke="#f59e0b" stroke-width="4"/>
          <line x1="70" y1="68" x2="70" y2="82" stroke="#f59e0b" stroke-width="2"/>
          <line x1="80" y1="60" x2="80" y2="90" stroke="#f59e0b" stroke-width="4"/>
          <!-- Resistor symbol -->
          <path d="M 130 75 L 140 65 L 150 85 L 160 65 L 170 85 L 180 75" fill="none" stroke="#ef4444" stroke-width="3"/>
          <line x1="180" y1="75" x2="190" y2="75" stroke="#3b82f6" stroke-width="3"/>
          <text x="70" y="45" fill="#f3f4f6" font-family="sans-serif" font-size="12" text-anchor="middle">DC Supply</text>
          <text x="155" y="45" fill="#f3f4f6" font-family="sans-serif" font-size="12" text-anchor="middle">Load (R)</text>
        </svg>"""
    elif diagram_type == "safety":
        return """<svg viewBox="0 0 200 150" width="100%">
          <polygon points="100,20 20,130 180,130" fill="none" stroke="#ef4444" stroke-width="6"/>
          <path d="M 100 50 L 100 95" stroke="#ef4444" stroke-width="8" stroke-linecap="round"/>
          <circle cx="100" cy="115" r="5" fill="#ef4444"/>
          <text x="100" y="145" fill="#f3f4f6" font-family="sans-serif" font-size="12" font-weight="bold" text-anchor="middle">DANGER: HIGH VOLTAGE</text>
        </svg>"""
    elif diagram_type == "earthing":
        return """<svg viewBox="0 0 200 150" width="100%">
          <!-- Soil layers -->
          <rect x="10" y="60" width="180" height="80" fill="#2b1a0a" opacity="0.3"/>
          <!-- Earth rod -->
          <rect x="95" y="20" width="10" height="100" fill="#9ca3af" stroke="#6b7280"/>
          <!-- Copper wire -->
          <path d="M 50 10 Q 75 10 95 25" fill="none" stroke="#f59e0b" stroke-width="3"/>
          <!-- Earth symbol ground -->
          <line x1="80" y1="120" x2="120" y2="120" stroke="#10b981" stroke-width="4"/>
          <line x1="88" y1="128" x2="112" y2="128" stroke="#10b981" stroke-width="3"/>
          <line x1="94" y1="136" x2="106" y2="136" stroke="#10b981" stroke-width="2"/>
          <text x="100" y="15" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Earth Pit</text>
        </svg>"""
    elif diagram_type == "drawing":
        return """<svg viewBox="0 0 200 150" width="100%">
          <rect x="20" y="20" width="160" height="110" fill="none" stroke="#9ca3af" stroke-width="2"/>
          <!-- Relay switch schematic representation -->
          <circle cx="50" cy="75" r="10" fill="none" stroke="#f59e0b" stroke-width="3"/>
          <line x1="60" y1="75" x2="100" y2="75" stroke="#f59e0b" stroke-width="2"/>
          <!-- NC/NO contacts -->
          <line x1="100" y1="55" x2="140" y2="40" stroke="#ef4444" stroke-width="3"/>
          <circle cx="100" cy="55" r="4" fill="#ef4444"/>
          <circle cx="140" cy="55" r="4" fill="#ef4444"/>
          <text x="100" y="142" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Schematic Legend</text>
        </svg>"""
    elif diagram_type == "cable":
        return """<svg viewBox="0 0 200 150" width="100%">
          <rect x="20" y="55" width="160" height="40" rx="10" fill="none" stroke="#3b82f6" stroke-width="3"/>
          <!-- Copper cores inside -->
          <line x1="10" y1="65" x2="190" y2="65" stroke="#ef4444" stroke-width="3"/>
          <line x1="10" y1="75" x2="190" y2="75" stroke="#10b981" stroke-width="3"/>
          <line x1="10" y1="85" x2="190" y2="85" stroke="#f59e0b" stroke-width="3"/>
          <text x="100" y="125" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">Conduit Separation</text>
        </svg>"""
    elif diagram_type == "smps":
        return """<svg viewBox="0 0 200 150" width="100%">
          <!-- Block 1 -->
          <rect x="10" y="50" width="45" height="40" fill="rgba(239, 68, 68, 0.1)" stroke="#ef4444" stroke-width="2"/>
          <text x="32" y="75" fill="#f3f4f6" font-family="sans-serif" font-size="9" text-anchor="middle">AC IN</text>
          <!-- Block 2 -->
          <rect x="70" y="50" width="55" height="40" fill="rgba(59, 130, 246, 0.1)" stroke="#3b82f6" stroke-width="2"/>
          <text x="97" y="75" fill="#f3f4f6" font-family="sans-serif" font-size="9" text-anchor="middle">MOSFET/Switch</text>
          <!-- Block 3 -->
          <rect x="140" y="50" width="50" height="40" fill="rgba(16, 185, 129, 0.1)" stroke="#10b981" stroke-width="2"/>
          <text x="165" y="75" fill="#f3f4f6" font-family="sans-serif" font-size="9" text-anchor="middle">DC OUT</text>
          <!-- Arrows -->
          <path d="M 55 70 L 70 70" stroke="#f59e0b" stroke-width="2" marker-end="url(#arrow)"/>
          <path d="M 125 70 L 140 70" stroke="#f59e0b" stroke-width="2" marker-end="url(#arrow)"/>
          <text x="100" y="125" fill="#f3f4f6" font-family="sans-serif" font-size="11" text-anchor="middle">SMPS Topology</text>
        </svg>"""
    elif diagram_type == "multimeter":
        return """<svg viewBox="0 0 200 150" width="100%">
          <rect x="60" y="15" width="80" height="120" rx="10" fill="none" stroke="#f59e0b" stroke-width="3"/>
          <rect x="70" y="25" width="60" height="30" fill="none" stroke="#9ca3af" stroke-width="2"/>
          <text x="100" y="45" fill="#10b981" font-family="monospace" font-size="14" text-anchor="middle">230.5V</text>
          <!-- Probe dots -->
          <circle cx="90" cy="115" r="5" fill="#ef4444"/>
          <circle cx="110" cy="115" r="5" fill="#111827" stroke="#9ca3af"/>
          <text x="100" y="145" fill="#f3f4f6" font-family="sans-serif" font-size="10" text-anchor="middle">DMM Interface</text>
        </svg>"""
    return ""

# Slides data
slides_data = [
    {
        "num": 1,
        "title": "Electrical Fundamentals (AC/DC)",
        "color": "#3b82f6",
        "glow": "rgba(59, 130, 246, 0.4)",
        "slides": [
            {
                "title": "Electrical Fundamentals",
                "tag": "Session 1 - Slide 1",
                "type": "title",
                "bullets": ""
            },
            {
                "title": "Voltage, Current & Resistance",
                "tag": "Session 1 - Slide 2",
                "type": "content",
                "diagram": "circuit",
                "bullets": """<ul>
                  <li><strong>Voltage (V):</strong> Electrical pressure forcing charges to move. Sized in Volts.</li>
                  <li><strong>Current (I):</strong> The rate of flow of electrical charge. Sized in Amperes.</li>
                  <li><strong>Resistance (R):</strong> Material friction resisting current flow. Sized in Ohms.</li>
                </ul>
                <div class="highlight-block">Ohm's Law: V = I × R is the core formula.</div>"""
            },
            {
                "title": "AC vs. DC Basics",
                "tag": "Session 1 - Slide 3",
                "type": "content",
                "diagram": "circuit",
                "bullets": """<ul>
                  <li><strong>Alternating Current (AC):</strong> Electron flow switches direction periodically. Kerala grid runs at 230V AC, 50Hz.</li>
                  <li><strong>Direct Current (DC):</strong> Constant flow in one direction only. Batteries and low-voltage security devices run on DC (12V/5V).</li>
                </ul>"""
            },
            {
                "title": "Series vs. Parallel Circuits",
                "tag": "Session 1 - Slide 4",
                "type": "content",
                "diagram": "circuit",
                "bullets": """<ul>
                  <li><strong>Series Circuits:</strong> Only one path. If one bulb fails, the entire loop breaks.</li>
                  <li><strong>Parallel Circuits:</strong> Multiple independent paths. Standard for security installations so devices run separately.</li>
                </ul>"""
            },
            {
                "title": "Practical Lab Guide",
                "tag": "Session 1 - Slide 5",
                "type": "content",
                "diagram": "circuit",
                "bullets": """<div class="lab-block">
                  <h3>Lab Work: Switchboard Assembly</h3>
                  <ol>
                    <li>Mount switches, indicator bulb, and socket on base.</li>
                    <li>Connect Phase, Neutral, and Ground using standard 1.5 sq mm copper wire.</li>
                    <li>Power on and measure terminal voltage using multimeter.</li>
                  </ol>
                </div>"""
            }
        ]
    },
    {
        "num": 2,
        "title": "Electrical Safety & Breakers",
        "color": "#ef4444",
        "glow": "rgba(239, 68, 68, 0.4)",
        "slides": [
            {
                "title": "Electrical Safety & Breakers",
                "tag": "Session 2 - Slide 1",
                "type": "title",
                "bullets": ""
            },
            {
                "title": "Electric Shock Physics",
                "tag": "Session 2 - Slide 2",
                "type": "content",
                "diagram": "safety",
                "bullets": """<ul>
                  <li><strong>Body Resistance:</strong> Drops drastically when wet.</li>
                  <li><strong>Current Thresholds:</strong>
                    <ul>
                      <li>10mA: Painful muscle cramp.</li>
                      <li>30mA: Breathing stops (RCCB trip target).</li>
                      <li>100mA: Fatal heart failure.</li>
                    </ul>
                  </li>
                </ul>"""
            },
            {
                "title": "RCCB & MCB Protection",
                "tag": "Session 2 - Slide 3",
                "type": "content",
                "diagram": "safety",
                "bullets": """<ul>
                  <li><strong>MCB (Miniature Circuit Breaker):</strong> Protects wiring from short-circuits and overloads.</li>
                  <li><strong>RCCB (Residual Current Circuit Breaker):</strong> Instantly cuts power if it detects minor leakage (30mA) running through human body or ground faults.</li>
                </ul>"""
            },
            {
                "title": "Practical Lab Guide",
                "tag": "Session 2 - Slide 4",
                "type": "content",
                "diagram": "safety",
                "bullets": """<div class="lab-block">
                  <h3>Lab Work: Breaker Trip Tests</h3>
                  <ol>
                    <li>Mount double-pole MCB and 30mA RCCB inside DB.</li>
                    <li>Wire DB supply output to switchboard load.</li>
                    <li>Safely bridge Phase to Earth using a series test lamp to trigger RCCB safety trip.</li>
                  </ol>
                </div>"""
            }
        ]
    },
    {
        "num": 3,
        "title": "Earthing & Surge Protection",
        "color": "#10b981",
        "glow": "rgba(16, 185, 129, 0.4)",
        "slides": [
            {
                "title": "Earthing & Surge Protection",
                "tag": "Session 3 - Slide 1",
                "type": "title",
                "bullets": ""
            },
            {
                "title": "Grounding Pit Basics",
                "tag": "Session 3 - Slide 2",
                "type": "content",
                "diagram": "earthing",
                "bullets": """<ul>
                  <li><strong>Purpose:</strong> Low resistance drain route for fault currents to protect hardware and users.</li>
                  <li><strong>GI Pipe Pit:</strong> Drive metal pipe, backfilled with layers of charcoal and salt to retain soil moisture.</li>
                </ul>"""
            },
            {
                "title": "Testing Ground Path",
                "tag": "Session 3 - Slide 3",
                "type": "content",
                "diagram": "earthing",
                "bullets": """<ul>
                  <li><strong>Mains Test:</strong> Bridge Phase to Earth using 60W test lamp.</li>
                  <li><strong>Analysis:</strong> Full bright glow confirms low resistance path; dim or no glow reveals loose clamps or weak soil.</li>
                </ul>"""
            },
            {
                "title": "Practical Lab Guide",
                "tag": "Session 3 - Slide 4",
                "type": "content",
                "diagram": "earthing",
                "bullets": """<div class="lab-block">
                  <h3>Lab Work: Earth Audit</h3>
                  <ol>
                    <li>Secure copper wire clamp to GI earth pipe using brass bolts.</li>
                    <li>Wire DB ground bus bar to earth pit.</li>
                    <li>Measure Phase-Earth loop using multimeter and series test lamp.</li>
                  </ol>
                </div>"""
            }
        ]
    },
    {
        "num": 4,
        "title": "Reading Electrical Drawings",
        "color": "#f59e0b",
        "glow": "rgba(245, 158, 11, 0.4)",
        "slides": [
            {
                "title": "Reading Electrical Drawings",
                "tag": "Session 4 - Slide 1",
                "type": "title",
                "bullets": ""
            },
            {
                "title": "Schematic Symbols",
                "tag": "Session 4 - Slide 2",
                "type": "content",
                "diagram": "drawing",
                "bullets": """<ul>
                  <li><strong>Relay Coil:</strong> Actuator actuator triggers internal NO/NC states.</li>
                  <li><strong>Normally Open (NO):</strong> Circuit disconnected until relay turns active.</li>
                  <li><strong>Normally Closed (NC):</strong> Circuit active until relay turns active.</li>
                </ul>"""
            },
            {
                "title": "Grid Map Tracking",
                "tag": "Session 4 - Slide 3",
                "type": "content",
                "diagram": "drawing",
                "bullets": """<ul>
                  <li><strong>Grid Coordinates:</strong> Standard sheet coordinate grids (A-H, 1-8).</li>
                  <li><strong>Cross Reference:</strong> Helps installers trace wire connections running across multiple sheets of architectural drawings.</li>
                </ul>"""
            },
            {
                "title": "Practical Lab Guide",
                "tag": "Session 4 - Slide 4",
                "type": "content",
                "diagram": "drawing",
                "bullets": """<div class="lab-block">
                  <h3>Lab Work: Blueprint Relay Wiring</h3>
                  <ol>
                    <li>Analyze schematic sheet lines.</li>
                    <li>Wire a 24V DC relay board to release an electromagnetic lock.</li>
                    <li>crimp cable ends, apply ferrule tags matching the printout.</li>
                  </ol>
                </div>"""
            }
        ]
    },
    {
        "num": 5,
        "title": "Cable Selection & Conduits",
        "color": "#3b82f6",
        "glow": "rgba(59, 130, 246, 0.4)",
        "slides": [
            {
                "title": "Cable Selection & Conduits",
                "tag": "Session 5 - Slide 1",
                "type": "title",
                "bullets": ""
            },
            {
                "title": "Separation of Services",
                "tag": "Session 5 - Slide 2",
                "type": "content",
                "diagram": "cable",
                "bullets": """<ul>
                  <li><strong>Noise Interference:</strong> AC power lines induce voltage noise on data/signal lines.</li>
                  <li><strong>Standard Rule:</strong> Maintain 300 mm spacing between power and network conduits; cross only at right angles.</li>
                </ul>"""
            },
            {
                "title": "Conduit Rules",
                "tag": "Session 5 - Slide 3",
                "type": "content",
                "diagram": "cable",
                "bullets": """<ul>
                  <li><strong>40% Fill Rule:</strong> Leave 60% empty space inside PVC/GI pipes to ensure heat ventilation and easy pulling.</li>
                  <li><strong>Wire Splices:</strong> Wrap pigtail/Western Union joints inside junction boxes only—never inside the pipe.</li>
                </ul>"""
            },
            {
                "title": "Practical Lab Guide",
                "tag": "Session 5 - Slide 4",
                "type": "content",
                "diagram": "cable",
                "bullets": """<div class="lab-block">
                  <h3>Lab Work: Pipe and Joint Layout</h3>
                  <ol>
                    <li>Bend $90^\circ$ curves on PVC conduits using bending spring.</li>
                    <li>Saddle pipes to wall, fish Cat6 wires through conduits.</li>
                    <li>Splice pigtail joints inside PVC boxes, wrap with insulation tape.</li>
                  </ol>
                </div>"""
            }
        ]
    },
    {
        "num": 6,
        "title": "Power Supply & SMPS Calibration",
        "color": "#3b82f6",
        "glow": "rgba(59, 130, 246, 0.4)",
        "slides": [
            {
                "title": "Power Supply & SMPS Calibration",
                "tag": "Session 6 - Slide 1",
                "type": "title",
                "bullets": ""
            },
            {
                "title": "SMPS Operations",
                "tag": "Session 6 - Slide 2",
                "type": "content",
                "diagram": "smps",
                "bullets": """<ul>
                  <li><strong>MOSFET Switch:</strong> Toggles AC input at high frequency (100kHz).</li>
                  <li><strong>Transformers:</strong> Bulky linear transformer replaced by tiny high-frequency ferrite core.</li>
                  <li><strong>Output:</strong> Highly regulated DC, high efficiency (90%).</li>
                </ul>"""
            },
            {
                "title": "SLA Battery Sizing",
                "tag": "Session 6 - Slide 3",
                "type": "content",
                "diagram": "smps",
                "bullets": """<ul>
                  <li><strong>Float Charge:</strong> Continual float charge (13.8V) to keep battery fully charged.</li>
                  <li><strong>Sizing Formula:</strong>
                    <div class="highlight-block">Capacity (Ah) = [Load Current (A) × Hours] / 0.7</div>
                  </li>
                </ul>"""
            },
            {
                "title": "Practical Lab Guide",
                "tag": "Session 6 - Slide 4",
                "type": "content",
                "diagram": "smps",
                "bullets": """<div class="lab-block">
                  <h3>Lab Work: SMPS Calibration</h3>
                  <ol>
                    <li>Wire SMPS L/N/E inputs to mains utility power.</li>
                    <li>Set multimeter to DC, adjust output trim pot to 12.2V DC.</li>
                    <li>Connect 12V battery backup, simulate utility cut, check load.</li>
                  </ol>
                </div>"""
            }
        ]
    },
    {
        "num": 7,
        "title": "Multimeter Diagnostics",
        "color": "#f59e0b",
        "glow": "rgba(245, 158, 11, 0.4)",
        "slides": [
            {
                "title": "Multimeter Diagnostics",
                "tag": "Session 7 - Slide 1",
                "type": "title",
                "bullets": ""
            },
            {
                "title": "Safe DMM Operation",
                "tag": "Session 7 - Slide 2",
                "type": "content",
                "diagram": "multimeter",
                "bullets": """<ul>
                  <li><strong>Dial Protection:</strong> Verify selection is on Voltage mode before probing live lines.</li>
                  <li><strong>Jack Ports:</strong> Always connect black probe to COM and red to V-Ohm-mA port.</li>
                </ul>"""
            },
            {
                "title": "Continuity & Ground Leakage",
                "tag": "Session 7 - Slide 3",
                "type": "content",
                "diagram": "multimeter",
                "bullets": """<ul>
                  <li><strong>Continuity:</strong> Bleep test to check cable copper lines for open loop breaks.</li>
                  <li><strong>Ground Leakage:</strong> High resistance Ohm test to check if live wiring is leaking current to earth lines.</li>
                </ul>"""
            },
            {
                "title": "Practical Lab Guide",
                "tag": "Session 7 - Slide 4",
                "type": "content",
                "diagram": "multimeter",
                "bullets": """<div class="lab-block">
                  <h3>Lab Work: Fault Finding</h3>
                  <ol>
                    <li>Verify socket voltages: Phase-Neutral, Phase-Earth, Neutral-Earth.</li>
                    <li>Trace open and short faults in test junction box loops.</li>
                    <li>Check insulation resistance values.</li>
                  </ol>
                </div>"""
            }
        ]
    }
]

# Generate each slide deck HTML file
for data in slides_data:
    slides_html = ""
    for s_idx, s in enumerate(data["slides"]):
        active_class = " active" if s_idx == 0 else ""
        if s["type"] == "title":
            slides_html += f"""  <!-- Slide {s_idx+1} -->
  <div class="slide{active_class} title-slide">
    <div class="slide-tag">Module 1 - Session {data['num']}</div>
    <h1>{s['title']}</h1>
    <h2>{data['title']}</h2>
    <div class="instructor-tag">Low-Voltage Systems & Automation Training Series</div>
  </div>\n"""
        else:
            svg_content = get_svg(s.get("diagram", ""))
            slides_html += f"""  <!-- Slide {s_idx+1} -->
  <div class="slide{active_class}">
    <div class="slide-header">
      <div class="slide-tag">{s['tag']}</div>
      <div class="slide-counter">Slide {s_idx+1} of {len(data['slides'])}</div>
    </div>
    <h2 class="slide-title">{s['title']}</h2>
    <div class="slide-body">
      <div class="text-content">
        {s['bullets']}
      </div>
      <div class="visual-content">
        {svg_content}
      </div>
    </div>
  </div>\n"""

    file_content = template.format(
        session_num=data["num"],
        session_title=data["title"],
        accent_color=data["color"],
        accent_glow=data["glow"],
        slides_html=slides_html
    )

    filename = f"m1_d{data['num']:02d}_{data['title'].lower().replace(' ', '_').replace('&_', '').replace('/', '_')}.html"
    filepath = os.path.join(output_dir, filename)
    with open(filepath, "w", encoding="utf-8") as f:
        f.write(file_content)
    print(f"Generated {filename}")

# Generate the slides_index.html page
index_template = """<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Module 1 Slide Decks - Index</title>
<style>
  :root {{
    --bg-color: #0b0f19;
    --card-bg: rgba(20, 30, 55, 0.6);
    --accent-color: #3b82f6;
    --accent-glow: rgba(59, 130, 246, 0.4);
    --text-main: #f3f4f6;
    --text-muted: #9ca3af;
    --border-color: rgba(255, 255, 255, 0.08);
  }}

  * {{
    box-sizing: border-box;
    margin: 0;
    padding: 0;
  }}

  body {{
    background-color: var(--bg-color);
    color: var(--text-main);
    font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, Roboto, sans-serif;
    padding: 50px 20px;
    max-width: 1200px;
    margin: 0 auto;
    min-height: 100vh;
  }}

  h1 {{
    font-size: 36px;
    font-weight: 800;
    margin-bottom: 10px;
    text-align: center;
    color: #ffffff;
  }}

  h2.sub {{
    font-size: 18px;
    color: var(--text-muted);
    font-weight: 500;
    text-align: center;
    margin-bottom: 50px;
  }}

  .grid {{
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 30px;
  }}

  .card {{
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
  }}

  .card:hover {{
    border-color: var(--accent-color);
    box-shadow: 0 10px 25px var(--accent-glow);
    transform: translateY(-5px);
  }}

  .day-tag {{
    font-size: 12px;
    font-weight: 700;
    color: var(--accent-color);
    text-transform: uppercase;
    margin-bottom: 15px;
    letter-spacing: 1px;
  }}

  .title {{
    font-size: 20px;
    font-weight: 700;
    margin-bottom: 10px;
    color: #ffffff;
  }}

  .desc {{
    font-size: 14px;
    color: var(--text-muted);
    line-height: 1.5;
    margin-bottom: 25px;
    flex-grow: 1;
  }}

  .btn {{
    background: rgba(255, 255, 255, 0.05);
    border: 1px solid var(--border-color);
    color: var(--text-main);
    padding: 10px 16px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 600;
    text-align: center;
    transition: all 0.2s ease;
  }}

  .card:hover .btn {{
    background: var(--accent-color);
    border-color: var(--accent-color);
  }}
</style>
</head>
<body>

<h1>Module 1: Electrical & Networking</h1>
<h2 class="sub">Session 1 to 7 Interactive Slide Decks with 2-Column Vector Diagrams</h2>

<div class="grid">
  <!-- Session 1 -->
  <a href="m1_d01_electrical_fundamentals_ac_dc.html" class="card">
    <div>
      <div class="day-tag">Session 1</div>
      <div class="title">Electrical Fundamentals</div>
      <div class="desc">Voltage, Current, Resistance, Ohm's Law, and basic switchboard series/parallel wiring practicals.</div>
    </div>
    <div class="btn">Open Presentation</div>
  </a>

  <!-- Session 2 -->
  <a href="m1_d02_electrical_safety_breakers.html" class="card" style="--accent-color: #ef4444; --accent-glow: rgba(239, 68, 68, 0.4);">
    <div>
      <div class="day-tag">Session 2</div>
      <div class="title">Electrical Safety & Breakers</div>
      <div class="desc">Shock current impact thresholds, LOTO safety guidelines, MCB/RCCB and series test lamp trip tests.</div>
    </div>
    <div class="btn">Open Presentation</div>
  </a>

  <!-- Session 3 -->
  <a href="m1_d03_earthing_surge_protection.html" class="card" style="--accent-color: #10b981; --accent-glow: rgba(16, 185, 129, 0.4);">
    <div>
      <div class="day-tag">Session 3</div>
      <div class="title">Earthing & Surge Protection</div>
      <div class="desc">GI ground pipe pit layers, SPDs down-conductors, and test lamp earth conductivity checks.</div>
    </div>
    <div class="btn">Open Presentation</div>
  </a>

  <!-- Session 4 -->
  <a href="m1_d04_reading_electrical_drawings.html" class="card" style="--accent-color: #f59e0b; --accent-glow: rgba(245, 158, 11, 0.4);">
    <div>
      <div class="day-tag">Session 4</div>
      <div class="title">Reading Drawings</div>
      <div class="desc">Legend symbols, single line diagrams, wire ferruling tags, and blueprint door lock wiring practicals.</div>
    </div>
    <div class="btn">Open Presentation</div>
  </a>

  <!-- Session 5 -->
  <a href="m1_d05_cable_selection_conduits.html" class="card">
    <div>
      <div class="day-tag">Session 5</div>
      <div class="title">Cable Selection & Conduits</div>
      <div class="desc">AWG vs Metric, conduit fill calculations, AC/DC line separation, and manual spring bending practicals.</div>
    </div>
    <div class="btn">Open Presentation</div>
  </a>

  <!-- Session 6 -->
  <a href="m1_d06_power_supply_smps_calibration.html" class="card" style="--accent-color: #3b82f6; --accent-glow: rgba(59, 130, 246, 0.4);">
    <div>
      <div class="day-tag">Session 6</div>
      <div class="title">Power Supply & SMPS</div>
      <div class="desc">High-frequency converters, specification plates, SLA battery runtime formulas, and SMPS pot calibrations.</div>
    </div>
    <div class="btn">Open Presentation</div>
  </a>

  <!-- Session 7 -->
  <a href="m1_d07_multimeter_diagnostics.html" class="card" style="--accent-color: #f59e0b; --accent-glow: rgba(245, 158, 11, 0.4);">
    <div>
      <div class="day-tag">Session 7</div>
      <div class="title">Multimeter & Diagnostics</div>
      <div class="desc">DMM probe ports and selector dials, continuity trace loops, and short circuit fault-finding practicals.</div>
    </div>
    <div class="btn">Open Presentation</div>
  </a>
</div>

</body>
</html>
"""

filepath_index = os.path.join(output_dir, "slides_index.html")
with open(filepath_index, "w", encoding="utf-8") as f:
    f.write(index_template)
print("Generated slides_index.html")
