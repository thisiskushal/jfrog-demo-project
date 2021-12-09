# jfrog-demo-project

Given the 3-days timeline, I should have achieved the desired outcome but wasn't able to due to competing priorities both at work and home. 
It is unfortunate if I miss my shot at the position based on this and at this time, can only hope for a chance to do the demo and explain my approach, 
thought-process and learnings in the process.

For the jenkins file to be sourced via SCM, the pipeline will have to be set to "Pipeline Script from SCM". 

# A simple Jenkinsfile as follows would do the trick.

node {
git branch: 'main', url: 'https://github.com/spring-projects/spring-petclinic'
sh 'chmod +x mvnw'
sh './mvnw -B -DskipTests clean package'
docker.build("myorg/myapp").push()
}

# The corresponsing Dockerfile would look like this. 

FROM openjdk:8-jdk-alpine
VOLUME /tmp
COPY target/*.jar app.jar
ENTRYPOINT ["java","-jar","-Dserver.port=8085","/app.jar"]

Note: server.port=8085 was to not conflict with my local jenkins running by default on 8080.

# Once available, the app can be launched from the image as follows:

docker run myorg/myapp.

# Alternatively,

The scripted pipeline would look something like this

pipeline {

	agent any

    tools {
        /* You need to add a maven installer with name "3.6.0" in the Global Tools Configuration page 
        or alternatively use docker agent to launch a container with official Maven:tag image and use
        that to build/package code.*/
        maven "MAVEN:3.6.0" 
    }

    stages {

    	/* Checkout code from the public repository */
    	stage('Checkout code') {
	        steps {
	            git branch: 'main', url: 'https://github.com/spring-projects/spring-petclinic'
	        }
	    }

	    stage('Compile'){
	  		steps{
	    		sh 'mvn compile'
	  		}       
    	}

	    stage('Code Quality'){
	      steps{
	        sh 'echo Sonarqube Code Quality Check Done'
	      }
	    }

	    stage('Test'){
	      steps{
	        sh 'mvn test'
	      }
	    }

	    stage('Package'){
	      steps{
	        sh 'mvn -DskipTests clean package'
	      }
	    }

	    stage('Upload War File To Artifactory'){
	      steps{
	        sh 'echo Uploaded War file to Artifactory'
	      }
	    }
	    
	    stage('Checkout DockerFile') {
	        steps {
	            git branch: 'main', url: 'https://github.com/thisiskushal/jfrog-demo-project'
	        }
	    }
	    
	    stage('Deploy'){
      agent any
      steps{
        sh label: '', script: '''rm -rf dockerimg
            mkdir dockerimg
            cd dockerimg
            cp /var/jenkins_home/workspace/kushal-pipeline-demo/target/spring-petclinic-2.5.0-SNAPSHOT.jar .
            touch dockerfile
            cat <<EOT>>dockerfile
            FROM tomcat
            ADD spring-petclinic-2.5.0-SNAPSHOT.jar /usr/local/tomcat/webapps/
            CMD ["catalina.sh", "run"]
            EXPOSE 8080
            EOT
            sudo docker build -t kushal-pipeline-demo:$BUILD_NUMBER .
            sudo docker container run -itd --name webserver$BUILD_NUMBER -p 8085 kushal-pipeline-demo:$BUILD_NUMBER'''
	    }
    }
}
}
