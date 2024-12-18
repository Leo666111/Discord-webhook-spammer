@echo off
:: Open Notepad
start notepad

:: Wait for Notepad to open
timeout /t 2 >nul

:: Type the message into Notepad
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('Thanks for using!');"
set /p "webhook=Enter your Discord webhook URL: "

:: Check if the user provided a valid URL
if not "%webhook:~0,8%" == "https://" (
    echo Invalid webhook URL. Please enter a valid Discord webhook URL.
    pause
    exit /b
)

:: Ask for the message to send
set /p "message=Enter the message you want to spam to the Discord webhook: "

:: Ask for the spam interval in seconds
set /p "interval=Enter the interval (in seconds) between each message: "

:: Convert interval to number (if not already)
for /F "delims=" %%i in ("%interval%") do set interval=%%i

:: Start spam loop
:loop
curl -X POST -H "Content-Type: application/json" -d "{\"content\": \"%message%\"}" %webhook%
echo Message sent!
ping -n %interval% > nul  :: Wait for the specified interval
goto loop

:: Last comment
start notepad
timeout /t 2 >nul
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('we love you, oh and more stuff comin soon🤫');
