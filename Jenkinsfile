pipeline {
    agent any

    environment {
        IMAGE_NAME = "192.168.10.26:5000/tka-fe"
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Cloning repository...'
                git branch: 'main', url: 'https://github.com/ihsanabuhanifah/tka_fe'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh '''
                    docker build -t $IMAGE_NAME:latest .
                '''
            }
        }

        stage('Push to Local Registry') {
            steps {
                echo 'Pushing Docker image to local registry...'
                sh '''
                    docker push $IMAGE_NAME:latest
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Check logs.'
        }
    }
}
