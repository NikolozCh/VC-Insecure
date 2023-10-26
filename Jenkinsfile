pipeline {
    agent any

    environment {
        ZIP_OUTFILE="${WORKSPACE}/vc.zip"
    }
    stages {
        stage('Create zip file') {
            steps {
                script {
                    zip zipFile: env.ZIP_OUTFILE, overwrite: true, glob: '**/**.sql'
                }
            }
        }
    }

    post {
        success {
            veracode debug: true, scanName: "Jenkins ${env.timestamp}", applicationName: "PL/SQL Testing NC", criticality: "Medium", sandboxName: "PL/SQL Sandbox", waitForScan: true, timeout: 30, deleteIncompleteScan: false, uploadIncludesPattern: "vc.zip", scanIncludesPattern: "vc.zip"
        }
    }
}