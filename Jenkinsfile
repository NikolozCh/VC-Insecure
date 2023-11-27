pipeline {
    agent any

    environment {
        ZIP_JS_OUTFILE="${WORKSPACE}/vc-javascript.zip" 
        FILES_TO_ZIP="javascript/**.js"
    }

    stages {
        stage('Create zip file') {
            steps {
                script {
                    zip zipFile: env.ZIP_JS_OUTFILE, overwrite: true, glob: env.FILES_TO_ZIP
                }
            }
        }
        stage('SonarQube Analysis') {
            steps {
                script {
                    def scannerHome = tool 'SonarLocal';
                    withSonarQubeEnv(installationName: 'SonarLocal') {
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
        }
    }

    post {
        success {
            veracode canFailJob: true, scanPollingInterval: 30, scanName: "Jenkins ${env.BUILD_NUMBER}", applicationName: "PL/SQL Testing NC", criticality: "Medium", sandboxName: "PL/SQL Sandbox", waitForScan: true, timeout: 30, deleteIncompleteScan: false, uploadIncludesPattern: "vc-javascript.zip", scanIncludesPattern: "vc-javascript.zip"
        }
    }
}