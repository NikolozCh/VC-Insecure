pipeline {
    agent any

    environment {
        // Javascript
        ZIP_JS_OUTFILE="${WORKSPACE}/vc-javascript.zip" 
        FILES_TO_ZIP_JS="javascript/**.js"

        // Python
        ZIP_PY_OUTFILE="${WORKSPACE}/vc-python.zip" 
        FILES_TO_ZIP_PY="python/**.py"
    }

    stages {
        stage('Create zip file') {
            steps {
                script {
                    zip zipFile: env.ZIP_JS_OUTFILE, overwrite: true, glob: env.FILES_TO_ZIP_JS
                    zip zipFile: env.ZIP_PY_OUTFILE, overwrite: true, glob: env.FILES_TO_ZIP_PY
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
            // Javascript Scan
            veracode canFailJob: true, scanPollingInterval: 30, scanName: "Jenkins ${env.BUILD_NUMBER}", applicationName: "PL/SQL Testing NC", criticality: "Medium", sandboxName: "Javascript Sandbox", waitForScan: true, timeout: 30, deleteIncompleteScan: false, uploadIncludesPattern: "vc-javascript.zip", scanIncludesPattern: "vc-javascript.zip"

            // Python
            // veracode canFailJob: true, scanPollingInterval: 30, scanName: "Jenkins ${env.BUILD_NUMBER}", applicationName: "PL/SQL Testing NC", criticality: "Medium", sandboxName: "Python Sandbox", waitForScan: true, timeout: 30, deleteIncompleteScan: false, uploadIncludesPattern: "vc-python.zip", scanIncludesPattern: "vc-python.zip"
        }
    }
}