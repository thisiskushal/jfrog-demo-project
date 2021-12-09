node {
    git branch: 'main', url: 'https://github.com/spring-projects/spring-petclinic'
    //sh 'sed -i ''s/\r$//'' mvnw'
    sh 'chmod +x mvnw'
    sh './mvnw -B -DskipTests clean package'
    docker.build("myorg/myapp").push()
}
