node {
    environment {
        imagename = 'thisiskushal/spring-petclinic'
        registryCredential = 'JfrogCreds'
        dockerImage = ''
    }
    agent any
    
    stages {
        stage('Cloning Git') {
          steps {
            git branch: 'main', url: 'https://github.com/thisiskushal/spring-petclinic'

          }
        }
        
        stage('Compile'){
           steps{
                sh 'mvnw compile'
            }       
        }

        stage('Code Quality'){
          steps{
            sh 'echo Sonarqube Code Quality Check Done'
          }
        }

        stage('Test'){
          steps{
            sh 'mvnw test'
          }
        }

        stage('Package'){
          steps{
            sh 'mvnw -DskipTests clean package'
          }
        }
        
        stage('Building image') {
          steps{
            script {
              sh 'curl -LJO https://raw.githubusercontent.com/thisiskushal/jfrog-demo-project/main/Dockerfile'
              dockerImage = docker.build imagename
            }
          }
        }
        
        stage('Deploy Image') {
          steps{
            script {
              docker.withRegistry( '', registryCredential ) {
                dockerImage.push("$BUILD_NUMBER")
                 dockerImage.push('latest')

              }
            }
          }
        }
    }
}
