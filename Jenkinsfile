node {
    checkout scm
    RUN sed -i 's/\r$//' mvnw
    sh './mvnw -B -DskipTests clean package'
    docker.build("myorg/myapp").push()
}
