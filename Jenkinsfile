pipeline {
    agent any

    stages {
        stage('Create zip file') {
            steps {
                script {
                    zip zipFile: "vc.zip", overwrite: true, glob: "**/**.zip"
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