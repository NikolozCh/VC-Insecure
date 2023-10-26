pipeline {
    agent any

    environment {
        ZIP_OUTFILE="${WORKSPACE}/vc.zip"
    }
    stages {
        stage('Create zip file') {
            steps {
                script {
                    zip zipFile:env:ZIP_OUTFILE, overwrite: true, archive: true
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