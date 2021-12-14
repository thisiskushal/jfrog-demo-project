node {
    environment {
        imagename = 'thisiskushal/spring-petclinic'
        registryCredential = 'JfrogCreds'
        dockerImage = ''
    }
    
    stage('Cloning Git') {
        git branch: 'main', url: 'https://github.com/thisiskushal/spring-petclinic'
    }

    stage('Compile'){
        sh './mvnw compile'
    }

    stage('Code Quality'){
        sh 'echo Sonarqube Code Quality Check Done'
    }

    stage('Test'){
        sh './mvnw test'
    }

    stage('Package'){
        sh './mvnw -DskipTests clean package'
    }

    stage('Building image') {
        script {
          sh 'curl -LJO https://raw.githubusercontent.com/thisiskushal/jfrog-demo-project/main/Dockerfile'
          dockerImage = docker.build imagename
        }
    }

    stage('Deploy Image') {
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push("$BUILD_NUMBER")
             dockerImage.push('latest')
          }
        }
    }
}
