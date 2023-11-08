FROM adoptopenjdk/openjdk11:alpine-jre

# Install any necessary tools (e.g., curl) to fetch the artifact
RUN apk add --no-cache curl

# Add the startup script to the image
COPY startup-script.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/startup-script.sh

# Define the entry point to run the startup script
ENTRYPOINT ["startup-script.sh"]

