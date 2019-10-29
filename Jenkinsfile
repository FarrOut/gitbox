

/**
 * Execute the specified command in Maven.
 *
 * @param command to execute
 */
def MavenCommand(String command) {
    withMaven(maven: 'maven-3.6.1', jdk: 'jdk1.7.0_80',
            mavenLocalRepo: '.repository', options: [artifactsPublisher(disabled: true)]) {
        sh "mvn ${command}"
    }
}



pipeline {
    agent any

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
                    MavenCommand(install)
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    echo 'Deploying...(doesnt do anything yet)'

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
