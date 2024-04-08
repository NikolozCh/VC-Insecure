pipeline {
    agent any
    environment {
        // JAVA
        ZIP_FILE_NAME="vc-java.zip"
        ZIP_PLSQL_OUTFILE="${WORKSPACE}/${ZIP_FILE_NAME}" 
        FILES_TO_ZIP_PLSQL="java/**/**.java"
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
            // JAVA
            veracode canFailJob: true, scanPollingInterval: 30, scanName: "Jenkins - ${env.BUILD_NUMBER}", applicationName: "Java_HTS", criticality: "Medium", sandboxName: "General-JAVA-APP", waitForScan: true, timeout: 30, deleteIncompleteScan: false, uploadIncludesPattern: ZIP_FILE_NAME, scanIncludesPattern: ZIP_FILE_NAME
        }
    }
}