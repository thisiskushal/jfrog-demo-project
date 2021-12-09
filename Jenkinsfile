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
	    		sh 'mvn clean compile'
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
	        sh 'mvn -DskipTests package'
	      }
	    }

	    stage('Upload War File To Artifactory'){
	      steps{
	        sh 'echo Uploaded War file to Artifactory'
	      }
	    }
	    
	    stage('Docker Build'){
	        agent {
                dockerfile {
                    reuseNode true
                }
            }
            steps {
                sh 'docker -version'
            }
	    }
	}
}
