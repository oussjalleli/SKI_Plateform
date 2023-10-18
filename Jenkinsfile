pipeline {
    agent any

    stages {
        stage('Git') {
            steps {
                echo 'Getting Project from Git'
                git branch: 'ouss', url: 'https://github.com/oussjalleli/SKI_Plateform'
            }
        }


        stage('Build') {
            steps {
                sh 'mvn -version'
                sh 'mvn clean package -DskipTests'
            }
        }

}
