pipeline {
    agent any

    environment {
        // PL/SQL
        ZIP_PLSQL_OUTFILE="${WORKSPACE}/vc-pl.zip" 
        FILES_TO_ZIP_PLSQL="pl_sql/not-vuln/**.sql"
    }

    stages {
        stage('Create zip file') {
            steps {
                script {
                    zip zipFile: env.ZIP_PLSQL_OUTFILE, overwrite: true, glob: env.FILES_TO_ZIP_PLSQL
                }
            }
        }
    }

    post {
        success {
            // PL/SQL
            veracode canFailJob: true, scanPollingInterval: 30, scanName: "Jenkins ${env.BUILD_NUMBER}", applicationName: "PL/SQL Testing NC", criticality: "Medium", sandboxName: "PL/SQL Sandbox", waitForScan: true, timeout: 30, deleteIncompleteScan: false, uploadIncludesPattern: "vc-pl.zip", scanIncludesPattern: "vc-pl.zip"
        }
    }
}