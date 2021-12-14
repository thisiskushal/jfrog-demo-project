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

    stage('Building image') {
        sh 'curl -LJO https://raw.githubusercontent.com/thisiskushal/jfrog-demo-project/main/Dockerfile'
        sh 'docker build -t thisiskushal/spring-petclinic:$BUILD_NUMBER .'
    }

    stage('Deploy Image') {
        sh 'docker tag test:1 santoshkushaldemo.jfrog.io/kushaldemo-docker/test1:123'
        sh 'docker push santoshkushaldemo.jfrog.io/kushaldemo-docker/test1:123'
    }
}
