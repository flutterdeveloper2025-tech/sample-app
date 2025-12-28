pipeline {
    agent any

    environment {
        DEPLOY_PATH = "/var/www/html"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                url: 'https://github.com/flutterdeveloper2025-tech/sample-app.git'
            }
        }

        stage('Deploy using rsync') {
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
            echo "✅ Deployed using rsync successfully"
        }
        failure {
            echo "❌ Deployment failed"
        }
    }
}
