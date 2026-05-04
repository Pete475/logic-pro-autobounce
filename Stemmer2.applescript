-- Stemmer 2: Auto-Naming Sequential Stem Bouncer

property totalTracks : 2
property cueLengthSeconds : 20
property missedTracks : {}

tell application "Logic Pro X" to activate
delay 1

tell application "System Events"
	tell process "Logic Pro X"
		
		repeat with i from 1 to totalTracks
			try
				-- 1. GET THE TRACK NAME
				-- Shift + Enter is the default shortcut to rename a track
				keystroke return using {shift down}
				delay 0.5
				-- Cmd + C to copy the highlighted name
				keystroke "c" using {command down}
				delay 0.5
				-- Escape to exit the rename box without changing anything
				key code 53
				delay 0.5
				
				-- 2. Solo the current track
				keystroke "s"
				delay 0.5
				
				-- 3. Trigger a Bounce (Cmd + B)
				keystroke "b" using {command down}
				delay 2
				
				-- 4. Confirm Bounce Dialog (Enter)
				keystroke return
				delay 2
				
				-- 5. PASTE THE NAME
				-- Now we are in the "Save As" window. 
				-- We delete whatever was there and paste the track name.
				keystroke "v" using {command down}
				delay 1
				keystroke return -- Save the file
				
				-- 6. Progress Watch
				display notification "Bouncing: " & (the clipboard) with title "Stemmer2 at Work"
				
				repeat (cueLengthSeconds / 10) as integer times
					delay 10
				end repeat
				
				-- 7. Clean up for next track
				keystroke "s" -- Unsolo
				delay 0.5
				key code 125 -- Down Arrow
				delay 1
				
			on error errMsg
				set end of missedTracks to i
				key code 53 -- Escape
				delay 1
				keystroke "s" -- Unsolo
				key code 125 -- Next track
				delay 1
			end try
		end repeat
		
	end tell
end tell

-- (Include the same FINAL REPORT logic at the bottom)