FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /config-server
COPY opentelemetry-javaagent.jar /otel/opentelemetry-javaagent.jar
COPY . .
RUN mvn clean package -DskipTests

FROM eclipse-temurin:21-jre-alpine
WORKDIR /config-server
COPY --from=build /config-server/target/*.jar config.jar
ENTRYPOINT ["java", "-jar", "config.jar"]