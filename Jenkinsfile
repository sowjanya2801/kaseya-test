pipeline {
  agent any
    stages {
        stage('Build Parameters') {
            steps {
                script {
                    properties([
                        parameters([
                            string(
                                defaultValue: '',
                                name: 'ansibleuser',
                                trim: true
                            ),
                            string(
                                defaultValue: '',
                                name: 'password',
                                trim: true
                            ),
                            string(
                                defaultValue: '',
                                name: 'windowshost',
                                trim: true
                            )
                        ])
                    ])
                }
            }
        }
        stage ('Add host to inventory') {
            steps {
              sh 'echo ${windowshost} >> inv'
            }
        }
        stage ('Windows Server Update via ansible') {
            steps {
            ansiblePlaybook(installation: "ansible2.8.6",
									inventory: "inv",
									playbook: "main.yaml",
									extraVars: [
									       ansible_user: [value: "${ansibleuser}", hidden: false],
                         ansible_password: [value: "${password}", hidden: true],
                         ansible_port: [value: 5986, hidden: false],
                         ansible_connection: [value: "winrm", hidden: false],
                         ansible_winrm_server_cert_validation: [value: "ignore", hidden: false]
									],
									colorized: true)
            }
        }

    }
 }
