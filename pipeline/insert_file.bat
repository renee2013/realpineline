@setlocal enableextensions enabledelayedexpansion
@echo off


SET write2=1

(FOR /F "tokens=*" %%A IN (config.xml) DO (
          
     if "!write2!" equ "1" (
	ECHO %%A
        
        echo "%%A" | findstr /C:"<useSecurity>" 1>null
        if not errorlevel 1 (
          type role_security.txt
  	  set write2=2
          
         )  
     )
       
     if "!write2!" equ "3" (
	ECHO %%A
     ) 

     if "!write2!" equ "2" (
      echo "%%A" | findstr /C:"<projectNamingStrategy" 1>null
      if not errorlevel 1 (
        ECHO %%A 
  	set write2=3
        
      )
     )


 )
)>temp.txt
move /y temp.txt config.xml

GoTO END_SEC


:END_SEC







