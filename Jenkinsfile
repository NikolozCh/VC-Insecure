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
                    withSonarQubeEnv(installationName: 'SonarLocal', credentialsId: '98d4e60b-3f32-480c-aecb-0de3247b7289') {
                        sh 'mvn clean org.sonarsource.scanner.maven:sonar-maven-plugin:3.9.0.2155:sonar'
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