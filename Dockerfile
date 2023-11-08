FROM adoptopenjdk/openjdk11:alpine-jre

# Install any necessary tools (e.g., curl) to fetch the artifact
RUN apk add --no-cache curl

# Define the Nexus repository URL and artifact coordinates
ARG REPO_URL="http://192.168.33.10:8081/repository/maven-releases"
ARG GROUP_ID="tn.esprit.ds"
ARG ARTIFACT_ID="SkiStationProject"
ARG VERSION="1.0.0"
ARG ARTIFACT_FILENAME="$ARTIFACT_ID-$VERSION.jar"

# Fetch the artifact from the Nexus repository and save it as "ski.jar"
RUN curl -o ski.jar "$REPO_URL/$GROUP_ID/$ARTIFACT_ID/$VERSION/$ARTIFACT_FILENAME"

# Define the entry point to run your Java application
ENTRYPOINT ["java", "-jar", "ski.jar"]

# Expose the port
EXPOSE 8090
