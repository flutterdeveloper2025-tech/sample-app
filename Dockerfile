pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/flutterdeveloper2025-tech/sample-app.git'
            }
        }

        stage('Deploy') {
            steps {
                sshPublisher(
                    publishers: [sshPublisherDesc(
                        configName: 'server-ssh',
                        transfers: [sshTransfer(
                            sourceFiles: '**/*',
                            removePrefix: '',
                            remoteDirectory: 'sample-app'
                        )],
                        usePromotionTimestamp: false
                    )]
                )
            }
        }
    }
}
