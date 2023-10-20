pipeline {

    environment {
        dockerimagename = "ski"
        dockerImage = ""
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
                sh "mvn --version"
                sh "chmod +x ./mvnw"
                sh "mvn clean package -Pprod"
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
                 script {
                      sh "mvn deploy -Pprod"
                 }
             }
        }
/*
        stage("Deploy Artifact to private registry") {
            steps {
                sh "..............."
            }
        }
//
        stage("Deploy Dokcer Image to private registry") {
            steps {
                sh "..............."
            }
        }
    }
//
    post {
        always {
            cleanWs()
        }
*/
    }
}
