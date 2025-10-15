pipeline {
    agent any

    environment {
        IMAGE_NAME = "192.168.10.26:5000/tka-fe"
        REGISTRY_URL = "http://192.168.10.26:5000"
    }

    stages {
        stage('Checkout') {
            steps {
                echo '📦 Cloning repository...'
                git branch: 'main', url: 'https://github.com/arrow2601/tka_fe'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🔧 Building Docker image...'
                sh '''
                    docker build -t $IMAGE_NAME:latest .
                '''
            }
        }

        stage('Push to Local Registry') {
            steps {
                echo '🚀 Pushing Docker image to local registry...'
                sh '''
                    # pastikan registry bisa diakses via HTTP (tanpa SSL)
                    docker login -u "" -p "" $REGISTRY_URL || true
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

