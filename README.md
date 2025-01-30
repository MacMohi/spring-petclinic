# spring-petclinic managed and scanned by JFrog

Build secure pipeline with Jenkins and push the binary to JFrog Artifactory.

## Getting Started

These instructions will give you a copy of the project up and running on
your local machine for development and testing purposes. See deployment
for notes on deploying the project JFrog Artifactory.

### Prerequisites

Requirements for the software and other tools to build, test and push the artifacts to JFrog Artifactory.
- These tools should be already installed: [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git), [Docker](https://docs.docker.com/engine/install/) and [Maven](https://maven.apache.org/install.html)
- JFrog Artifactory, you can start your SaaS [free tour here](https://jfrog.com/start-free/?utm_source=product_tour#trialOptions)
- [Jenkins](https://www.jenkins.io/doc/book/installing/)

### Building project

Before you try it with Jenkins, check it whether it can be done on the CLI.
The examples below show how it was run on Ubuntu.

Download project and build it (for a faster process, you may skip the tests)
```sh
git clone https://github.com/MacMohi/spring-petclinic.git
cd spring-petclinic
mvn clean package -DskipTests
java -jar ./target/spring-petclinic*.jar
```

### Build a runnable docker image

The Dockerfile is ready to use, you may adapt it or change the port
```ruby
FROM openjdk:17-jdk-alpine
WORKDIR /app
COPY ./target/spring-petclinic-*.jar spring-petclinic.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "spring-petclinic.jar"]
```

Build the docker image and you can access it at http://localhost:8080
```sh
docker build -t myspace/spring-petclinic:your_version .
docker run -p 8080:8080 myspace/spring-petclinic:your_version
```

### Deployment: Build and scan the project with JFrog-CLI

After a successful free registration of JFrog SaaS you need to download [JFrog-CLI Site](https://docs.jfrog-applications.jfrog.io/jfrog-applications/jfrog-cli/install).
To configure the cli tool, you will need your credentials like username/password or access-token.
Follow Step 3 and Step 4 from the [JFrog Help Center](https://jfrog.com/help/r/get-started-with-the-jfrog-platform/step-3-add-maven-repositories-and-artifacts) to set-up repositories,
configure and run maven followed by Step 4 to scan for open-source security vulnerabilities and license compliance.

If the configuration with JFrog was successful, during maven-build, the dependencies will be downloaded from JFrog Artifactory.
```sh
Downloaded from central: https://cloud.jfrog.io/artifactory/spring-petclinic-libs-release/com/fasterxml/jackson/....
Downloaded from central: https://cloud.jfrog.io/artifactory/spring-petclinic-libs-release/org/graalvm/buildtools/....
Downloaded from central: https://cloud.jfrog.io/artifactory/spring-petclinic-libs-release/org/codehaus/plexus/....
...
...
```
Otherwise you will see the dependencies downloaded from Maven repository!
```sh
Downloaded from central: https://repo.maven.apache.org/maven2/org/springframework/boot/spring-boot-dependencies/....
Downloading from spring-milestones: https://repo.spring.io/milestone/org/graalvm/buildtools/native-maven-plugin/0.10.3/....
Downloading from central: https://repo.maven.apache.org/maven2/org/graalvm/buildtools/native-maven-plugin/0.10.3/....
...
...
```

## Jenkins Pipeline

A complete workflow how to configure and run JFrog Plugin is described at [JFrog Help Center](https://jfrog.com/help/r/artifactory-how-to-use-jfrog-cli-in-jenkins-using-jfrog-plugin/how-to-run-jfrog-cli-commands-using-jfrog-plugin-inside-jenkins)

