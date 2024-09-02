
;;;Link - https://www.reddit.com/r/AutoHotkey/comments/lvzqlx/share_your_most_useful_ahk_scripts_my_huge/

; minimize / maximize windows
f7::WinMinimize, A
return

f8::WinMaximize, A
return

;Volume mixer, f7 opens it, if it's not active it recalls it, if its active, 
;it closes it

#MaxThreadsPerHotkey 2
SetTitleMatchMode, 2

F7::
Run, "SndVol.exe" 
return

#IfWinActive Mezclador
	F7::WinClose, A
	return


; another if winactive script
F7::
    if WinActive("Mezcaldor")
        WinClose
    else Run SndVol.exe
return

; idk exactly, something about hotkeys for google searching.  looks like you can make objects/arrays
google(service := 1)
{
    static urls := { 0: ""
        , 1 : "https://www.google.com/search?hl=en&q="
        , 2 : "https://www.google.com/search?site=imghp&tbm=isch&q="
        , 3 : "https://www.google.com/maps/search/"
        , 4 : "https://translate.google.com/?sl=auto&tl=en&text=" }
    backup := ClipboardAll
    Clipboard := ""
    Send ^c
    ClipWait 0
    if ErrorLevel
        InputBox query, Google Search,,, 200, 100
    else query := Clipboard
    Run % urls[service] query
    Clipboard := backup
}

    ; extended example of above

webSearch(service := 1)
{
    static urls := { 0: ""
        , 1 : "https://duckduckgo.com/?q="
        , 2 : "https://www.google.com/search?hl=en&q="
        , 3 : "https://www.google.com/search?site=imghp&tbm=isch&q="
        , 4 : "https://www.bing.com/search?q="
        , 5 : "https://en.wikipedia.org/wiki/Special:Search?search="
        , 6 : "https://www.imdb.com/find?s=all&q=" }
    backup := ClipboardAll
    Clipboard := ""
    Send ^c
    ClipWait 0
    if ErrorLevel
        InputBox query, Web Search,,, 200, 100
    else query := Clipboard
    Run % urls[service] query
    Clipboard := backup
}

; 1. Use the function as many times as needed. 
    ; Search DDG, Google and Bing F1::webSearch(1),webSearch(2),webSearch(4)

    ; Search Wikipedia and IMDB
    F2::
        webSearch(5)
        webSearch(6)
    return

; 2. The order in the parameters of a URL lacks of meaning. 
    ; "Ordered"
    ;//example.com/?parameter1=value1&parameter2=value2&parameterNoValue
    ; Shuffled, same result
    ;//example.com/?parameter2=value2&parameterNoValue&parameter1=value1

    ; Your example:
    ;//randomwebsite/search?q=query&sbtpshiptoEU
    ; Can be represented as:
    ;//randomwebsite/search?sbtpshiptoEU&q=query

