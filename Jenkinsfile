pipeline {
    agent any
    environment {
        DOCKERHUB_USER = "angelbista"
        IMAGE = "${DOCKERHUB_USER}/chatbot"
    }
    stages {
        stage('Build') {
            steps {
                bat 'docker build -t %DOCKERHUB_USER%/chatbot:staging .'
            }
        }
        stage('Push to Docker Hub') {
            when { branch 'staging' }
            steps {
                bat 'docker login -u angelbista -p <your-docker-password>'
                bat 'docker push %DOCKERHUB_USER%/chatbot:staging'
            }
        }
    }
}
