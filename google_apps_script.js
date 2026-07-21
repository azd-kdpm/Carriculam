function doPost(e) {
  try {
    var data = JSON.parse(e.postData.contents);
    var ss = SpreadsheetApp.getActiveSpreadsheet();
    var sheet = ss.getSheets()[0]; // Always target the primary curriculum sheet tab
    
    // Support legacy cell updates if needed
    if (data.action === "updateCell") {
      sheet.getRange(data.row, data.col).setValue(data.value);
      return ContentService.createTextOutput(JSON.stringify({status: "success", message: "Cell updated"}))
        .setMimeType(ContentService.MimeType.JSON);
    }
    
    // Action to restructure and style the entire curriculum sheet with 12 columns
    if (data.action === "restructureSheet") {
      sheet.clear();
      
      // Define 12 columns headers
      var headers = [
        "Session Number", 
        "Week", 
        "Module", 
        "Topic", 
        "Hours", 
        "Slide Number & Title", 
        "Materials Required", 
        "Material Qty",
        "Tools Required", 
        "Tool Qty",
        "Practical Works & Lab Activities", 
        "Included in Slides"
      ];
      sheet.getRange(1, 1, 1, headers.length).setValues([headers]);
      
      var startRow = 2;
      
      // Helper function to safely convert single values or nulls into arrays of strings
      var toArray = function(val) {
        if (val === null || val === undefined) return [];
        if (Array.isArray(val)) return val.map(function(v) { return v !== null && v !== undefined ? v.toString() : ""; });
        if (typeof val === "object") {
          if (Object.keys(val).length === 0) return [];
        }
        var str = val.toString();
        if (str === "[object Object]" || str === "{}") return [];
        return [str];
      };
      
      // Loop over each session payload
      for (var i = 0; i < data.sessions.length; i++) {
        var sess = data.sessions[i];
        
        var slides = toArray(sess.slides);
        var materials = toArray(sess.materials);
        var materialQtys = toArray(sess.materialQtys);
        var tools = toArray(sess.tools);
        var toolQtys = toArray(sess.toolQtys);
        var labs = toArray(sess.labActivities);
        
        // Find the maximum number of rows required for this session
        var numRows = Math.max(slides.length, materials.length, tools.length, labs.length);
        if (isNaN(numRows) || numRows < 1) {
          numRows = 1;
        }
        
        // Write slides (Col 6 - F)
        for (var s = 0; s < slides.length; s++) {
          sheet.getRange(startRow + s, 6).setValue(slides[s]);
        }
        
        // Write materials (Col 7 - G)
        for (var m = 0; m < materials.length; m++) {
          sheet.getRange(startRow + m, 7).setValue(materials[m]);
        }
        
        // Write material quantities (Col 8 - H)
        for (var mq = 0; mq < materialQtys.length; mq++) {
          sheet.getRange(startRow + mq, 8).setValue(materialQtys[mq]);
        }
        
        // Write tools (Col 9 - I)
        for (var t = 0; t < tools.length; t++) {
          sheet.getRange(startRow + t, 9).setValue(tools[t]);
        }
        
        // Write tool quantities (Col 10 - J)
        for (var tq = 0; tq < toolQtys.length; tq++) {
          sheet.getRange(startRow + tq, 10).setValue(toolQtys[tq]);
        }
        
        // Write labs (Col 11 - K)
        for (var l = 0; l < labs.length; l++) {
          sheet.getRange(startRow + l, 11).setValue(labs[l]);
        }
        
        // Insert checkable checkboxes in Column L (Col 12) for each row and check them
        var checkboxRange = sheet.getRange(startRow, 12, numRows, 1);
        checkboxRange.insertCheckboxes();
        checkboxRange.setValue(true);
        checkboxRange.setHorizontalAlignment("center");
        checkboxRange.setVerticalAlignment("middle");
        
        // Write and merge session metadata (Columns A, B, C, D, E)
        var metadata = [
          [1, sess.sessionNum],
          [2, sess.week],
          [3, sess.module],
          [4, sess.topic],
          [5, sess.hours]
        ];
        
        metadata.forEach(function(item) {
          var col = item[0];
          var val = item[1];
          var cellRange = sheet.getRange(startRow, col, numRows, 1);
          cellRange.merge();
          cellRange.setValue(val);
          cellRange.setVerticalAlignment("middle");
          cellRange.setHorizontalAlignment("center");
        });
        
        // Align text columns left-aligned/center-aligned and vertically centered
        sheet.getRange(startRow, 4, numRows, 1).setHorizontalAlignment("left").setVerticalAlignment("middle"); // Topic
        sheet.getRange(startRow, 6, numRows, 1).setHorizontalAlignment("left").setVerticalAlignment("middle"); // Slides
        sheet.getRange(startRow, 7, numRows, 1).setHorizontalAlignment("left").setVerticalAlignment("middle"); // Materials
        sheet.getRange(startRow, 8, numRows, 1).setHorizontalAlignment("center").setVerticalAlignment("middle"); // Material Qty
        sheet.getRange(startRow, 9, numRows, 1).setHorizontalAlignment("left").setVerticalAlignment("middle"); // Tools
        sheet.getRange(startRow, 10, numRows, 1).setHorizontalAlignment("center").setVerticalAlignment("middle"); // Tool Qty
        sheet.getRange(startRow, 11, numRows, 1).setHorizontalAlignment("left").setVerticalAlignment("middle"); // Labs
        
        // Apply alternating light background colors for clear visual separation of sessions
        var sessionRange = sheet.getRange(startRow, 1, numRows, headers.length);
        var bgColor = (i % 2 === 0) ? "#ffffff" : "#f8fafc";
        sessionRange.setBackground(bgColor);
        
        startRow += numRows;
      }
      
      // Style headers
      var headerRange = sheet.getRange(1, 1, 1, headers.length);
      headerRange.setBackground("#0f172a");
      headerRange.setFontColor("#ffffff");
      headerRange.setFontWeight("bold");
      headerRange.setHorizontalAlignment("center");
      headerRange.setVerticalAlignment("middle");
      sheet.setRowHeight(1, 35);
      
      // Enable text wrapping and apply custom grid borders
      var totalRows = startRow - 1;
      var dataRange = sheet.getRange(2, 1, totalRows - 1, headers.length);
      dataRange.setWrap(true);
      dataRange.setVerticalAlignment("middle");
      dataRange.setBorder(true, true, true, true, true, true, "#cbd5e1", SpreadsheetApp.BorderStyle.SOLID);
      
      // Set custom column widths
      sheet.setColumnWidth(1, 70);  // Session Number
      sheet.setColumnWidth(2, 60);  // Week
      sheet.setColumnWidth(3, 160); // Module
      sheet.setColumnWidth(4, 180); // Topic
      sheet.setColumnWidth(5, 70);  // Hours
      sheet.setColumnWidth(6, 260); // Slide Number & Title
      sheet.setColumnWidth(7, 180); // Materials Required
      sheet.setColumnWidth(8, 80);  // Material Qty
      sheet.setColumnWidth(9, 180); // Tools Required
      sheet.setColumnWidth(10, 80); // Tool Qty
      sheet.setColumnWidth(11, 260); // Practical Works & Lab Activities
      sheet.setColumnWidth(12, 80); // Included in Slides
      
      return ContentService.createTextOutput(JSON.stringify({status: "success", message: "Sheet restructured with dedicated Quantity columns!"}))
        .setMimeType(ContentService.MimeType.JSON);
    }
    
    // Action to create and populate the Purchase Checklist tab
    if (data.action === "updatePurchaseChecklist") {
      var checklistSheet = ss.getSheetByName("Purchase Checklist");
      if (!checklistSheet) {
        checklistSheet = ss.insertSheet("Purchase Checklist");
      }
      checklistSheet.clear();
      
      var chHeaders = [
        "Bought?", 
        "Category", 
        "Item Description", 
        "Required Qty", 
        "Arranged?", 
        "Remarks"
      ];
      checklistSheet.getRange(1, 1, 1, chHeaders.length).setValues([chHeaders]);
      
      var startRowCh = 2;
      for (var j = 0; j < data.items.length; j++) {
        var item = data.items[j];
        checklistSheet.getRange(startRowCh, 2).setValue(item.category);
        checklistSheet.getRange(startRowCh, 3).setValue(item.description);
        checklistSheet.getRange(startRowCh, 4).setValue(item.qty);
        checklistSheet.getRange(startRowCh, 6).setValue(""); // Remarks empty initially
        
        startRowCh++;
      }
      
      var numRowsCh = data.items.length;
      if (numRowsCh > 0) {
        // Insert Checkboxes for A ("Bought?") and E ("Arranged?")
        checklistSheet.getRange(2, 1, numRowsCh, 1).insertCheckboxes();
        checklistSheet.getRange(2, 5, numRowsCh, 1).insertCheckboxes();
        
        // Alignment
        checklistSheet.getRange(2, 1, numRowsCh, 1).setHorizontalAlignment("center");
        checklistSheet.getRange(2, 2, numRowsCh, 1).setHorizontalAlignment("left");
        checklistSheet.getRange(2, 3, numRowsCh, 1).setHorizontalAlignment("left");
        checklistSheet.getRange(2, 4, numRowsCh, 1).setHorizontalAlignment("center");
        checklistSheet.getRange(2, 5, numRowsCh, 1).setHorizontalAlignment("center");
        checklistSheet.getRange(2, 6, numRowsCh, 1).setHorizontalAlignment("left");
        
        // Style Headers
        var headerRangeCh = checklistSheet.getRange(1, 1, 1, chHeaders.length);
        headerRangeCh.setBackground("#0f172a");
        headerRangeCh.setFontColor("#ffffff");
        headerRangeCh.setFontWeight("bold");
        headerRangeCh.setHorizontalAlignment("center");
        headerRangeCh.setVerticalAlignment("middle");
        checklistSheet.setRowHeight(1, 35);
        
        // Grid Borders & Wraps
        var dataRangeCh = checklistSheet.getRange(2, 1, numRowsCh, chHeaders.length);
        dataRangeCh.setWrap(true);
        dataRangeCh.setVerticalAlignment("middle");
        dataRangeCh.setBorder(true, true, true, true, true, true, "#cbd5e1", SpreadsheetApp.BorderStyle.SOLID);
        
        // Alternating background colors for rows
        for (var r = 0; r < numRowsCh; r++) {
          var bg = (r % 2 === 0) ? "#ffffff" : "#f8fafc";
          checklistSheet.getRange(2 + r, 1, 1, chHeaders.length).setBackground(bg);
        }
        
        // Column Widths
        checklistSheet.setColumnWidth(1, 70);  // Bought?
        checklistSheet.setColumnWidth(2, 180); // Category
        checklistSheet.setColumnWidth(3, 260); // Item Description
        checklistSheet.setColumnWidth(4, 90);  // Required Qty
        checklistSheet.setColumnWidth(5, 80);  // Arranged?
        checklistSheet.setColumnWidth(6, 250); // Remarks
      }
      
      return ContentService.createTextOutput(JSON.stringify({status: "success", message: "Purchase Checklist tab updated successfully!"}))
        .setMimeType(ContentService.MimeType.JSON);
    }
    
    // Action to list sheet names for debugging
    if (data.action === "listSheets") {
      var sheets = ss.getSheets();
      var sheetNames = [];
      for (var s = 0; s < sheets.length; s++) {
        sheetNames.push(sheets[s].getName());
      }
      return ContentService.createTextOutput(JSON.stringify({status: "success", sheets: sheetNames, active: ss.getActiveSheet().getName()}))
        .setMimeType(ContentService.MimeType.JSON);
    }
    
    // Action to test matching logic on the sheet rows
    if (data.action === "testMatches") {
      var values = sheet.getDataRange().getValues();
      var cleanTitleText = function(text) {
        if (!text) return "";
        var clean = text.toString().trim();
        // Strip leading [x] or [ ] checkbox prefix
        clean = clean.replace(/^\[[x ]\]\s*/i, "");
        return clean.toLowerCase().replace(/[^a-z0-9]/g, "");
      };
      
      var pointsMap = {};
      for (var sIdx = 0; sIdx < data.sessions.length; sIdx++) {
        var sess = data.sessions[sIdx];
        var sNum = sess.sessionNum.toString();
        var slides = sess.slides || [];
        for (var slIdx = 0; slIdx < slides.length; slIdx++) {
          var sl = slides[slIdx];
          var key = sNum + "_" + cleanTitleText(sl.title);
          pointsMap[key] = sl.points || [];
        }
      }
      
      var currentSession = "";
      var results = [];
      
      for (var rowIdx = 1; rowIdx < Math.min(values.length, 30); rowIdx++) {
        var sessVal = values[rowIdx][0];
        if (sessVal !== null && sessVal !== undefined && sessVal.toString().trim() !== "") {
          currentSession = sessVal.toString().trim();
        }
        
        var slideVal = values[rowIdx][5];
        if (slideVal !== null && slideVal !== undefined && slideVal.toString().trim() !== "") {
          var lookupKey = currentSession + "_" + cleanTitleText(slideVal.toString());
          var pts = pointsMap[lookupKey];
          results.push({
            row: rowIdx + 1,
            session: currentSession,
            slideVal: slideVal.toString(),
            lookupKey: lookupKey,
            matched: pts ? true : false,
            pointsCount: pts ? pts.length : 0
          });
        }
      }
      
      return ContentService.createTextOutput(JSON.stringify({status: "success", results: results}))
        .setMimeType(ContentService.MimeType.JSON);
    }
    
    // Action to populate slide key points (Columns G, H, I) preserving existing content like links/notes
    if (data.action === "populateSlidePoints") {
      var values = sheet.getDataRange().getValues();
      
      // Helper function for cleaning slide names to match robustly
      var cleanTitleText = function(text) {
        if (!text) return "";
        var clean = text.toString().trim();
        // Strip leading [x] or [ ] checkbox prefix
        clean = clean.replace(/^\[[x ]\]\s*/i, "");
        return clean.toLowerCase().replace(/[^a-z0-9]/g, "");
      };
      
      // Build a lookup map of slide points by (sessionNum + "_" + cleanTitle)
      var pointsMap = {};
      for (var sIdx = 0; sIdx < data.sessions.length; sIdx++) {
        var sess = data.sessions[sIdx];
        var sNum = sess.sessionNum.toString();
        var slides = sess.slides || [];
        for (var slIdx = 0; slIdx < slides.length; slIdx++) {
          var sl = slides[slIdx];
          var key = sNum + "_" + cleanTitleText(sl.title);
          pointsMap[key] = sl.points || [];
        }
      }
      
      var currentSession = "";
      
      // Loop over the sheet rows starting from Row 2 (Index 1)
      for (var rowIdx = 1; rowIdx < values.length; rowIdx++) {
        var sessVal = values[rowIdx][0]; // Col A (Session Number)
        if (sessVal !== null && sessVal !== undefined && sessVal.toString().trim() !== "") {
          currentSession = sessVal.toString().trim();
        }
        
        var slideVal = values[rowIdx][5]; // Col F (Slide Number & Title)
        if (slideVal !== null && slideVal !== undefined && slideVal.toString().trim() !== "") {
          var lookupKey = currentSession + "_" + cleanTitleText(slideVal.toString());
          var pts = pointsMap[lookupKey];
          if (pts && pts.length > 0) {
            // Write Point 1 to Col G (Col 7)
            if (pts[0]) {
              sheet.getRange(rowIdx + 1, 7).setValue(pts[0]);
            }
            // Write Point 2 to Col H (Col 8) preserving links
            if (pts[1]) {
              var cellH = sheet.getRange(rowIdx + 1, 8);
              var valH = cellH.getValue().toString().trim();
              if (valH !== "" && valH.indexOf("http") === 0) {
                cellH.setValue(pts[1] + "\n(Video: " + valH + ")");
              } else {
                cellH.setValue(pts[1]);
              }
            }
            // Write Point 3 to Col I (Col 9) preserving notes
            if (pts[2]) {
              var cellI = sheet.getRange(rowIdx + 1, 9);
              var valI = cellI.getValue().toString().trim();
              if (valI !== "" && valI.indexOf("http") !== 0) {
                cellI.setValue(pts[2] + "\n(Note: " + valI + ")");
              } else {
                cellI.setValue(pts[2]);
              }
            }
          }
        }
      }
      
      return ContentService.createTextOutput(JSON.stringify({status: "success", message: "Key points populated successfully!"}))
        .setMimeType(ContentService.MimeType.JSON);
    }
    
    // Action to create a brand new Google Sheet file and populate it with slide outlines (Optimized Batch Mode)
    if (data.action === "createOutlinesFile") {
      var newSS = SpreadsheetApp.create("ELV Course - Detailed Slide Outlines");
      var newSheet = newSS.getSheets()[0];
      newSheet.setName("Slide Outlines Checklist");
      
      var chHeaders = [
        "Session Number", 
        "Week", 
        "Module", 
        "Topic", 
        "Hours", 
        "Slide Number & Title", 
        "Key Point", 
        "Slide Done?"
      ];
      newSheet.getRange(1, 1, 1, chHeaders.length).setValues([chHeaders]);
      
      var allRows = [];
      var mergeRanges = []; // Array of {startRow, numRows, col}
      
      var startRow = 2;
      
      // Helper function to safely convert single values or nulls into arrays of strings
      var toArray = function(val) {
        if (val === null || val === undefined) return [];
        if (Array.isArray(val)) return val.map(function(v) { return v !== null && v !== undefined ? v.toString() : ""; });
        if (typeof val === "object") {
          if (Object.keys(val).length === 0) return [];
        }
        var str = val.toString();
        if (str === "[object Object]" || str === "{}") return [];
        return [str];
      };
      
      for (var i = 0; i < data.sessions.length; i++) {
        var sess = data.sessions[i];
        var sessionNum = sess.sessionNum.toString();
        var slides = sess.slides || [];
        
        var sessionStartRow = startRow;
        
        for (var sIdx = 0; sIdx < slides.length; sIdx++) {
          var sl = slides[sIdx];
          var slideTitle = sl.title;
          var points = toArray(sl.points);
          if (points.length === 0) {
            points = ["Overview of session concepts."];
          }
          
          var slideStartRow = startRow;
          var numSlideRows = points.length;
          
          for (var p = 0; p < points.length; p++) {
            // Build the row values
            allRows.push([
              sessionNum,
              sess.week,
              sess.module,
              sess.topic,
              sess.hours,
              slideTitle,
              points[p],
              true
            ]);
          }
          
          // Store slide title merge range (Col 6 - F)
          if (numSlideRows > 1) {
            mergeRanges.push({startRow: slideStartRow, numRows: numSlideRows, col: 6});
          }
          
          startRow += numSlideRows;
        }
        
        var numSessionRows = startRow - sessionStartRow;
        if (numSessionRows > 1) {
          // Store session metadata merge ranges (Col 1-5)
          for (var col = 1; col <= 5; col++) {
            mergeRanges.push({startRow: sessionStartRow, numRows: numSessionRows, col: col});
          }
        }
      }
      
      // Write all data in a single batch!
      var totalRows = allRows.length;
      if (totalRows > 0) {
        newSheet.getRange(2, 1, totalRows, chHeaders.length).setValues(allRows);
        
        // Insert checkboxes in Column H (Col 8) for the entire range in a single batch!
        newSheet.getRange(2, 8, totalRows, 1).insertCheckboxes();
        newSheet.getRange(2, 8, totalRows, 1).setValue(true);
        
        // Execute all merges in batch!
        for (var mIdx = 0; mIdx < mergeRanges.length; mIdx++) {
          var m = mergeRanges[mIdx];
          newSheet.getRange(m.startRow, m.col, m.numRows, 1).merge();
        }
        
        // Apply alternating light background colors for sessions
        var currentSessStart = 2;
        for (var k = 0; k < data.sessions.length; k++) {
          var sessRows = 0;
          var s = data.sessions[k];
          var sls = s.slides || [];
          for (var sL = 0; sL < sls.length; sL++) {
            var ptsCount = toArray(sls[sL].points).length;
            sessRows += (ptsCount === 0 ? 1 : ptsCount);
          }
          
          var sessRange = newSheet.getRange(currentSessStart, 1, sessRows, chHeaders.length);
          var bgColor = (k % 2 === 0) ? "#ffffff" : "#f8fafc";
          sessRange.setBackground(bgColor);
          currentSessStart += sessRows;
        }
      }
      
      // Style headers
      var headerRange = newSheet.getRange(1, 1, 1, chHeaders.length);
      headerRange.setBackground("#0f172a");
      headerRange.setFontColor("#ffffff");
      headerRange.setFontWeight("bold");
      headerRange.setHorizontalAlignment("center");
      headerRange.setVerticalAlignment("middle");
      newSheet.setRowHeight(1, 35);
      
      // Enable text wrapping and apply custom grid borders
      if (totalRows > 0) {
        var dataRange = newSheet.getRange(2, 1, totalRows, chHeaders.length);
        dataRange.setWrap(true);
        dataRange.setVerticalAlignment("middle");
        dataRange.setBorder(true, true, true, true, true, true, "#cbd5e1", SpreadsheetApp.BorderStyle.SOLID);
        
        // Alignments
        newSheet.getRange(2, 1, totalRows, 5).setHorizontalAlignment("center");
        newSheet.getRange(2, 6, totalRows, 2).setHorizontalAlignment("left");
        newSheet.getRange(2, 8, totalRows, 1).setHorizontalAlignment("center");
      }
      
      // Set custom column widths
      newSheet.setColumnWidth(1, 70);  // Session Number
      newSheet.setColumnWidth(2, 60);  // Week
      newSheet.setColumnWidth(3, 160); // Module
      newSheet.setColumnWidth(4, 180); // Topic
      newSheet.setColumnWidth(5, 70);  // Hours
      newSheet.setColumnWidth(6, 260); // Slide Number & Title
      newSheet.setColumnWidth(7, 350); // Key Point
      newSheet.setColumnWidth(8, 90);  // Slide Done?
      
      return ContentService.createTextOutput(JSON.stringify({status: "success", message: "New spreadsheet created successfully!", url: newSS.getUrl()}))
        .setMimeType(ContentService.MimeType.JSON);
    }
    
    return ContentService.createTextOutput(JSON.stringify({status: "error", message: "Unsupported action: " + data.action}))
      .setMimeType(ContentService.MimeType.JSON);
  } catch (err) {
    return ContentService.createTextOutput(JSON.stringify({status: "error", message: err.toString()}))
      .setMimeType(ContentService.MimeType.JSON);
  }
}
