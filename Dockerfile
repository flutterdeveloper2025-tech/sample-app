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
            }
        }
    }
}
