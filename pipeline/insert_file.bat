@setlocal enableextensions enabledelayedexpansion
@echo off


SET write=1

(FOR /F "tokens=*" %%A IN (config.xml) DO (
          
     if "%write%" equ "1" (
	ECHO %%A
        
        echo "%%A" | findstr /C:"<useSecurity>" 1>null
        if not errorlevel 1 (
          type role_security.txt
  	  set write=2
          echo "%write%" "222222222222222222222222222222222222222222222222222"
         )  
     )
       
     if "%write%" equ "3" (
	ECHO %%A
     ) 

     if "%write%" equ "2" (
      echo "%%A" | findstr /C:"<projectNamingStrategy" 1>null
      if not errorlevel 1 (
        ECHO %%A 
  	set write=3
        echo "%write%" "33333333333333333333333333333333333333333333333333333"
      )
     )


 )
)
REM >temp.txt
REM move /y temp.txt config.xml

GoTO END_SEC




:insert_txt

   FOR /F "tokens=*" %%A IN (config.xml) DO (
     ECHO %%A
     REM call:findIt "<useSecurity>" %%A
    ) >temp.txt
move /y temp.txt config.xml
goto :eof


:findIt

echo "%~2" | findstr /C:"%~1" 1>nul

if not errorlevel 1 (
  type role_security.txt
  echo "111111111111111111111111111111111111111111111111111111111111111111111"
)

 

goto :eof

:END_SEC







