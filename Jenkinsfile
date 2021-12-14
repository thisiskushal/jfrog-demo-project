node {
    git branch: 'main', url: 'https://github.com/thisiskushal/spring-petclinic'
    //sh 'sed -i ''s/\r$//'' mvnw'
    sh 'chmod +x mvnw'
    sh './mvnw -B -DskipTests clean package'
    sh 'curl -f https://raw.githubusercontent.com/thisiskushal/jfrog-demo-project/main/Dockerfile'
    docker.build("myorg/myapp").push()
}
