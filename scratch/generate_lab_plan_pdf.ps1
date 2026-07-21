$htmlPath = "C:\Users\asadu\.gemini\antigravity\brain\e8179a66-1e06-4b01-aa03-b57af1713c43\lab_plans.html"
$pdfPath = "C:\Users\asadu\.gemini\antigravity\brain\e8179a66-1e06-4b01-aa03-b57af1713c43\lab_plans.pdf"
$tempPdfPath = "$env:TEMP\lab_plans.pdf"

$htmlContent = @"
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Practical Lab Guide: Security, Automation, & Low-Voltage Systems</title>
<style>
  @page {
    size: A4 portrait;
    margin: 15mm;
  }
  body {
    font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, Roboto, sans-serif;
    color: #1e293b;
    line-height: 1.5;
    padding: 0;
    margin: 0;
    font-size: 10.5pt;
  }
  .title-page {
    page-break-after: always;
    text-align: center;
    padding-top: 50mm;
  }
  .title-page h1 {
    font-size: 28pt;
    color: #0f172a;
    margin-bottom: 5mm;
    font-weight: 800;
  }
  .title-page h2 {
    font-size: 16pt;
    color: #475569;
    font-weight: 400;
    margin-bottom: 20mm;
  }
  .title-page .meta {
    font-size: 11pt;
    color: #64748b;
    line-height: 1.8;
  }
  .section-header {
    border-bottom: 2.5px solid #0f172a;
    padding-bottom: 4px;
    margin-top: 30px;
    color: #0f172a;
    font-size: 16pt;
    font-weight: 700;
    page-break-after: avoid;
  }
  .session-card {
    margin-bottom: 20px;
    border: 1px solid #e2e8f0;
    border-radius: 8px;
    padding: 15px;
    background: #f8fafc;
    page-break-inside: avoid;
  }
  .session-title {
    font-size: 12pt;
    font-weight: 700;
    color: #1e3a8a;
    margin-bottom: 8px;
    border-bottom: 1px solid #cbd5e1;
    padding-bottom: 3px;
  }
  .lab-goal {
    font-weight: 600;
    color: #475569;
    margin-bottom: 6px;
    font-size: 9.5pt;
  }
  .grid-container {
    display: grid;
    grid-template-columns: 1.2fr 0.8fr 0.8fr;
    gap: 12px;
    margin-top: 8px;
  }
  .grid-col {
    font-size: 9pt;
  }
  .grid-col strong {
    color: #0f172a;
    display: block;
    margin-bottom: 4px;
    border-bottom: 1px solid #e2e8f0;
    padding-bottom: 2px;
  }
  ul, ol {
    margin: 0;
    padding-left: 15px;
  }
  li {
    margin-bottom: 3px;
  }
  .module-break {
    page-break-before: always;
  }
</style>
</head>
<body>

<div class="title-page">
  <h1>Practical Lab Guide</h1>
  <h2>Security, Automation, & Low-Voltage Systems Training</h2>
  <div class="meta">
    <strong>Comprehensive Practical Syllabus for 28 Hands-On Sessions</strong><br>
    Module 1: Electrical & Networking Basics (Sessions 1 - 13)<br>
    Module 2: Professional CCTV Systems (Sessions 14 - 28)<br><br>
    <strong>Syllabus Scope:</strong> Step-by-Step Lab Plans, Consumable Materials, & Essential Teaching Tools.
  </div>
</div>

<div class="module-break"></div>
<div class="section-header">Master Tools & Instrumentation Inventory</div>
<p style="margin-bottom:15px; font-size:9.5pt;">Consolidated shopping list of all teaching tools required for the instructor and student workstations across the 28 sessions.</p>

<table style="width:100%; border-collapse:collapse; margin-bottom:25px; font-size:8.5pt;">
  <thead>
    <tr style="background:#0f172a; color:#ffffff;">
      <th style="padding:6px; width:25%;">Category</th>
      <th style="padding:6px; width:45%;">Item Description</th>
      <th style="padding:6px; width:30%;">Primary Sessions Used</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>Hand Tools</b></td>
      <td>Insulated Screwdrivers (Set of Phillips & Flathead 1000V rated), Precision flathead terminal screwdrivers, heavy-duty wire strippers, utility knife.</td>
      <td>Sessions 1, 2, 4, 5, 6, 7, 13, 17, 21, 22, 25</td>
    </tr>
    <tr style="background:#f8fafc;">
      <td><b>Crimping Tools</b></td>
      <td>Pass-through RJ45 modular crimper, BNC compression/hex crimper, Bootlace ferrule crimping tool (four-mandrel design).</td>
      <td>Sessions 1, 6, 13, 14</td>
    </tr>
    <tr>
      <td><b>Conduit & Install Tools</b></td>
      <td>20mm PVC pipe cold-bending spring, mini hacksaw, deburring file, 15m nylon draw-wire (fish tape), measuring tape.</td>
      <td>Sessions 7, 15, 23</td>
    </tr>
    <tr style="background:#f8fafc;">
      <td><b>Heavy Power Tools</b></td>
      <td>Impact hammer drill (reversible), 6mm concrete SDS-plus drill bits.</td>
      <td>Sessions 15, 25</td>
    </tr>
    <tr>
      <td><b>Basic Electrical Testers</b></td>
      <td>Digital Multimeters (DMM with safety probes & leads), AC voltage test pen (non-contact), electrical series test lamp board.</td>
      <td>Sessions 1, 2, 3, 4, 5, 24, 28</td>
    </tr>
    <tr style="background:#f8fafc;">
      <td><b>Network Testers</b></td>
      <td>Digital wiremap cable tester (RJ45/RJ11 mapping), inline PoE voltage/wattage detector, managed switch status console.</td>
      <td>Sessions 11, 13, 28</td>
    </tr>
    <tr>
      <td><b>Fiber & CCTV Testers</b></td>
      <td>Optical power meter (OPM), fiber cleaner click pen (1.25mm/2.5mm), handheld analog video signal level meter.</td>
      <td>Sessions 12, 14, 28</td>
    </tr>
    <tr style="background:#f8fafc;">
      <td><b>Safety Equipment</b></td>
      <td>LOTO lockout safety padlocks, hazard tags, insulated electrician safety gloves, protective eyewear.</td>
      <td>Sessions 2, 4, 12</td>
    </tr>
  </tbody>
</table>

<div class="module-break"></div>
<div class="section-header">Master Bill of Materials & Consumables</div>
<p style="margin-bottom:15px; font-size:9.5pt;">Consolidated shopping list of all hardware modules, switches, cables, and consumables required to supply the lab workstations.</p>

<table style="width:100%; border-collapse:collapse; margin-bottom:25px; font-size:8.5pt;">
  <thead>
    <tr style="background:#0f172a; color:#ffffff;">
      <th style="padding:6px; width:25%;">Category</th>
      <th style="padding:6px; width:45%;">Item Description</th>
      <th style="padding:6px; width:30%;">Primary Sessions Used</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>Electrical Modules</b></td>
      <td>SPDT 6A switches, light holders, 60W incandescent lamps, Single-Phase DIN-rail SPD, SP MCB (6A), RCCB (30mA), 12V 10A multi-channel SMPS, 12V 7Ah SLA backup battery, 12V DC cooling fan, 12V relay modules.</td>
      <td>Sessions 1, 2, 4, 5, 6, 21, 22</td>
    </tr>
    <tr style="background:#f8fafc;">
      <td><b>Lock Hardware</b></td>
      <td>12V DC Electromagnetic Lock (maglock, 280kg holding force).</td>
      <td>Session 6</td>
    </tr>
    <tr>
      <td><b>Network Hardware</b></td>
      <td>L2 Managed Network Switch, 8-Port 802.3at PoE switch (120W budget), SOHO Wi-Fi router, 10/100/1000 copper-to-fiber media converters.</td>
      <td>Sessions 8, 9, 10, 11, 12, 19, 20, 26, 27</td>
    </tr>
    <tr style="background:#f8fafc;">
      <td><b>Fiber Components</b></td>
      <td>Gigabit SFP fiber transceivers (Single-mode LC), LC-LC Duplex optical patch cords.</td>
      <td>Session 12</td>
    </tr>
    <tr>
      <td><b>CCTV Hardwares</b></td>
      <td>Analog BNC test camera, IP dome camera (IK10), AI bullet IP camera, ANPR IP camera, ColorVu IP camera, Bi-spectrum thermal camera, Network PTZ dome camera, 4-Channel PoE NVR recorder, 4-Bay NVR or NAS server.</td>
      <td>Sessions 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28</td>
    </tr>
    <tr style="background:#f8fafc;">
      <td><b>Storage Drives</b></td>
      <td>Identical 2TB Surveillance-grade SATA HDDs (WD Purple or Seagate SkyHawk), hot-swap drive trays.</td>
      <td>Sessions 17, 18</td>
    </tr>
    <tr>
      <td><b>Passive Filters & Baluns</b></td>
      <td>BNC passive UTP video baluns, video ground loop isolator filters.</td>
      <td>Sessions 14, 28</td>
    </tr>
    <tr style="background:#f8fafc;">
      <td><b>Cables & Consumables</b></td>
      <td>RG59 coaxial cable spool, Cat6 UTP bulk cable spool, RJ45 pass-through plugs, RJ11 modular plugs, connector rubber boots, bootlace wire ferrules, ferrule number tags, electrical insulation tape, twin-lead alarm wire, PVC solvent cement, concrete wall anchor plugs, mounting screws, cable zip-ties.</td>
      <td>Sessions 1, 6, 7, 13, 14, 15, 21, 22, 28</td>
    </tr>
  </tbody>
</table>

<div class="module-break"></div>
<div class="section-header">Module 1: Electrical & Networking Basics</div>
<br>

<!-- Session 1 -->
<div class="session-card">
  <div class="session-title">Session 01: Electrical Fundamentals (AC vs. DC)</div>
  <div class="lab-goal">Lab Goal: Wire a fully functional staircase (two-way) lighting loop.</div>
  <div class="grid-container">
    <div class="grid-col">
      <strong>Step-by-Step Lab Plan</strong>
      <ol>
        <li>Identify Phase, Neutral, and Ground terminals.</li>
        <li>Wire two SPDT (3-way) switches in a stairs toggle configuration.</li>
        <li>Connect travel lines between switches, route output to light holder.</li>
        <li>Energize loop, verify dual-location light bulb toggling.</li>
      </ol>
    </div>
    <div class="grid-col">
      <strong>Materials Required</strong>
      <ul>
        <li>2x SPDT switches (6A)</li>
        <li>1x light bulb holder</li>
        <li>1x 60W bulb</li>
        <li>Red, Black, Green wire (1.5mm²)</li>
        <li>Wood/PVC wiring baseboard</li>
      </ul>
    </div>
    <div class="grid-col">
      <strong>Tools to Teach</strong>
      <ul>
        <li>Wire stripper</li>
        <li>Phillips & flat screwdriver</li>
        <li>Phase tester pen</li>
        <li>Electrical insulation tape</li>
      </ul>
    </div>
  </div>
</div>

<!-- Session 2 -->
<div class="session-card">
  <div class="session-title">Session 02: Earthing & Surge Protection</div>
  <div class="lab-goal">Lab Goal: Verify earth continuity and measure voltage drops across Surge Protective Devices (SPDs).</div>
  <div class="grid-container">
    <div class="grid-col">
      <strong>Step-by-Step Lab Plan</strong>
      <ol>
        <li>Perform visual inspection of grounding busbar connections.</li>
        <li>Construct test lamp circuit; connect between Phase and Earth to check trip response.</li>
        <li>Measure AC potential between Neutral-Earth (limit to &lt;2V).</li>
        <li>Install surge protector, verify grounding wire paths.</li>
      </ol>
    </div>
    <div class="grid-col">
      <strong>Materials Required</strong>
      <ul>
        <li>1x Single-Phase SPD module</li>
        <li>Copper earth clamp</li>
        <li>100W incandescent test bulb</li>
        <li>Green ground cable (4mm²)</li>
      </ul>
    </div>
    <div class="grid-col">
      <strong>Tools to Teach</strong>
      <ul>
        <li>Digital Multimeter (DMM)</li>
        <li>Earth ground loop resistance tester</li>
        <li>Insulated safety gloves</li>
      </ul>
    </div>
  </div>
</div>

<!-- Session 3 -->
<div class="session-card">
  <div class="session-title">Session 03: Multimeter & Diagnostics</div>
  <div class="lab-goal">Lab Goal: Measure voltage, resistance, and troubleshoot short circuits.</div>
  <div class="grid-container">
    <div class="grid-col">
      <strong>Step-by-Step Lab Plan</strong>
      <ol>
        <li>Configure DMM selector dial to measure AC mains outlet voltage safely.</li>
        <li>Measure DC potentials on batteries and power adapters.</li>
        <li>Use continuity mode to map a hidden cable bundle.</li>
        <li>Locate open and short circuit faults in a test wiring board.</li>
      </ol>
    </div>
    <div class="grid-col">
      <strong>Materials Required</strong>
      <ul>
        <li>9V battery & 12V DC adapter</li>
        <li>Cartridge glass fuses (2A)</li>
        <li>Test resistors (1kΩ, 10kΩ)</li>
        <li>Hidden junction mock wire box</li>
      </ul>
    </div>
    <div class="grid-col">
      <strong>Tools to Teach</strong>
      <ul>
        <li>2x Digital Multimeters</li>
        <li>Alligator clip leads</li>
        <li>Wire cutters & strippers</li>
      </ul>
    </div>
  </div>
</div>

<!-- Session 4 -->
<div class="session-card">
  <div class="session-title">Session 04: Electrical Safety & Breakers</div>
  <div class="lab-goal">Lab Goal: Test MCB overload tripping and RCCB earth leakage trip points.</div>
  <div class="grid-container">
    <div class="grid-col">
      <strong>Step-by-Step Lab Plan</strong>
      <ol>
        <li>Wire a mock distribution panel with a main MCB and RCCB.</li>
        <li>Apply LOTO locks and safety tagout tags on the circuit breaker.</li>
        <li>Introduce dynamic loads to verify MCB circuit protection.</li>
        <li>Press RCCB test button, and measure leakage trip time manually.</li>
      </ol>
    </div>
    <div class="grid-col">
      <strong>Materials Required</strong>
      <ul>
        <li>1x SP MCB (6A)</li>
        <li>1x RCCB (30mA trip)</li>
        <li>Lockout padlock & safety tag</li>
        <li>Variable load board (bulbs)</li>
      </ul>
    </div>
    <div class="grid-col">
      <strong>Tools to Teach</strong>
      <ul>
        <li>Insulated screwdrivers</li>
        <li>DMM with current clamp</li>
        <li>Series test lamp board</li>
      </ul>
    </div>
  </div>
</div>

<!-- Session 5 -->
<div class="session-card">
  <div class="session-title">Session 05: Power Supply & SMPS</div>
  <div class="lab-goal">Lab Goal: Calibrate SMPS DC potentials and audit battery backup load runtimes.</div>
  <div class="grid-container">
    <div class="grid-col">
      <strong>Step-by-Step Lab Plan</strong>
      <ol>
        <li>Wire 230V AC mains into SMPS input terminals.</li>
        <li>Adjust trimmer potentiometer to calibrate DC output to exactly 13.8V.</li>
        <li>Connect 12V SLA backup battery to SMPS charging lines.</li>
        <li>Cut AC power, monitor battery discharge curves under DC loads.</li>
      </ol>
    </div>
    <div class="grid-col">
      <strong>Materials Required</strong>
      <ul>
        <li>12V 10A multi-channel SMPS</li>
        <li>12V 7Ah SLA backup battery</li>
        <li>12V DC cooling fan (test load)</li>
        <li>Red/Black DC cables</li>
      </ul>
    </div>
    <div class="grid-col">
      <strong>Tools to Teach</strong>
      <ul>
        <li>Precision trimmer screwdriver</li>
        <li>Multimeter</li>
        <li>Crimping tool for spade lugs</li>
      </ul>
    </div>
  </div>
</div>

<!-- Session 6 -->
<div class="session-card">
  <div class="session-title">Session 06: Reading Drawings (Relay & Lock Wiring)</div>
  <div class="lab-goal">Lab Goal: Wire an electromagnetic lock using relay NC/NO dry contacts.</div>
  <div class="grid-container">
    <div class="grid-col">
      <strong>Step-by-Step Lab Plan</strong>
      <ol>
        <li>Decode terminal legend symbols on access control drawings.</li>
        <li>Verify relay dry contact vs wet contact jumper states.</li>
        <li>Wire a 12V maglock to relay normally closed (NC) contacts.</li>
        <li>Trigger relay coil to break loop, verifying lock release.</li>
      </ol>
    </div>
    <div class="grid-col">
      <strong>Materials Required</strong>
      <ul>
        <li>12V Electromagnetic Lock</li>
        <li>12V DC Relay module board</li>
        <li>Bootlace ferrules & numbers</li>
        <li>12V DC power adapter</li>
      </ul>
    </div>
    <div class="grid-col">
      <strong>Tools to Teach</strong>
      <ul>
        <li>Ferrule crimping tool</li>
        <li>Precision screwdrivers</li>
        <li>Wire stripper</li>
      </ul>
    </div>
  </div>
</div>

<!-- Session 7 -->
<div class="session-card">
  <div class="session-title">Session 07: Cable Selection & Conduits</div>
  <div class="lab-goal">Lab Goal: Bends PVC conduit pathways and runs low-voltage lines.</div>
  <div class="grid-container">
    <div class="grid-col">
      <strong>Step-by-Step Lab Plan</strong>
      <ol>
        <li>Calculate wire fill ratios for 20mm PVC pipe paths.</li>
        <li>Insert bending spring inside PVC pipe, execute a clean 90° cold bend.</li>
        <li>Mount conduit saddles to wallboard, secure pipe runs.</li>
        <li>Use draw wire to pull Cat6 UTP cables through bent pipe paths.</li>
      </ol>
    </div>
    <div class="grid-col">
      <strong>Materials Required</strong>
      <ul>
        <li>20mm PVC conduit pipes</li>
        <li>Conduit saddles & wall plugs</li>
        <li>Cat6 UTP cables</li>
        <li>PVC solvent cement</li>
      </ul>
    </div>
    <div class="grid-col">
      <strong>Tools to Teach</strong>
      <ul>
        <li>20mm Bending spring</li>
        <li>Hacksaw & deburring knife</li>
        <li>Nylon fish tape (draw wire)</li>
        <li>Measuring tape</li>
      </ul>
    </div>
  </div>
</div>

<!-- Session 8 -->
<div class="session-card">
  <div class="session-title">Session 08: IP Addressing & Subnetting</div>
  <div class="lab-goal">Lab Goal: Map static subnets and assign manual IP grids to local clients.</div>
  <div class="grid-container">
    <div class="grid-col">
      <strong>Step-by-Step Lab Plan</strong>
      <ol>
        <li>Calculate IP address ranges for a CIDR /28 subnetwork.</li>
        <li>Configure manual IP address and subnet mask on test computer.</li>
        <li>Configure default gateway path to routing hub.</li>
        <li>Run ping tests to verify local LAN interface connectivity.</li>
      </ol>
    </div>
    <div class="grid-col">
      <strong>Materials Required</strong>
      <ul>
        <li>2x Laptops / PCs</li>
        <li>Ethernet patch cables</li>
        <li>Subnetting calculation worksheets</li>
      </ul>
    </div>
    <div class="grid-col">
      <strong>Tools to Teach</strong>
      <ul>
        <li>Windows CMD Terminal</li>
        <li>Wireshark packet analyzer</li>
      </ul>
    </div>
  </div>
</div>

<!-- Session 9 -->
<div class="session-card">
  <div class="session-title">Session 09: Router & Switch Configuration</div>
  <div class="lab-goal">Lab Goal: Setup LAN subnets, configure WAN ports, and port forward services.</div>
  <div class="grid-container">
    <div class="grid-col">
      <strong>Step-by-Step Lab Plan</strong>
      <ol>
        <li>Log into network router administrative GUI panel.</li>
        <li>Configure WAN port for static IP internet access.</li>
        <li>Set up NAT port forwarding rules to link HTTP port 80.</li>
        <li>Configure secure Wi-Fi SSID access profiles and WPA3.</li>
      </ol>
    </div>
    <div class="grid-col">
      <strong>Materials Required</strong>
      <ul>
        <li>SOHO Wi-Fi Router / AP</li>
        <li>Ethernet patch cables</li>
        <li>Client testing laptop</li>
      </ul>
    </div>
    <div class="grid-col">
      <strong>Tools to Teach</strong>
      <ul>
        <li>Web browser console</li>
        <li>Mobile Wi-Fi scanning app</li>
      </ul>
    </div>
  </div>
</div>

<!-- Session 10 -->
<div class="session-card">
  <div class="session-title">Session 10: VLAN Basics</div>
  <div class="lab-goal">Lab Goal: Segment traffic using Layer 2 managed switch VLANs.</div>
  <div class="grid-container">
    <div class="grid-col">
      <strong>Step-by-Step Lab Plan</strong>
      <ol>
        <li>Connect client laptop to switch configuration console.</li>
        <li>Define VLAN 10 (CCTV) and VLAN 20 (Office) on switch database.</li>
        <li>Assign specific switch physical access ports to VLAN groups.</li>
        <li>Configure 802.1Q tagged trunk links between switches.</li>
      </ol>
    </div>
    <div class="grid-col">
      <strong>Materials Required</strong>
      <ul>
        <li>L2 Managed Network Switch</li>
        <li>Ethernet console patch cords</li>
        <li>2x test client laptops</li>
      </ul>
    </div>
    <div class="grid-col">
      <strong>Tools to Teach</strong>
      <ul>
        <li>PuTTY / Terminal Console</li>
        <li>Switch CLI database</li>
      </ul>
    </div>
  </div>
</div>

<!-- Session 11 -->
<div class="session-card">
  <div class="session-title">Session 11: PoE & PoE Switches</div>
  <div class="lab-goal">Lab Goal: Calculate PoE power budgets and deploy splitters/injectors.</div>
  <div class="grid-container">
    <div class="grid-col">
      <strong>Step-by-Step Lab Plan</strong>
      <ol>
        <li>Audit maximum switch wattage budget from manufacturer specifications.</li>
        <li>Calculate aggregate camera draws including startup IR peaks.</li>
        <li>Deploy passive PoE injector to power remote IP camera.</li>
        <li>Use PoE splitter module to power a 12V non-PoE device.</li>
      </ol>
    </div>
    <div class="grid-col">
      <strong>Materials Required</strong>
      <ul>
        <li>802.3at PoE Switch</li>
        <li>Passive PoE injector block</li>
        <li>12V DC active PoE splitter</li>
        <li>Cat6 cables</li>
      </ul>
    </div>
    <div class="grid-col">
      <strong>Tools to Teach</strong>
      <ul>
        <li>Inline PoE Wattage Tester</li>
        <li>Managed switch web utility</li>
      </ul>
    </div>
  </div>
</div>

<!-- Session 12 -->
<div class="session-card">
  <div class="session-title">Session 12: Fiber Optic Basics</div>
  <div class="lab-goal">Lab Goal: Inspect SFP fiber transceiver links and media converters.</div>
  <div class="grid-container">
    <div class="grid-col">
      <strong>Step-by-Step Lab Plan</strong>
      <ol>
        <li>Insert SFP transceivers into managed switch ports.</li>
        <li>Inspect LC fiber connectors using standard optical cleaner.</li>
        <li>Connect LC optical patch cord between SFP switch ports.</li>
        <li>Deploy fiber-to-copper media converter, verify copper LAN bridge.</li>
      </ol>
    </div>
    <div class="grid-col">
      <strong>Materials Required</strong>
      <ul>
        <li>2x Gigabit SFP modules</li>
        <li>LC-LC Duplex fiber patch cord</li>
        <li>Fiber-to-Copper media converter</li>
        <li>Fiber cleaning click pen</li>
      </ul>
    </div>
    <div class="grid-col">
      <strong>Tools to Teach</strong>
      <ul>
        <li>Optical Power Meter (OPM)</li>
        <li>Switch status indicators console</li>
      </ul>
    </div>
  </div>
</div>

<!-- Session 13 -->
<div class="session-card">
  <div class="session-title">Session 13: Network Troubleshooting (RJ45 / RJ11 Crimping)</div>
  <div class="lab-goal">Lab Goal: Crimp Cat6 UTP cables and diagnostic wiremap failures.</div>
  <div class="grid-container">
    <div class="grid-col">
      <strong>Step-by-Step Lab Plan</strong>
      <ol>
        <li>Strip Cat6 outer sheath, separate twisted pairs onto spline.</li>
        <li>Arrange wire strands in T568B sequence, crimp RJ45 plugs.</li>
        <li>Strip phone cable, crimp RJ11 plug in 6P4C central configuration.</li>
        <li>Insert both cables in wiremap tester, audit for split/reversed pairs.</li>
      </ol>
    </div>
    <div class="grid-col">
      <strong>Materials Required</strong>
      <ul>
        <li>Cat6 UTP bulk cable spool</li>
        <li>RJ45 pass-through plugs</li>
        <li>RJ11 modular plugs</li>
        <li>Connector rubber boots</li>
      </ul>
    </div>
    <div class="grid-col">
      <strong>Tools to Teach</strong>
      <ul>
        <li>Pass-through RJ45 crimper</li>
        <li>UTP cable sheath stripper</li>
        <li>Digital wiremap cable tester</li>
      </ul>
    </div>
  </div>
</div>

<div class="module-break section-header">Module 2: Professional CCTV Systems</div>
<br>

<!-- Session 14 -->
<div class="session-card">
  <div class="session-title">Session 14: Analog & IP CCTV</div>
  <div class="lab-goal">Lab Goal: Connect coaxial BNC feeds, video baluns, and compare network video lag.</div>
  <div class="grid-container">
    <div class="grid-col">
      <strong>Step-by-Step Lab Plan</strong>
      <ol>
        <li>Crimp 3-piece BNC connector on RG59 coax, link analog camera to XVR.</li>
        <li>Install video baluns to run analog video over a Cat6 UTP cable.</li>
        <li>Connect IP camera to switch, configure NVR display feed.</li>
        <li>Display stopwatch on monitor, capture lag differentials.</li>
      </ol>
    </div>
    <div class="grid-col">
      <strong>Materials Required</strong>
      <ul>
        <li>RG59 coax cable spool</li>
        <li>3-piece crimp BNC plug</li>
        <li>Passive UTP video baluns</li>
        <li>Analog & IP test cameras</li>
      </ul>
    </div>
    <div class="grid-col">
      <strong>Tools to Teach</strong>
      <ul>
        <li>Coaxial cable rotary stripper</li>
        <li>BNC hex crimping tool</li>
        <li>Video signal level meter</li>
      </ul>
    </div>
  </div>
</div>

<!-- Session 15 -->
<div class="session-card">
  <div class="session-title">Session 15: Camera Selection & Design</div>
  <div class="lab-goal">Lab Goal: Secure wall mount plates and adjust True WDR highlights.</div>
  <div class="grid-container">
    <div class="grid-col">
      <strong>Step-by-Step Lab Plan</strong>
      <ol>
        <li>Mount waterproof junction boxes to a masonry test wallboard.</li>
        <li>Secure bullet and dome cameras onto corresponding bracket plates.</li>
        <li>Aim camera at a high-contrast window backlight.</li>
        <li>Navigate camera web console, toggle WDR to check face details.</li>
      </ol></div>
    <div class="grid-col">
      <strong>Materials Required</strong>
      <ul>
        <li>Dome & Bullet camera shells</li>
        <li>Junction boxes & wall anchors</li>
        <li>Masonry anchor plugs</li>
        <li>Screws & gaskets</li>
      </ul>
    </div>
    <div class="grid-col">
      <strong>Tools to Teach</strong>
      <ul>
        <li>Impact hammer drill</li>
        <li>Concrete drill bits (6mm)</li>
        <li>IP camera config tool</li>
      </ul>
    </div>
  </div>
</div>

<!-- Session 16 -->
<div class="session-card">
  <div class="session-title">Session 16: Lens & Field of View</div>
  <div class="lab-goal">Lab Goal: Calibrate focal lengths and compare zoom resolution degradation.</div>
  <div class="grid-container">
    <div class="grid-col">
      <strong>Step-by-Step Lab Plan</strong>
      <ol>
        <li>Adjust zoom and focus rings on manual varifocal lens.</li>
        <li>Use NVR zoom control panel to drive motorized varifocal cameras.</li>
        <li>Deploy 2.8mm fixed camera, measure blindspots at entryways.</li>
        <li>Magnify target details to compare optical vs digital resolution.</li>
      </ol>
    </div>
    <div class="grid-col">
      <strong>Materials Required</strong>
      <ul>
        <li>Manual varifocal lens camera</li>
        <li>Motorized zoom auto-focus IP camera</li>
        <li>Testing target charts</li>
      </ul>
    </div>
    <div class="grid-col">
      <strong>Tools to Teach</strong>
      <ul>
        <li>Camera focus adjustment tool</li>
        <li>NVR PTZ control interface</li>
        <li>Laser distance meter</li>
      </ul>
    </div>
  </div>
</div>

<!-- Session 17 -->
<div class="session-card">
  <div class="session-title">Session 17: DVR, NVR & Hybrid Recorders</div>
  <div class="lab-goal">Lab Goal: Mount SATA storage disks and configure recording profiles.</div>
  <div class="grid-container">
    <div class="grid-col">
      <strong>Step-by-Step Lab Plan</strong>
      <ol>
        <li>Remove NVR cover, mount surveillance HDD using chassis screws.</li>
        <li>Connect internal SATA data ribbon and motherboard power cords.</li>
        <li>Boot recorder, format disk, verify active storage status.</li>
        <li>Set up continuous vs. motion-triggered storage schedules.</li>
      </ol>
    </div>
    <div class="grid-col">
      <strong>Materials Required</strong>
      <ul>
        <li>4-channel PoE NVR unit</li>
        <li>2TB Surveillance HDD</li>
        <li>SATA cable ribbons</li>
        <li>Chassis screws</li>
      </ul>
    </div>
    <div class="grid-col">
      <strong>Tools to Teach</strong>
      <ul>
        <li>Insulated Phillips screwdrivers</li>
        <li>DMM (to check HDD power rails)</li>
      </ul>
    </div>
  </div>
</div>

<!-- Session 18 -->
<div class="session-card">
  <div class="session-title">Session 18: RAID & Storage Design</div>
  <div class="lab-goal">Lab Goal: Configure RAID 5 array blocks and execute hot-swap disk rebuilds.</div>
  <div class="grid-container">
    <div class="grid-col">
      <strong>Step-by-Step Lab Plan</strong>
      <ol>
        <li>Access array management console under NVR configuration.</li>
        <li>Initialize 3-disk RAID 5 storage array.</li>
        <li>Simulate disk fault by physically unplugging a single HDD tray.</li>
        <li>Hot-swap a clean replacement disk, monitor raid reconstruction.</li>
      </ol>
    </div>
    <div class="grid-col">
      <strong>Materials Required</strong>
      <ul>
        <li>Multi-Bay NVR / NAS Server</li>
        <li>3x Identical 2TB SATA HDDs</li>
        <li>Hot-swap drive tray caddies</li>
      </ul>
    </div>
    <div class="grid-col">
      <strong>Tools to Teach</strong>
      <ul>
        <li>Server management web console</li>
        <li>HDD tray release key</li>
      </ul>
    </div>
  </div>
</div>

<!-- Session 19 -->
<div class="session-card">
  <div class="session-title">Session 19: ONVIF Standards</div>
  <div class="lab-goal">Lab Goal: Discover and integrate third-party IP cameras.</div>
  <div class="grid-container">
    <div class="grid-col">
      <strong>Step-by-Step Lab Plan</strong>
      <ol>
        <li>Install ONVIF Device Manager utility software on PC.</li>
        <li>Scan subnet to discover third-party camera IP and connection port.</li>
        <li>Enable ONVIF user profiles on camera firmware page.</li>
        <li>Add camera to main NVR using the custom ONVIF profile, verify feeds.</li>
      </ol>
    </div>
    <div class="grid-col">
      <strong>Materials Required</strong>
      <ul>
        <li>Third-party brand IP camera</li>
        <li>Test client computer</li>
        <li>Managed PoE network switch</li>
        <li>NVR recorder</li>
      </ul>
    </div>
    <div class="grid-col">
      <strong>Tools to Teach</strong>
      <ul>
        <li>ONVIF Device Manager software</li>
        <li>IP scanner search tools</li>
      </ul>
    </div>
  </div>
</div>

<!-- Session 20 -->
<div class="session-card">
  <div class="session-title">Session 20: Video Compression</div>
  <div class="lab-goal">Lab Goal: Measure and optimize H.264, H.265, and H.265+ data streams.</div>
  <div class="grid-container">
    <div class="grid-col">
      <strong>Step-by-Step Lab Plan</strong>
      <ol>
        <li>Configure camera compression format to H.264 profile.</li>
        <li>Expose camera lens to high-motion environment, measure peak bitrates.</li>
        <li>Change compression profile to H.265, check bandwidth savings.</li>
        <li>Activate H.265+ smart codecs, monitor bitrates during static periods.</li>
      </ol>
    </div>
    <div class="grid-col">
      <strong>Materials Required</strong>
      <ul>
        <li>High-resolution IP Camera (4K)</li>
        <li>PoE switch & testing laptop</li>
        <li>DC power adapter</li>
      </ul>
    </div>
    <div class="grid-col">
      <strong>Tools to Teach</strong>
      <ul>
        <li>Router bandwidth monitor interface</li>
        <li>Camera stream statistics utility</li>
      </ul>
    </div>
  </div>
</div>

<!-- Session 21 -->
<div class="session-card">
  <div class="session-title">Session 21: AI Analytics & Perimeter Security</div>
  <div class="lab-goal">Lab Goal: Configure tripwires and wire hardware alarm relay outputs.</div>
  <div class="grid-container">
    <div class="grid-col">
      <strong>Step-by-Step Lab Plan</strong>
      <ol>
        <li>Navigate to smart event settings on AI camera web interface.</li>
        <li>Draw a line-crossing boundary, configure directional filters.</li>
        <li>Wire NVR alarm block outputs to a 12V warning strobe lamp.</li>
        <li>Cross tripwire path, verify strobe lamp fires.</li>
      </ol>
    </div>
    <div class="grid-col">
      <strong>Materials Required</strong>
      <ul>
        <li>AI classification IP camera</li>
        <li>12V DC Warning strobe / Siren</li>
        <li>12V DC Power supply adapter</li>
        <li>Twin core alarm wires</li>
      </ul>
    </div>
    <div class="grid-col">
      <strong>Tools to Teach</strong>
      <ul>
        <li>Precision terminal screwdrivers</li>
        <li>Multimeter</li>
      </ul>
    </div>
  </div>
</div>

<!-- Session 22 -->
<div class="session-card">
  <div class="session-title">Session 22: ANPR (Plate Recognition)</div>
  <div class="lab-goal">Lab Goal: Set fast exposure shutters and connect barrier gates.</div>
  <div class="grid-container">
    <div class="grid-col">
      <strong>Step-by-Step Lab Plan</strong>
      <ol>
        <li>Mount ANPR camera at lane entry template.</li>
        <li>Adjust camera shutter speed manual profiles (1/1000s).</li>
        <li>Import whitelisted test plates into camera database.</li>
        <li>Wire camera control relay to barrier motor to verify gate trigger.</li>
      </ol>
    </div>
    <div class="grid-col">
      <strong>Materials Required</strong>
      <ul>
        <li>ANPR optical IP camera</li>
        <li>Printed mock license plates</li>
        <li>12V alarm indicator lamp</li>
        <li>Twin-lead connection wire</li>
      </ul>
    </div>
    <div class="grid-col">
      <strong>Tools to Teach</strong>
      <ul>
        <li>ANPR web configuration tool</li>
        <li>Multimeter (continuity check)</li>
        <li>Small flathead terminal screwdriver</li>
      </ul>
    </div>
  </div>
</div>

<!-- Session 23 -->
<div class="session-card">
  <div class="session-title">Session 23: Facial Recognition</div>
  <div class="lab-goal">Lab Goal: Audit facial pixel density and build enrollment database blocks.</div>
  <div class="grid-container">
    <div class="grid-col">
      <strong>Step-by-Step Lab Plan</strong>
      <ol>
        <li>Mount face capture camera at gateway entrance area.</li>
        <li>Use measuring tape to find eye pixel spacing on capture frames.</li>
        <li>Enroll user profile images into Staff and Blacklist databases.</li>
        <li>Test facial matching thresholds, verify blacklist alarm warnings.</li>
      </ol>
    </div>
    <div class="grid-col">
      <strong>Materials Required</strong>
      <ul>
        <li>Face recognition IP camera</li>
        <li>Enrollment photos (Staff, Blacklist)</li>
        <li>Testing target cards</li>
      </ul>
    </div>
    <div class="grid-col">
      <strong>Tools to Teach</strong>
      <ul>
        <li>NVR face matching console</li>
        <li>Target pixel analysis calculator</li>
        <li>Measuring tape</li>
      </ul>
    </div>
  </div>
</div>

<!-- Session 24 -->
<div class="session-card">
  <div class="session-title">Session 24: ColorVu, AcuSense & Thermal</div>
  <div class="lab-goal">Lab Goal: Configure low-light warm LEDs and calibrate thermal heat sensors.</div>
  <div class="grid-container">
    <div class="grid-col">
      <strong>Step-by-Step Lab Plan</strong>
      <ol>
        <li>Configure supplemental warm light thresholds on ColorVu camera.</li>
        <li>Adjust thermal sensor temp scale limits to detect hot spots.</li>
        <li>Calibrate temperature alarm rules (e.g. trigger if over 60°C).</li>
        <li>Simulate fire hazards using heat sources to verify alarms.</li>
      </ol>
    </div>
    <div class="grid-col">
      <strong>Materials Required</strong>
      <ul>
        <li>ColorVu IP Camera</li>
        <li>Bi-Spectrum thermal camera</li>
        <li>Controlled heat source (soldering iron)</li>
      </ul>
    </div>
    <div class="grid-col">
      <strong>Tools to Teach</strong>
      <ul>
        <li>Thermal imaging software</li>
        <li>Non-contact laser thermometer</li>
      </ul>
    </div>
  </div>
</div>

<!-- Session 25 -->
<div class="session-card">
  <div class="session-title">Session 25: PTZ Cameras</div>
  <div class="lab-goal">Lab Goal: Save PTZ coordinate presets and construct patrol sequence tours.</div>
  <div class="grid-container">
    <div class="grid-col">
      <strong>Step-by-Step Lab Plan</strong>
      <ol>
        <li>Control speed dome movement using NVR joystick controls.</li>
        <li>Set up and save 4 separate preset coordinate locations.</li>
        <li>Combine presets into a patrol tour sequence with 10s dwell times.</li>
        <li>Enable smart auto-tracking features to trace target movement.</li>
      </ol>
    </div>
    <div class="grid-col">
      <strong>Materials Required</strong>
      <ul>
        <li>Network PTZ dome camera</li>
        <li>PTZ ceiling mount bracket</li>
        <li>Twin core control wire (RS485)</li>
      </ul>
    </div>
    <div class="grid-col">
      <strong>Tools to Teach</strong>
      <ul>
        <li>3-Axis PTZ Joystick keyboard</li>
        <li>NVR PTZ preset menu</li>
      </ul>
    </div>
  </div>
</div>

<!-- Session 26 -->
<div class="session-card">
  <div class="session-title">Session 26: Remote Viewing & Cloud</div>
  <div class="lab-goal">Lab Goal: Set up P2P cloud accounts and optimize multi-stream bandwidth profiles.</div>
  <div class="grid-container">
    <div class="grid-col">
      <strong>Step-by-Step Lab Plan</strong>
      <ol>
        <li>Register NVR device serial number on cloud app server.</li>
        <li>Scan screen QR code to bind recorder to a test mobile phone.</li>
        <li>Expose camera, adjust Main stream and Sub stream bitrates.</li>
        <li>Test WAN remote viewing loading times over cellular data networks.</li>
      </ol>
    </div>
    <div class="grid-col">
      <strong>Materials Required</strong>
      <ul>
        <li>NVR recorder (connected to WAN)</li>
        <li>Smartphone with remote app installed</li>
        <li>Network patch cables</li>
      </ul>
    </div>
    <div class="grid-col">
      <strong>Tools to Teach</strong>
      <ul>
        <li>Cloud P2P management portal</li>
        <li>Bandwidth speed test utility</li>
      </ul>
    </div>
  </div>
</div>

<!-- Session 27 -->
<div class="session-card">
  <div class="session-title">Session 27: Cybersecurity</div>
  <div class="lab-goal">Lab Goal: Secure NVR ports, install HTTPS certificates, and configure IP limits.</div>
  <div class="grid-container">
    <div class="grid-col">
      <strong>Step-by-Step Lab Plan</strong>
      <ol>
        <li>Disable UPnP auto-routing functions inside router.</li>
        <li>Re-map standard connection ports (HTTP 80 and SDK 8000) to high ports.</li>
        <li>Enable HTTPS protocol, load encryption certificates.</li>
        <li>Configure IP whitelisting parameters for admin remote access.</li>
      </ol>
    </div>
    <div class="grid-col">
      <strong>Materials Required</strong>
      <ul>
        <li>Network NVR system</li>
        <li>Testing laptop</li>
        <li>Network switch</li>
      </ul>
    </div>
    <div class="grid-col">
      <strong>Tools to Teach</strong>
      <ul>
        <li>NVR network hardening settings menu</li>
        <li>SSL certificate creation console</li>
      </ul>
    </div>
  </div>
</div>

<!-- Session 28 -->
<div class="session-card">
  <div class="session-title">Session 28: Troubleshooting & Maintenance</div>
  <div class="lab-goal">Lab Goal: Fix video loss errors, resolve IP clashes, and clean dome cameras.</div>
  <div class="grid-container">
    <div class="grid-col">
      <strong>Step-by-Step Lab Plan</strong>
      <ol>
        <li>Isolate duplicate IP address conflict issues using ping scans.</li>
        <li>Install ground loop isolator to block analog video hum bars.</li>
        <li>Inspect and clean dirty camera glass to prevent night IR halos.</li>
        <li>Recover locked firmware using TFTP automated network boot tools.</li>
      </ol>
    </div>
    <div class="grid-col">
      <strong>Materials Required</strong>
      <ul>
        <li>Ground loop isolator filters</li>
        <li>Camera lens cleaning kit</li>
        <li>NVR/Camera firmware update bin files</li>
      </ul>
    </div>
    <div class="grid-col">
      <strong>Tools to Teach</strong>
      <ul>
        <li>TFTP desktop server utility</li>
        <li>IP scanning software tool</li>
        <li>Lens blower & clean microfiber cloth</li>
      </ul>
    </div>
  </div>
</div>

</body>
</html>
"@

Set-Content -Path $htmlPath -Value $htmlContent -Encoding utf8
Write-Host "Generated lab_plans.html"

# Compile to PDF using headless Edge
$p = Start-Process -FilePath "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" -ArgumentList "--headless=new", "--no-sandbox", "--print-to-pdf=$tempPdfPath", "file:///$($htmlPath -replace '\\', '/')" -NoNewWindow -PassThru -Wait

if ($p.ExitCode -eq 0) {
    Copy-Item -Path $tempPdfPath -Destination $pdfPath -Force
    Write-Host "Lab Plans PDF conversion completed successfully. Saved to: $pdfPath"
} else {
    Write-Host "Edge PDF conversion failed with exit code $($p.ExitCode)"
}
