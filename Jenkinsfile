pipeline {
    agent { label 'docker' }

    options {
        buildDiscarder(logRotator(numToKeepStr: '1', daysToKeepStr: '1'))
        ansiColor('xterm')
        timestamps()
        timeout(time: 2, unit: 'HOURS')
    }

tool name: 'docker-latest', type: 'org.jenkinsci.plugins.docker.commons.tools.DockerTool'

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

                       withDockerRegistry([ credentialsId: "nexus-cloud", url: "http://10.0.0.5/" ]) {

                         script {
                                    def customImage = docker.build("gitbox:${env.BUILD_ID}")
                                    customImage.push()
                                }
                       }
                }
            }
        }
    }

    post {

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
