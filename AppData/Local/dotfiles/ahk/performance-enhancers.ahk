#Requires AutoHotkey v2.0+



; noenv disables environment variables and are usually recommended for all scripts.  speeds them up

; keyhistory and listlines are used to log keys and usually only useful for debugging.  Disable for performance
#KeyHistory 0
ListLines


Run notepad.exe,,, NewPID
Process, Priority, %NewPID%, High

; SendInput is the fastest sending method.  Default is SendEvent (2nd fastest)
SendInput 

;settimer better than sleep.  sleep disables accepting input while sleeping, settimer still allows use of other hotkeys 