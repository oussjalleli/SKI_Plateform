#!/bin/sh

# Define the Nexus repository URL and artifact coordinates
REPO_URL="http://192.168.33.10:8081/repository/maven-releases"
GROUP_ID="tn.esprit.ds"
ARTIFACT_ID="SkiStationProject"
VERSION="1.0.0"

# Fetch the artifact from the Nexus repository
curl -o "$REPO_URL/$GROUP_ID/$ARTIFACT_ID/$VERSION/$ARTIFACT_ID-$VERSION.jar" ski.jar

# Run your Java application with the fetched JAR
java -jar ski.jar
