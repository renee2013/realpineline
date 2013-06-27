setlocal enableextensions
@echo off

REM #######################################################
if "%1" == "" GOTO ERROR_SEC1
if "%2" == "" GOTO ERROR_SEC2
if "%3" == "" GOTO ERROR_SEC3


REM ########################################################
wget -O default.js http://updates.jenkins-ci.org/update-center.json
sed '1d;$d' default.js>default.json
mkdir %JENKINS_HOME%\updates
mv default.json  %JENKINS_HOME%\updates\


REM ########################################################
REM set plugin_base_url=http://updates.jenkins-ci.org/download/plugins/
REM set gitp_url=%plugin_base_url%git/1.4.0/git.hpi
REM set namesetter_url=%plugin_base_url%build-name-setter/1.3/build-name-setter.hpi
REM set envinject_url=%plugin_base_url%envinject/1.87/envinject.hpi
REM set preSCMbuildstep_url=%plugin_base_url%preSCMbuildstep/0.2/preSCMbuildstep.hpi
REM set clone-workspace-scm_url=%plugin_base_url%clone-workspace-scm/0.5/clone-workspace-scm.hpi

REM java -jar jenkins-cli.jar -s %1 install-plugin %gitp_url% %namesetter_url% %envinject_url% %preSCMbuildstep_url% %clone-workspace-scm_url% 

java -jar jenkins-cli.jar -s %1 install-plugin git build-name-setter envinject preSCMbuildstep clone-workspace-scm 


REM ########################################################
call:replaceURL ut-config-template.xml ut-config.xml %2 %3
call:replaceURL ft-config-template.xml ft-config.xml %2 %3
call:replaceURL deploy-to-test-config-template.xml deploy-to-test-config.xml %2 %3
call:replaceURL deploy-to-uat-config-template.xml deploy-to-uat-config.xml %2 %3
call:replaceURL deploy-to-production-config-template.xml deploy-to-production-config.xml %2 %3


REM ########################################################
java -jar jenkins-cli.jar -s %1 create-job UT<ut-config.xml
java -jar jenkins-cli.jar -s %1 create-job FT<ft-config.xml
java -jar jenkins-cli.jar -s %1 create-job deploy-to-test<deploy-to-test-config.xml
java -jar jenkins-cli.jar -s %1 create-job deploy-to-uat<deploy-to-uat-config.xml
java -jar jenkins-cli.jar -s %1 create-job deploy-to-production<deploy-to-production-config.xml

java -jar jenkins-cli.jar -s %1 groovy add_view.gsh

java -jar jenkins-cli.jar -s %1 reload-configuration

GOTO END_SEC


REM ########################################################
:ERROR_SEC1

echo "please provide jenkins url" 
GOTO END_SEC

:ERROR_SEC2

echo "please provide project git diretory" 
GOTO END_SEC

:ERROR_SEC3

echo "please provide project git url" 
GOTO END_SEC



REM ########################################################
:replaceURL 
echo "***************************************"

set TEMP_DIR=%~3
set project_dir=%TEMP_DIR:/=\/%
echo %project_dir%

sed 's/project_dir_to_be_replaced/%project_dir%/g' %~1>temp.xml

set TEMP_URL=%~4
set project_url=%TEMP_URL:/=\/%
echo %project_url%

sed 's/project_git_url_to_be_replaced/%project_url%/g' temp.xml>temp2.xml

del temp.xml
mv temp2.xml %~2

echo "***************************************"


:END_SEC

endlocal
