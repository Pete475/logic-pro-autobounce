# Stemmer2: logic-pro-autobounce
Sequential live stem bouncing automation for Logic Pro X 
---
*Created to solve the "100-track bounce" headache.*

A macOS automation script that sequentially solos and bounces tracks in real-time. 
Designed for composers/producers using external sample rigs where offline bouncing isn't reliable.

**Very useful** for those 100+ track exports 

## What it does
- **Sequential Soloing:** Automatically moves through your track list.
- **Live Capture:** Triggers a real-time bounce for each track.
- **Error Handling:** Includes `try/catch` blocks to skip failed tracks and keep the session moving.
- **Final Report:** Alerts you at the end if any tracks were missed.

## Setup
1. Open **Script Editor** on macOS.
2. Copy the code from `live_stem_bounce.applescript` into the editor.
3. Set your `totalTracks` and `cueLengthSeconds` at the top of the script.
4. Ensure Logic Pro is in **Cycle Mode** for the desired bounce length.
5. Verify you are in bouncing in **Real Time** and that your Bounce Destination Folder is correct
6. Verify your desired **Audio Quality** (likely 48K Wav) 

## ⚖️ Permissions
This script requires **Accessibility** and **Automation** permissions in `System Settings > Privacy & Security` to send keystrokes to Logic Pro.


