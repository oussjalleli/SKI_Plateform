pipeline {

    environment {
        dockerimagename = "ski"
        dockerImage = ""
        nexusRepositoryURL = "http://192.168.33.10:8081/repository/oussama/"
        nexusRepositoryName = "oussama"  // Replace with your Nexus repository name
        dockerImageVersion = "1.0"  // Replace with your desired image version
    }

    agent any

    stages {
        stage ('GIT') {
            steps {
               echo "Getting Project from Git";
                git branch: 'ouss',
                    url: 'https://github.com/oussjalleli/SKI_Plateform'
            }
        }

        stage("Build") {
            steps {
                sh "chmod +x ./mvnw"
                sh "mvn clean package -Pprod -X"
                sh "mvn --version"
                // sh "mvn clean package -DskipTests"
            }
        }
/*
        stage("Sonar") {
            steps {
                sh "mvn sonar:sonar"
            }
        }
//
        stage("SRC Analysis Testing") {
            steps {
                sh "mvn sonar:sonar"
            }
        }
*/
        stage("Build Docker image") {
            steps {
                script {
                    dockerImage = docker.build(dockerimagename, '.')
                }
            }
        }
        stage("Start app and db") {
            steps {
                sh "docker-compose up -d"
            }
        }


        stage("Deploy Artifact to Nexus") {
            steps {
                sh "mvn deploy -Pprod"
            }
        }

        stage("Deploy Dokcer Image to private registry") {
            steps {
                script {
                    def dockerImage = 'ski'
                    def dockerTag = 'latest'
                    def nexusRegistryUrl = 'http://192.168.33.10:8081/repository/oussama/'
                    def dockerUsername = 'admin'
                    def dockerPassword = 'nexus'

                    sh "docker build -t ${dockerImage}:${dockerTag} ."
                    sh "docker tag ${dockerImage}:${dockerTag} ${nexusRegistryUrl}${dockerImage}:${dockerTag}"
                    sh "docker login -u ${dockerUsername} -p ${dockerPassword} ${nexusRegistryUrl}"
                    sh "docker push ${nexusRegistryUrl}${dockerImage}:${dockerTag}"
                }

            }
        }
    }
}


