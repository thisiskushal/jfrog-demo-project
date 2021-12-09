node {
    checkout scm
    sh './mvn -B -DskipTests clean package'
    docker.build("myorg/myapp").push()
}
