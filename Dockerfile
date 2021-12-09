FROM maven
VOLUME /tmp
COPY target/*.jar app.jar
ENTRYPOINT ["java","-jar","-Dserver.port=8085","/app.jar"]
