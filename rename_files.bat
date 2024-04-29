::XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

:: Durchsucht das aktuelle Verzeichnis nach .m4a-Files (erweiterbar auf andere Formate) 
	:: und kürzt deren DateiNamen um eine festgelegte Anzahl an Zeichen, 
	:: legt vorher ein BackUp aller zu bearbeitenden Files an 
	:: (fehlt: Löschung des BackUps (erfragen), falls UmbenennungsProzess erfolgreich) 
:: Datei rename_files.bat muss sich im Ordner der Files befinden & dort ausgeführt werden 
:: VORSICHT: Nicht mehrmals hintereinander auf dieselben Files anwenden 
	:: (fehlt: SicherheitsAbgleich vor ungewollter 2ter Ausführung (mit textDatei/BackUp))  

::XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

@echo off


echo. && echo CURRENT DIRECTORY :
cd

::echo. && echo CONTENTS OF CURRENT DIRECTORY :
::dir


echo.
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo.

echo FILES IN CURRENT DIRECTORY :

for %%i in (*) do ( echo %%~nxi )


echo.
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo.

:: FILE-FORMAT vorhanden ? 

if exist *.m4a ( echo yes, there are .m4a-files	) else ( echo there are no .m4a-files )

::echo -------------------------
::echo LIST OF ALL EXTENSIONS (THIS_DIRECTORY/SUBDIRECTORIES) : 
::for %%i in (*) do ( echo %%~xi )


echo.
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo.

:: BACKUP-FOLDER exists/erstellen

if exist _backUp_files_before_rename ( echo BACKUP-DIRECTORY IS AVAILABLE ) else (
	mkdir _backUp_files_before_rename && echo BACKUP-DIRECTORY SUCCESSFULLY CREATED
	)

echo.


:: RE-NAME - vorher BACKUP 												:: EnableDelayedExpansion: If not enabled the Variable-Prints would be executed before the Variables are set

setlocal EnableDelayedExpansion	
for %%i in (*) do (
	if "%%~xi" == ".m4a" (echo THIS FILE WAS DETECTED : && echo %%~nxi
		if exist _backUp_files_before_rename\%%~nxi (echo BACKUP ALREADY EXISTS...) else (
			copy "%%~dpnxi" _backUp_files_before_rename && echo COPIED TO BACKUP-DIRECTORY
			)
		set a=%%~ni
		::echo !a!
		set name=!a:~10,-14!
		rename "%%~nxi" "!name!%%~xi"
		echo CHANGED FILENAME TO : && echo !name!
		)
	)


ECHO.
ECHO XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
ECHO.

echo this file did the job: 
echo %~nx0
echo. && echo.

PAUSE 
