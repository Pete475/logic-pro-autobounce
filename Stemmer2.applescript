-- Stemmer 2: Auto-Naming Sequential Stem Bouncer

property totalTracks : 2
property cueLengthSeconds : 20
property cueTimecode : "_01-00-30-00" -- Set your start time here
property missedTracks : {}

tell application "Logic Pro X" to activate
delay 1

tell application "System Events"
	tell process "Logic Pro X"
		
		repeat with i from 1 to totalTracks
			try
				-- 1. GET THE TRACK NAME
				-- Shift + Enter is default shortcut to rename track
				keystroke return using {shift down}
				delay 0.5
				-- Cmd + C to copy the highlighted name
				keystroke "c" using {command down}
				delay 0.5
				-- Escape to exit the rename box without changing anything
				key code 53
				delay 0.5
				
				-- 2. Solo current track
				keystroke "s"
				delay 0.5
				
				-- 3. Trigger Bounce (Cmd + B)
				keystroke "b" using {command down}
				delay 2
				
				-- 4. Confirm Bounce Dialog (Enter)
				keystroke return
				delay 2
				
				-- 5. PASTE THE NAME
				-- Now in "Save As" window. 
				-- Delete whatever was there and paste the track name.
				keystroke "a" using {command down} -- Select all old text
				key code 51 -- Delete/Backspace
				delay 0.5
				keystroke "v" using {command down}
				delay 1
				keystroke cueTimecode
				-- If You Want To Add Anything to Name and Timecode (Date, Project Name, etc) Add It Here 
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

if (count of missedTracks) is 0 then
    display alert "Success!" message "All " & totalTracks & " stems captured perfectly."
else
    set AppleScript's text item delimiters to ", "
    set missedList to missedTracks as string
    display alert "Bounce Finished with Issues" message "Captured " & (totalTracks - (count of missedTracks)) & " tracks. 
    
    Missed Track Indexes: " & missedList
end if
