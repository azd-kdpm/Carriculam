// Client-Side Router & API Integration for App / Mobile APK

const stagesData = [
  { id: 1, title: "1. Electrical Fundamentals & Wiring", sessions: [1,2,3,4,5,6,7] },
  { id: 2, title: "2. Analog CCTV Systems", sessions: [8,9,10] },
  { id: 3, title: "3. Networking Fundamentals", sessions: [11,12,13,14,15,16] },
  { id: 4, title: "4. IP Camera Systems & VMS", sessions: [17,18,19,20,21,22,23] },
  { id: 5, title: "5. Network & Camera Troubleshooting", sessions: [24] },
  { id: 6, title: "6. Building Communication (VDP, Intercom, PA)", sessions: [25,26,27,28] },
  { id: 7, title: "7. Hotel Locks & Smart Locks", sessions: [29,30] },
  { id: 8, title: "8. Access Control, Biometrics & Attendance", sessions: [31,32,33,34] },
  { id: 9, title: "9. Boom Barriers & Gate Systems", sessions: [35,36] },
  { id: 10, title: "10. Building Management Systems (BMS)", sessions: [37,38,39,40] },
  { id: 11, title: "11. Smart Home Automation, IoT & KNX", sessions: [41,42,43,44,45,46,47] },
  { id: 12, title: "12. Business, Project Engineering & Career", sessions: [48,49,50,51,52,53,54,55,56,57,58,59] }
];

function handleLogin(event) {
  event.preventDefault();
  const username = document.getElementById("username").value;
  if (username) {
    localStorage.setItem("user_token", "JWT_SECRET_TOKEN_" + Date.now());
    document.getElementById("authView").style.display = "none";
    document.getElementById("dashboardView").style.display = "flex";
    initDashboard();
  }
}

function handleLogout() {
  localStorage.removeItem("user_token");
  document.getElementById("dashboardView").style.display = "none";
  document.getElementById("authView").style.display = "flex";
}

function initDashboard() {
  const stageNav = document.getElementById("stageNav");
  stageNav.innerHTML = "";
  
  stagesData.forEach(stage => {
    const btn = document.createElement("button");
    btn.className = "btn-primary";
    btn.style.cssText = "margin-bottom: 10px; background: rgba(255,255,255,0.05); text-align: left; font-size: 13px; font-weight: 500; border: 1px solid rgba(255,255,255,0.08);";
    btn.innerText = stage.title;
    btn.onclick = () => renderStage(stage);
    stageNav.appendChild(btn);
  });
  
  renderStage(stagesData[0]);
}

function renderStage(stage) {
  document.getElementById("activeStageBadge").innerText = stage.title;
  document.getElementById("stageTitle").innerText = "Sessions Overview";
  
  const grid = document.getElementById("sessionGrid");
  grid.innerHTML = "";
  
  stage.sessions.forEach(sNum => {
    const card = document.createElement("div");
    card.className = "session-card";
    const padded = sNum.toString().padStart(2, '0');
    card.innerHTML = `
      <h3 style="color: #fff; font-size: 16px; margin-bottom: 8px;">Session ${sNum}</h3>
      <p style="color: var(--text-muted); font-size: 13px; margin-bottom: 15px;">Interactive Slide Deck & Practical Scope</p>
      <a href="../slides/m1_s${padded}_electrical_fundamentals_ac_dc.html" target="_blank" class="btn-primary" style="display: block; text-align: center; text-decoration: none; font-size: 13px; padding: 8px;">Launch Interactive Deck</a>
    `;
    grid.appendChild(card);
  });
}

// Auto login if token exists
if (localStorage.getItem("user_token")) {
  document.getElementById("authView").style.display = "none";
  document.getElementById("dashboardView").style.display = "flex";
  initDashboard();
}
