pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/flutterdeveloper2025-tech/sample-app.git',
                    credentialsId: '022'
            }
        }
        stage('Build') {
            steps {
                echo 'Building the project...'
                // sh 'npm install' or 'mvn package'
            }
        }
        stage('Test') {
            steps {
                echo 'Running tests...'
                // sh 'npm test' or other test commands
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying project...'
                // sh 'scp ...' or other deployment commands
            }
        }
    }
}
