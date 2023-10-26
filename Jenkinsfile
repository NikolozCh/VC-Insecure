pipeline {
    agent any

    environment {
        ZIP_OUTFILE="${WORKSPACE}/vc.zip"
    }
    stages {
        stage('Create zip file') {
            steps {
                script {
                    zip zipFile: env.ZIP_OUTFILE, overwrite: true, glob: '**/tcp.sql'
                }
            }
        }
    }

    post {
        success {
            veracode debug: true, scanName: "Jenkins ${env.BUILD_NUMBER}", applicationName: "PL/SQL Testing NC", criticality: "Medium", sandboxName: "PL/SQL Sandbox", waitForScan: true, timeout: 30, deleteIncompleteScan: false, uploadIncludesPattern: "vc.zip", scanIncludesPattern: "vc.zip", vid: "vera01ei-b6c28017bc3dcd380b1533a64dd8a079", vkey: "vera01es-7f2efa0e6cd185fbf2553caebc071e2cfade2d0dd73fabcd706a59f821088944bb4b74241d342de018c60b7cf29fe81dcf958fa0731fe09f43f9d0a7625f4801" 
        }
    }
}