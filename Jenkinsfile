pipeline {
    agent any

    parameters {
        choice(name: 'ENV', choices: ['dev', 'prod'], description: 'Target environment')
    }

    environment {
        DEV_DIR  = "/var/www/dev"
        PROD_DIR = "/var/www/prod"
        BACKUP   = "/var/backups/prod-last"
    }

    options {
        disableConcurrentBuilds()
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/flutterdeveloper2025-tech/sample-app.git'
            }
        }

        stage('Testing') {
            steps {
                sh '''
                echo "Running basic tests..."
                test -f index.html
                '''
            }
        }

        stage('Deploy to DEV') {
            when {
                expression { params.ENV == 'dev' }
            }
            steps {
                sh '''
                sudo rsync -av --delete \
                --exclude='.git' \
                --exclude='Jenkinsfile' \
                $WORKSPACE/ $DEV_DIR/
                '''
            }
        }

        stage('Approval for PROD') {
            when {
                expression { params.ENV == 'prod' }
            }
            steps {
                input message: 'Deploy to PRODUCTION?'
            }
        }

        stage('Backup PROD') {
            when {
                expression { params.ENV == 'prod' }
            }
            steps {
                sh '''
                sudo rm -rf $BACKUP
                sudo rsync -a $PROD_DIR/ $BACKUP/
                '''
            }
        }

        stage('Deploy to PROD') {
            when {
                expression { params.ENV == 'prod' }
            }
            steps {
                sh '''
                sudo rsync -av --delete \
                --exclude='.git' \
                --exclude='Jenkinsfile' \
                $WORKSPACE/ $PROD_DIR/
                '''
            }
        }
    }

    post {
        failure {
            echo "❌ Build failed – rolling back"
            sh '''
            if [ -d "$BACKUP" ]; then
                sudo rsync -av --delete $BACKUP/ $PROD_DIR/
            fi
            '''
        }

        success {
            echo "✅ Deployment completed successfully"
        }
    }
}
