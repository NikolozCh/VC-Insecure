pipeline {
    agent any

    stages {
        stage('Create zip file') {
            steps {
                script {
                    zip zipFile: "vc.zip", overwrite: true, archive: true
                }
            }
        }
    }

    // post {
    //     success {
    //         veracode: 
    //     }
    // }
}