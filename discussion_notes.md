# Discussion Notes & Planned Updates

This document tracks our design feedback, discussions, and planned changes to be updated together.

---

## 1. Desktop Layout & Column Alignment
*   **Observation**: When resizing the browser window on desktop, the grid limits to exactly 3 columns (slabs) per row at a certain screen size. 
*   **Root Cause**: The `body` element in `slides_index.html` has a `max-width: 1200px;` constraint. Combined with a card `min-width` of `320px` plus gaps, 4 columns would require at least `1355px`, which is blocked by the body width limit.
*   **Card Auto-Stretching Issue**: When the screen is resized smaller (showing 2 columns or 1 column), the cards stretch in width to fill the remaining space (`1fr`), making them very wide and flat on medium-sized screens.
*   **Planned Fix**:
    *   Lock the card width (e.g., set a `max-width: 360px;` or use a fixed column grid like `grid-template-columns: repeat(auto-fit, 340px);` and center the grid container) so they look identical and balanced in 3, 2, or 1 column layouts without stretching excessively.

---

## 2. Universal Mobile/Tablet Swipe Controls
*   **Observation**: Touch swipe is not responding consistently on mobile and tablet devices.
*   **Root Cause**: 
    1.  The swipe listener is bound to `.deck` instead of the global `document` context. Swiping on scrolling elements (like the text box `.text-content` or inside the visual container) gets intercepted by default browser scroll/drag behaviors.
    2.  Lack of `touch-action` CSS overrides, allowing default pull-to-refresh or vertical page scroll to cancel horizontal touch events.
*   **Planned Fix (Implementation Methods)**:
    1.  Bind `touchstart` and `touchend` directly to the `document` level to capture swipes anywhere on the screen.
    2.  Set `touch-action: pan-y;` (or `touch-action: none;` for full-screen view) on `.slide` and `.deck` to suppress default horizontal browser swipe triggers.
    3.  Calculate horizontal swipe offsets ($\Delta X$) compared to vertical offsets ($\Delta Y$) to confirm the swipe is strictly horizontal before changing slides.

---

## 3. Auto-Exit on Completion
*   **Requirement**: Swiping "Next" on the final slide (Slide 10) should exit the presentation, return the user to `slides_index.html`, and auto-highlight/select the completed session.
*   **Planned Fix**:
    *   In the slide navigation script, check if `currentSlide === slides.length - 1` when the user swipes left or clicks "Next". 
    *   If true, execute `window.location.href = 'slides_index.html';`.
    *   *Note*: The auto-highlighting is already fully coded in `slides_index.html` via `DOMContentLoaded` (it retrieves `lastViewedSession` from `localStorage` and centers/glow-highlights the card).

---

## 4. Full-Screen Slide Layout (Removing Control Bar)
*   **Requirement**: Make the slides completely full-screen by removing the bottom navigation buttons, progress bar, and fullscreen buttons.
*   **Planned Fix**:
    *   Apply `display: none;` to the `.controls-bar` and progress bar elements.
    *   Adjust the `.slide` and `.deck` height to use `100vh` and width to `100vw` with zero margins/padding.
    *   All navigation will occur purely through keyboard arrows (desktop) and touch swipes (mobile/tablet).

