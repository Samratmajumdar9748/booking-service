FROM maven:3.6.0-jdk-13 as build

WORKDIR /usr/src/app

COPY src /usr/src/app/src
COPY pom.xml /usr/src/app
RUN mvn -f /usr/src/app/pom.xml clean package


FROM openjdk:18-jdk-alpine
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/target/bookingService.jar /usr/app/bookingService.jar
EXPOSE 8081
CMD ["java","-jar","/usr/app/bookingService.jar"]