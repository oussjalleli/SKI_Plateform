FROM adoptopenjdk/openjdk11:alpine-jre
ADD target/SkiStationProjectgo-0.0.1-SNAPSHOT.jar ski.jar
ENTRYPOINT ["java", "-jar","ski.jar"]
EXPOSE 9090
