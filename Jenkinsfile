pipeline {
  agent any
  environment {
    DOCKERHUB_USER = "angelbista"
    IMAGE = "${DOCKERHUB_USER}/chatbot"
  }
  stages {
    stage('Build') {
      steps {
        sh 'docker build -t $IMAGE:staging .'
      }
    }
    stage('Push to Docker Hub') {
      when { branch 'staging' }
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
          sh 'echo $PASS | docker login -u $USER --password-stdin'
          sh 'docker push $IMAGE:staging'
        }
      }
    }
  }
}
