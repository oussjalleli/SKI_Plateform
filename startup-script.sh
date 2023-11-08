#!/bin/sh

# Define the Nexus repository URL and artifact coordinates
REPO_URL="http://192.168.33.10:8081/repository/maven-releases"
GROUP_ID="tn.esprit.ds"
ARTIFACT_ID="SkiStationProject"
VERSION="1.0.0"
ARTIFACT_FILENAME="$ARTIFACT_ID-$VERSION.jar"

# Fetch the artifact from the Nexus repository and save it as "ski.jar"
curl -o ski.jar "$REPO_URL/$GROUP_ID/$ARTIFACT_ID/$VERSION/$ARTIFACT_FILENAME"

# Run your Java application with the fetched JAR
java -jar ski.jar
