stage('Deploy') {
    steps {
        sshPublisher(
            publishers: [sshPublisherDesc(
                configName: '022',       // Jenkins me add kiya hua credential ID
                transfers: [sshTransfer(
                    sourceFiles: '**/*',       // Repo ki saari files
                    remoteDirectory: '/var/www/html/sample-app'
                )],
                usePromotionTimestamp: false
            )]
        )
    }
}
