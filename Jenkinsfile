pipeline {
  agent any

  environment {
    GIT_REPO = "https://github.com/ihsanabuhanifah/tka_fe"
    DEPLOY_DIR = "/var/www/html/hanafsa_fe"
    PROD_HOST = "hanafsa.web.id"
    SSH_USER = "username_prod"           // ganti dengan user SSH
    SSH_PASS = credentials('hanafsa') // Jenkins credentials ID yang berisi password
  }

  options {
    timestamps()
    disableConcurrentBuilds()
    buildDiscarder(logRotator(numToKeepStr: '20'))
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: "${GIT_REPO}"
      }
    }

    stage('Build') {
      steps {
        sh '''
          docker build -t tka_fe_build .
          docker create --name tka_temp tka_fe_build
          docker cp tka_temp:/app/dist ./app_dist
          docker rm tka_temp
        '''
      }
    }

    stage('Deploy') {
      steps {
        sh '''
          echo "Deploying dist/ to production server using sshpass..."
          sshpass -p "${SSH_PASS}" scp -o StrictHostKeyChecking=no -r ./app_dist/* ${SSH_USER}@${PROD_HOST}:${DEPLOY_DIR}/
        '''
      }
    }
  }

  post {
    success { echo "✅ Deployment successful!" }
    failure { echo "❌ Deployment failed!" }
    always { cleanWs() }
  }
}
