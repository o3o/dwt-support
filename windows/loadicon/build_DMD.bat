@echo off

REM Change to your DWT lib location
set DWT=D:\DEV\Libs\dwt

set source=app
set target=loadicon.exe

echo Building: %source%

del %source%*.obj /Q
del %source%*.exe /Q

dmd src\%source% res\icons.res -of%target% -release -O ^
	-I%DWT%\imp -J%DWT%\res -L+%DWT%\lib\ ^
	"-L+org.eclipse.swt.win32.win32.x86.lib" ^
	"-L+dwt-base.lib" ^
	"-L/SUBSYSTEM:WINDOWS:4.0"	
)

del *.obj /Q

start %target%

