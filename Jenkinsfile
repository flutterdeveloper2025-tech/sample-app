pipeline {
    agent any

    environment {
        DEPLOY_PATH = "/var/www/html"
    }

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/flutterdeveloper2025-tech/sample-app.git'
            }
        }

        stage('Deploy to Nginx (rsync)') {
            steps {
                sh '''
                sudo rsync -av --delete \
                --exclude='.git' \
                --exclude='Jenkinsfile' \
                $WORKSPACE/ $DEPLOY_PATH/
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Deployment completed successfully"
        }
        failure {
            echo "❌ Deployment failed"
        }
    }
}
