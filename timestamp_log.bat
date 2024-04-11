::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: writes timestamp in log-file 
:: scheduled by Windows Task Scheduler after system-startup/sign-in
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

@echo off

:::  DIRECTORY  :::
set path=%~dp0LogFiles_TimeStamp

:::  ACTION  ::: 
:: gives date and time (print to prompt) 
::date /t && time /t
echo. && echo.

:: date and time in variable
set datetime=%date% %time:~0,8%
echo %datetime%
echo. && echo.

:: writes (adds) to existing file (new_line)							:: builds new file if doesnt exist ... single '>' writes new file / overwrites existing file
echo %datetime% >> %path%\timestamp.txt 										

:: "confirms" file-writing 
echo File was written...
echo. && echo. && echo. && echo. && echo.

:: open log-file 
::start %path%\timestamp.txt

:::  END  ::: 															              :: show prompt-window after run
PAUSE
