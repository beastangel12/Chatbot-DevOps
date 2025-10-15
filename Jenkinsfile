pipeline {
    agent any

    environment {
        DOCKERHUB_USER = "angelbista"
        IMAGE = "${DOCKERHUB_USER}/chatbot"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                bat "docker build -t %DOCKERHUB_USER%/chatbot:staging ."
            }
        }

        stage('Login to Docker Hub') {
            when { branch 'staging' }
            steps {
                echo "Logging into Docker Hub..."
                withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', 
                                                 usernameVariable: 'USER', 
                                                 passwordVariable: 'PASS')]) {
                    bat 'docker login -u %USER% -p %PASS%'
                }
            }
        }

        stage('Push Docker Image') {
            when { branch 'staging' }
            steps {
                echo "Pushing Docker image to Docker Hub..."
                bat "docker push %DOCKERHUB_USER%/chatbot:staging"
            }
        }
    }

    post {
        always {
            echo "Pipeline finished."
        }
        failure {
            echo "Pipeline failed. Check logs."
        }
        success {
            echo "Pipeline succeeded! Image pushed to Docker Hub."
        }
    }
}
