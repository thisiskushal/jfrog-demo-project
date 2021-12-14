node {
    git branch: 'main', url: 'https://github.com/thisiskushal/spring-petclinic'
    sh './mvnw -B -DskipTests clean package'
    sh 'wget https://raw.githubusercontent.com/thisiskushal/jfrog-demo-project/main/Dockerfile'
    docker.build("myorg/myapp").push()
}
