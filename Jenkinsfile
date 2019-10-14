#!groovy
import groovy.json.JsonOutput

//slack env vars
env.slack_url = 'https://hooks.slack.com/services/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'
env.notification_channel = 'terra-test'


def notifySlack(text, channel, attachments) {
    def payload = JsonOutput.toJson([text: text,
        channel: channel,
        username: "Jenkins",
        attachments: attachments
    ])
    sh "curl -X POST --data-urlencode \'payload=${payload}\' ${slack_url}"
}

pipeline {
    agent {
        node {
            label 'master'
        }
    }
    triggers {
        pollSCM 'H/10 * * * *'
    }
    options {
        skipDefaultCheckout false
        buildDiscarder(logRotator(numToKeepStr: '20'))
    }
    stages {
    	stage("Plan") {
    		steps {
    			sh "terraform init"
    			sh "terraform plan"
    			input "Do you approve deployment?"

    		}
    	}
    }
    post {
        failure {
            echo "fail"
            //slackSend (color: 'danger', message: "@here maximilian3_${GIT_BRANCH} - Build #${BUILD_NUMBER} Failed. (<${env.BUILD_URL}|Open>)")
        }
        success {
            echo "good"
            //slackSend (color: 'good', message: "maximilian3_${GIT_BRANCH} - Build #${BUILD_NUMBER} Success. (<${env.BUILD_URL}|Open>)")
        }
        always {
            echo 'Updating folder permissions.'
            sh "chmod -R 777 ."
        }
        cleanup {
            echo 'Workspace cleanup.'
            deleteDir()
        }
    }
}