# Load System.Drawing for color conversion
Add-Type -AssemblyName System.Drawing

$htmlPath = "c:\Users\asadu\Downloads\Quick Share\BotGI\event\event_presentation_en.html"
$pptxPath = "c:\Users\asadu\Downloads\Quick Share\BotGI\event\event_presentation_en.pptx"

Write-Host "Attempting to generate PowerPoint (.pptx) file via COM Object..."

try {
    $ppt = New-Object -ComObject PowerPoint.Application
    # Keep it invisible during creation
    $ppt.Visible = [Microsoft.Office.Core.MsoTriState]::msoTrue
} catch {
    Write-Warning "PowerShell could not initiate Microsoft PowerPoint. Please ensure PowerPoint is installed on this PC."
    exit 1
}

try {
    $pres = $ppt.Presentations.Add()
    # Set slide dimensions to A4 landscape (approx 10 inches x 7.5 inches, or custom 16:9 widescreen)
    $pres.PageSetup.SlideWidth = 960  # Widescreen pixels
    $pres.PageSetup.SlideHeight = 540

    # Slide 1: Welcome
    $slide = $pres.Slides.Add(1, 12) # ppLayoutBlank = 12
    $slide.Background.Fill.Solid()
    $slide.Background.Fill.ForeColor.RGB = [System.Drawing.Color]::FromArgb(0x0c, 0x07, 0x17).ToArgb()
    
    # Insert Logo
    $logo = $slide.Shapes.AddPicture("c:\Users\asadu\Downloads\Quick Share\BotGI\assets\BotGI_logo_with_white_background-removebg-preview.png", $false, $true, 50, 80, 180, 100)
    
    # Title
    $titleBox = $slide.Shapes.AddTextbox(1, 50, 200, 400, 150) # msoTextOrientationHorizontal = 1
    $titleBox.TextFrame.TextRange.Text = "Advanced Technology Training`nLow-Voltage Systems & Security Automation"
    $titleBox.TextFrame.TextRange.Font.Name = "Outfit"
    $titleBox.TextFrame.TextRange.Font.Size = 24
    $titleBox.TextFrame.TextRange.Font.Color.RGB = [System.Drawing.Color]::White.ToArgb()
    
    # Image Right
    $slideImage = $slide.Shapes.AddPicture("c:\Users\asadu\Downloads\Quick Share\BotGI\assets\slide1.jpg", $false, $true, 500, 50, 410, 440)

    # Slide 2: Reality
    $slide = $pres.Slides.Add(2, 12)
    $slide.Background.Fill.Solid()
    $slide.Background.Fill.ForeColor.RGB = [System.Drawing.Color]::FromArgb(0x0c, 0x07, 0x17).ToArgb()
    
    # Title
    $titleBox = $slide.Shapes.AddTextbox(1, 50, 30, 860, 60)
    $titleBox.TextFrame.TextRange.Text = "THE REALITY OF MODERN EDUCATION"
    $titleBox.TextFrame.TextRange.Font.Name = "Outfit"
    $titleBox.TextFrame.TextRange.Font.Size = 22
    $titleBox.TextFrame.TextRange.Font.Bold = $true
    $titleBox.TextFrame.TextRange.Font.Color.RGB = [System.Drawing.Color]::FromArgb(0xf3, 0xdf, 0x95).ToArgb() # gold-light

    # Left Image
    $slideImage = $slide.Shapes.AddPicture("c:\Users\asadu\Downloads\Quick Share\BotGI\assets\slide2.jpg", $false, $true, 50, 110, 400, 360)

    # Right Text
    $textBox = $slide.Shapes.AddTextbox(1, 480, 110, 430, 360)
    $textBox.TextFrame.TextRange.Text = "Degree Alone is Not Enough`nA college degree is no longer a guaranteed ticket to a successful career. Industries have rapidly evolved.`n`nPractical Skills First`nLeading companies prioritize actual hands-on technical competence over certificates.`n`nThe Curriculum Gap`nThere is a massive divide between university theories and real-world system integration demands.`n`nTherefore, acquiring Industry Skills alongside your studies is essential!"
    $textBox.TextFrame.TextRange.Font.Name = "Outfit"
    $textBox.TextFrame.TextRange.Font.Size = 14
    $textBox.TextFrame.TextRange.Font.Color.RGB = [System.Drawing.Color]::White.ToArgb()

    # Save presentation
    $pres.SaveAs($pptxPath)
    $pres.Close()
    $ppt.Quit()
    Write-Host "PowerPoint presentation saved successfully to: $pptxPath"
} catch {
    Write-Warning "Failed during slide generation. Error details: $_"
    if ($ppt) { $ppt.Quit() }
}
