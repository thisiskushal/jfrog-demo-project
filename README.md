## Table of contents
* [The Problem Statement](#the-problem-statement)
* [Deliverables](#deliverables)
* [Environments](#environments)
* [Setup](#setup)
* [Launch](#launch)

## The Problem Statement
* Use Spring pet-clinic (https://github.com/spring-projects/spring-petclinic) as your project source code 
* Build a Jenkins pipeline with the following steps:
	* Compile the code
	* Run the tests
	* Package the project as a runnable Docker image
* Make sure all dependencies are resolved from JCenter
* Bonus - use JFrog Artifactory in your pipeline

## Deliverables
* GitHub link to the repo including
	* Jenkins file within that repo
	* Docker file within that repo
	* readme.md file explaining the work and how to run the project 
* Attached runnable docker image + the command to run it

	
## Environments
Project is created with:
* Local Jenkins v2.324 running at http://localhost:8080
	* Installed using `brew install jenkins`
* Local Docker v20.10.8 to support docker commands within the jenkins pipeline.
* Created Free Cloud hosted Artifactory running at https://santoshkushaldemo.jfrog.io/
	
## Setup
* Installed plugins within "Manage Jenkins"
* Downloaded settings.xml from Artifactory with encrypted password and replaced within .m2 folder
* Forked the source code to locakand added the following config to the pom.xml
```
	<distributionManagement>
		<repository>
			<id>central</id>
			<name>a0iaweaon0acy-artifactory-primary-0-releases</name>
			<url>https://santoshkushaldemo.jfrog.io/artifactory/kushaldemo-libs-release</url>
		</repository>
		<snapshotRepository>
			<id>snapshots</id>
			<name>a0iaweaon0acy-artifactory-primary-0-snapshots</name>
			<url>https://santoshkushaldemo.jfrog.io/artifactory/kushaldemo-libs-snapshot</url>
		</snapshotRepository>
	</distributionManagement>
```

## Launch
Run the following command to launch the access the petclinic website from the docker image hosted on the artifactory repository
`docker run -p 8085:8085 santoshkushaldemo.jfrog.io/kushaldemo-docker/thisiskushal/spring-petclinic:latest`
