pipeline {
    agent { dockerfile true }

    options {
        buildDiscarder(logRotator(numToKeepStr: '1', daysToKeepStr: '1'))
        ansiColor('xterm')
        timestamps()
        timeout(time: 2, unit: 'HOURS')
    }

    triggers {
        pollSCM 'H/30 * * * *'
    }

    stages {
        stage('Build') {
            steps {
                script {
                    echo 'Building...'



                }
            }
        }

        stage('publish') {
            steps {
                script {
                    echo 'Pushing to Nexus...'

                       withDockerRegistry([ credentialsId: "<CREDENTIALS_ID>", url: "<PRIVATE_REGISTRY_URL>" ]) {
                          // following commands will be executed within logged docker registry
                          sh 'docker push gitbox'
                       }
                }
            }
        }
    }

    post {
        success {

        }

        failure {


            emailext([subject           : '$DEFAULT_SUBJECT',
                      body              : '$DEFAULT_CONTENT',
                      recipientProviders: [
                              [$class: 'CulpritsRecipientProvider'],
                              [$class: 'DevelopersRecipientProvider'],
                              [$class: 'RequesterRecipientProvider']
                      ],
                      replyTo           : '$DEFAULT_REPLYTO',
                      to                : '$DEFAULT_RECIPIENTS'])
        }

        always {
            cleanWs()
        }

        changed {
            emailext([subject           : '$DEFAULT_SUBJECT',
                      body              : '$DEFAULT_CONTENT',
                      recipientProviders: [
                              [$class: 'CulpritsRecipientProvider'],
                              [$class: 'DevelopersRecipientProvider'],
                              [$class: 'RequesterRecipientProvider']
                      ],
                      replyTo           : '$DEFAULT_REPLYTO',
                      to                : '$DEFAULT_RECIPIENTS'])
        }
    }
}
