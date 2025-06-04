pipeline {
    agent any

    environment {
        IMAGE_NAME = "vareladavid/wordpress-k3s"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'github-ssh', url: 'git@github.com:VARELAdavidhugo/wordpress-k3s.git'
            }
        }

        stage('Build Docker Image') {
            steps {
  stage('Build Docker Image') {
    steps {
        sh "docker build -t ${IMAGE_NAME}:latest -f Dockerfile ."
    }
}
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
                    sh "docker push ${IMAGE_NAME}:latest"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f k8s/'
            }
        }
    }
}
