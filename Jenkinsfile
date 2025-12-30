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

        stage('Smoke Test (PROD)') {
            when {
                expression { params.ENV == 'prod' }
            }
            steps {
                sh '''
                echo "Running smoke test on PROD..."

                STATUS=$(curl -o /dev/null -s -w "%{http_code}" http://20.205.120.32/prod/)

                if [ "$STATUS" != "200" ]; then
                    echo "❌ Smoke test failed. HTTP status: $STATUS"
                    exit 1
                fi

                echo "✅ Smoke test passed"
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
