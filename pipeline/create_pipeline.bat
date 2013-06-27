

java -jar jenkins-cli.jar -s http://localhost:8080/jenkins2/ install-plugin git build-name-setter envinject preSCMbuildstep clone-workspace-scm 


java -jar jenkins-cli.jar -s http://localhost:8080/jenkins2/ create-job build < build-config.xml
java -jar jenkins-cli.jar -s http://localhost:8080/jenkins2/ create-job test < test-config.xml
java -jar jenkins-cli.jar -s http://localhost:8080/jenkins2/ create-job deploy < deploy-config.xml

java -jar jenkins-cli.jar -s http://localhost:8080/jenkins2/ groovy add_view.gsh

java -jar jenkins-cli.jar -s http://localhost:8080/jenkins2/ reload-configuration
