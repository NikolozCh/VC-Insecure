pipeline {
    agent any

    environment {
        ZIP_OUTFILE="${WORKSPACE}/vc.zip" 
        FILES_TO_ZIP="vuln/**.sql"
    }

    stages {
        stage('SCA Agent Stage') {
            steps {
                // https://download.sourceclear.com/ci.sh
                script {
                    withCredentials([string(credentialsId: 'SRCCLR_API_TOKEN', variable: 'API_TOKEN')]) {
                        sh 'export SRCCLR_API_TOKEN=$API_TOKEN'
                        sh 'curl -sSL https://download.sourceclear.com/ci.sh | sh'
                        sh 'export SRCCLR_API_TOKEN=dump'
                    }
                }
            }
        }
        // stage('Create zip file') {
        //     steps {
        //         script {
        //             zip zipFile: env.ZIP_OUTFILE, overwrite: true, glob: env.FILES_TO_ZIP
        //         }
        //     }
        // }
    }

    // post {
    //     success {
    //         veracode canFailJob: true, scanPollingInterval: 30, scanName: "Jenkins ${env.BUILD_NUMBER}", applicationName: "PL/SQL Testing NC", criticality: "Medium", sandboxName: "PL/SQL Sandbox", waitForScan: true, timeout: 30, deleteIncompleteScan: false, uploadIncludesPattern: "vc.zip", scanIncludesPattern: "vc.zip"
    //         // veracode canFailJob: true, scanPollingInterval: 30, scanName: "Jenkins ${env.BUILD_NUMBER}", applicationName: "PL/SQL Testing NC", criticality: "Medium", sandboxName: "Ruby Sandbox", waitForScan: true, timeout: 30, deleteIncompleteScan: false, uploadIncludesPattern: "vc.zip", scanIncludesPattern: "vc.zip"
    //     }
    // }
}