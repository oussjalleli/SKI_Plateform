FROM adoptopenjdk/openjdk11:alpine-jre
ADD http://192.168.33.10:8081/repository/maven-releases/tn/esprit/ds/SkiStationProject/0.0.1/SkiStationProject-0.0.1.jar ski.jar
ENTRYPOINT ["java", "-jar","ski.jar"]
EXPOSE 8090