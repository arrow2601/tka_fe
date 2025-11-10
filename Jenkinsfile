pipeline {
  agent any

  environment {
    GIT_REPO = "https://github.com/ihsanabuhanifah/tka_fe"
    DEPLOY_DIR = "/var/www/html/hanafsa_fe"
    PROD_HOST = "hanafsa.web.id"
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
          docker cp tka_temp:/usr/src/app/dist ./app_dist
          docker rm tka_temp
        '''
      }
    }

    stage('Deploy to Web Server') {
  steps {
    echo "🚀 Deploying to 192.168.10.26 (port 26) using SSH username & password..."
    withCredentials([usernamePassword(credentialsId: 'ssh_ke_web', usernameVariable: 'SSH_USER', passwordVariable: 'SSH_PASS')]) {
      sh '''
        # Copy app/dist ke server
        sshpass -p "$SSH_PASS" scp -o StrictHostKeyChecking=no  -r ./app_dist/* $SSH_USER@hanafsa.web.id:/var/www/html/hanafsa_fe/
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
