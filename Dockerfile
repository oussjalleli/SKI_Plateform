FROM adoptopenjdk/openjdk11:alpine-jre
WORKDIR /app
ENTRYPOINT ["java", "-jar","SkiStationProject-0.0.1.jar"]
EXPOSE 8090