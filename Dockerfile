FROM openjdk:19 AS dev
WORKDIR /app
EXPOSE 8000
ENTRYPOINT [ "./mvnw", "spring-boot:run", "-Dspring-boot.run.jvmArguments='-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:8001'" ]

FROM openjdk:19 AS build
WORKDIR /app
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN ./mvnw dependency:go-offline
COPY ./src ./src
RUN ./mvnw clean install
 
FROM openjdk:19 AS prod
WORKDIR /app
EXPOSE 8080
COPY --from=build /app/target/*.jar /app/*.jar
ENTRYPOINT ["java", "-jar", "/app/*.jar" ]
