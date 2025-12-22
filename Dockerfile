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
                echo 'No build needed for HTML site'
            }
        }

        stage('Deploy') {
            steps {
                sshPublisher(
                    publishers: [sshPublisherDesc(
                        configName: '022',
                        transfers: [sshTransfer(
                            sourceFiles: '**/*',
                            removePrefix: '',
                            remoteDirectory: '/var/www/html/sample-app'
                        )],
                        usePromotionTimestamp: false
                    )]
                )
            }
        }
    }
}
