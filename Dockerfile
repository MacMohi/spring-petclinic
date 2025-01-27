# This is a pre-stage to build the application
FROM openjdk:17-jdk-alpine AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
COPY .mvn ./.mvn
COPY mvnw .
RUN ./mvnw clean package

# Second and last stage is to create the final image
FROM openjdk:17-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/spring-petclinic-*.jar spring-petclinic.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "spring-petclinic.jar"]
