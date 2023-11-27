pipeline {
    agent any

    environment {
        ZIP_OUTFILE="${WORKSPACE}/vc.zip" 
        FILES_TO_ZIP="vuln/**.sql"
    }

    stages {
        stage('Create zip file') {
            steps {
                script {
                    zip zipFile: env.ZIP_OUTFILE, overwrite: true, glob: env.FILES_TO_ZIP
                }
            }
        }
        stage('SonarQube Analysis') {
            steps {
                script {
                    def scannerHome = tool 'SonarLocal', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
                    withSonarQubeEnv {
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
        }
    }

    post {
        success {
            veracode canFailJob: true, scanPollingInterval: 30, scanName: "Jenkins ${env.BUILD_NUMBER}", applicationName: "PL/SQL Testing NC", criticality: "Medium", sandboxName: "PL/SQL Sandbox", waitForScan: true, timeout: 30, deleteIncompleteScan: false, uploadIncludesPattern: "vc.zip", scanIncludesPattern: "vc.zip"
            // veracode canFailJob: true, scanPollingInterval: 30, scanName: "Jenkins ${env.BUILD_NUMBER}", applicationName: "PL/SQL Testing NC", criticality: "Medium", sandboxName: "Ruby Sandbox", waitForScan: true, timeout: 30, deleteIncompleteScan: false, uploadIncludesPattern: "vc.zip", scanIncludesPattern: "vc.zip"
        }
    }
}