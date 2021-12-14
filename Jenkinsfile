def imagename = "thisiskushal/spring-petclinic:$BUILD_NUMBER"

node {
    environment {
        registryCredential = 'JfrogCreds'
        dockerImage = ''
    }
    
    stage('Cloning Git') {
        git branch: 'main', url: 'https://github.com/thisiskushal/spring-petclinic'
    }

    stage('Compile'){
        sh './mvnw compile'
    }

    /*stage('SonarQube analysis') {
        withSonarQubeEnv('SonarQube') {
            sh "./gradlew sonarqube"
        }
    }
    stage("Quality gate") {
        waitForQualityGate abortPipeline: true
    }*/

    stage('Test'){
        sh './mvnw test'
    }

    stage('Package'){
        sh './mvnw -DskipTests clean package'
    }
    
    stage('Deploy'){
        sh './mvnw -DskipTests deploy'
    }

    stage('Building image') {
        sh 'curl -LJO https://raw.githubusercontent.com/thisiskushal/jfrog-demo-project/main/Dockerfile'
        sh 'docker build -t thisiskushal/spring-petclinic:$BUILD_NUMBER .'
    }

    stage('Deploy Image') {
        sh 'docker tag thisiskushal/spring-petclinic:$BUILD_NUMBER santoshkushaldemo.jfrog.io/kushaldemo-docker/thisiskushal/spring-petclinic:$BUILD_NUMBER'
        sh 'docker push santoshkushaldemo.jfrog.io/kushaldemo-docker/thisiskushal/spring-petclinic:$BUILD_NUMBER'
    }
}
