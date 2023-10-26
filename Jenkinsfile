pipeline {
    agent any

    environment {
        ZIP_OUTFILE="${WORKSPACE}/vc.zip"
    }
    stages {
        stage('Create zip file') {
            steps {
                echo "${WORKSPACE}"
                echo "${ZIP_OUTFILE}"
                script {
                    zip zipFile: env.ZIP_OUTFILE, overwrite: true, archive: true, glob: '', dir: ''
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