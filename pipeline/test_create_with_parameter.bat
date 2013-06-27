@echo off

if "%1" == "" GOTO ERROR_SEC1
if "%2" == "" GOTO ERROR_SEC2
if "%3" == "" GOTO ERROR_SEC3

REM java -jar jenkins-cli.jar -s %1 install-plugin xxx

REM call:replaceURL ut-config-template.xml ut-config.xml %2 %3
REM call:replaceURL ft-config-template.xml ft-config.xml %2 %3
REM call:replaceURL deploy-to-test-config-template.xml deploy-to-test-config.xml %2 %3
REM call:replaceURL deploy-to-uat-config-template.xml deploy-to-uat-config.xml %2 %3
REM call:replaceURL deploy-to-production-config-template.xml deploy-to-production-config.xml %2 %3


REM java -jar jenkins-cli.jar -s http://localhost:8080/jenkins2/ create-job UT < ut-config.xml
REM java -jar jenkins-cli.jar -s http://localhost:8080/jenkins2/ create-job FT < ft-config.xml
REM java -jar jenkins-cli.jar -s http://localhost:8080/jenkins2/ create-job deploy-to-test < deploy-to-test-config.xml
REM java -jar jenkins-cli.jar -s http://localhost:8080/jenkins2/ create-job deploy-to-uat < deploy-to-uat-config.xml
REM java -jar jenkins-cli.jar -s http://localhost:8080/jenkins2/ create-job deploy-to-production < deploy-to-production-config.xml

java -jar jenkins-cli.jar -s http://localhost:8080/jenkins2/ groovy add_view.gsh

java -jar jenkins-cli.jar -s http://localhost:8080/jenkins2/ reload-configuration

GOTO END_SEC

:ERROR_SEC1

echo "please provide jenkins url" 
GOTO END_SEC

:ERROR_SEC2

echo "please provide project git diretory" 
GOTO END_SEC

:ERROR_SEC3

echo "please provide project git url" 
GOTO END_SEC




:replaceURL 
echo "***************************************"

set TEMP_DIR=%~3
set project_dir=%TEMP_DIR:/=\/%
echo %project_dir%

sed 's/project_dir_to_be_replaced/%project_dir%/g' %~1 > temp.xml

set TEMP_URL=%~4
set project_url=%TEMP_URL:/=\/%
echo %project_url%

sed 's/project_git_url_to_be_replaced/%project_url%/g' temp.xml > temp2.xml

del temp.xml
mv temp2.xml %~2

echo "***************************************"


:END_SEC