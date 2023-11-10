pipeline {

    environment {
        dockerimagename = "ski"
        dockerImage = ""
        nexusRepositoryURL = "192.168.33.10:8081/repository/oussama/"
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
        stage('Run JUnit and Mockito Tests') {
            steps {
                // Run JUnit and Mockito tests using Maven
                sh 'mvn test'
            }
        }

        stage('SonarCloud Analysis') {
                    environment {
                        SONAR_ORGANIZATION = 'skioussama'
                        SONAR_PROJECT_KEY = 'skioussama_ski'
                        SONAR_LOGIN = credentials('sonarcloud-token')
                    }
                    steps {
                        script {
                            sh "mvn verify sonar:sonar -Dsonar.host.url=https://sonarcloud.io -Dsonar.organization=${SONAR_ORGANIZATION} -Dsonar.projectKey=${SONAR_PROJECT_KEY} -Dsonar.login=${SONAR_LOGIN}"
                        }
                    }
                }

        stage("Build Docker image") {
            steps {
                script {
                    def dockerImageName = "ski"
                    def NEXUS_BASE_URL = "http://172.17.0.2:8081/repository"
                    def NEXUS_REPOSITORY = "maven-releases"
                    def NEXUS_ARTIFACT_VERSION = "0.0.1"
                    def MAVEN_ARTIFACT_ID = 'SkiStationProject'
                    sh "docker build \
                      --build-arg NEXUS_BASE_URL=${NEXUS_BASE_URL} \
                      --build-arg NEXUS_REPOSITORY=${NEXUS_REPOSITORY} \
                      --build-arg NEXUS_ARTIFACT_VERSION=${NEXUS_ARTIFACT_VERSION} \
                      -t ${dockerImageName}:${DOCKER_IMAGE_TAG} ."
                }
            }
        }



        stage("Deploy Artifact to Nexus") {
            steps {
                sh "mvn deploy -Pprod"
            }
        }

        stage("Deploy Docker Image to private registry") {
            steps {
                script {
                    def dockerImage = 'ski'
                    def dockerTag = 'latest'
                    def nexusRegistryUrl = '172.17.0.2:8082/repository/oussama/'
                    def dockerUsername = 'admin'
                    def dockerPassword = 'nexus'

                    sh "docker build -t ${dockerImage}:${dockerTag} ."
                    sh "docker tag ${dockerImage}:${dockerTag} ${nexusRegistryUrl}${dockerImage}:${dockerTag}"
                    sh "echo ${dockerPassword} | docker login -u ${dockerUsername} --password-stdin ${nexusRegistryUrl}"
                    sh "docker push ${nexusRegistryUrl}${dockerImage}:${dockerTag}"
                }

            }
        }
        stage("Start app and db") {
                    steps {
                        script {
                            def dockerImage = 'ski'
                            def dockerTag = 'latest'
                            def nexusRegistryUrl = '172.17.0.2:8082/repository/oussama/'
                            def dockerUsername = 'admin'
                            def dockerPassword = 'nexus'

                            sh "echo ${dockerPassword} | docker login -u ${dockerUsername} --password-stdin ${nexusRegistryUrl}"
                            sh "docker-compose pull" // Pull the Docker image from the private registry
                            sh "docker-compose up -d"  // Start the application and database containers
                        }
                    }
                }


    }
}


