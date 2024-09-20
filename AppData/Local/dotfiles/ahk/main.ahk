#Requires AutoHotkey v2.0+
#SingleInstance Force
KeyHistory 0
ListLines False
Persistent True

TrayTip "Started", "Main.AHK", 1
SoundBeep 300, 190
Return

; Insert Date and Time
#d::Send(A_MM '/' A_DD '/' A_YYYY ' ' FormatTime(, "h:mmtt"))

; ---------- JobSearch Hotkeys
; disable Windows Lock Behavior first to free up Win + L.  (edit registry)
#l::Send("https://www.linkedin.com/in/alu826")
#g::Send("https://github.com/aleckslu")
;#p::Send("") ; portfolio
#t::Send("Software Engineer")
#o::Send("Overvue")

; #HotIf WinActive("ahk_exe chrome.exe")
; #n::Send("Narrative")
; #c::Send("Cover Letter")
; #HotIf

; HotIfWinActive WinTitle, WinText
; HotIfWinExist WinTitle, WinText
; HotIfWinNotActive WinTitle, WinText
; HotIfWinNotExist WinTitle, WinText

; HotIfWinActive "ahk_class Notepad"
; Hotkey "^!e", MyFuncForNotepad  ; Creates a hotkey that works only in Notepad.

; ---------- AHK Management

; Reload Script
#!^+r::Reload

; Stop Script
#!^+q::ExitApp

; Pause /Unpause Script
#SuspendExempt
#!^+p::
{
Suspend -1
if (A_IsSuspended) {
  TrayTip "Paused", "Main Script", 1
} else {
  TrayTip "Resumed", "Main Script", 1
}
Return
}
#SuspendExempt
