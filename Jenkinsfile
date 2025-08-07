pipeline {
  agent any

  environment {
    PROJECT_ID = 'vertex-ai-projects-466609'
    LOCATION = 'global'
    AGENT_ID = 'e7ac4047-d940-49c3-9446-924d1050c5f2'
    GOOGLE_APPLICATION_CREDENTIALS = '/var/lib/jenkins/keys/vertex-ai-projects-466609-24103519ea18.json'
  }

  stages {
    stage('Checkout') {
      steps {
        checkout([$class: 'GitSCM',
                  branches: [[name: 'refs/heads/testing']],
                  userRemoteConfigs: [[
                    url: 'git@github.com:farahc123/gcp-update-ai-agent-cicd.git',
                    credentialsId: 'farah-github-key'
                  ]]
                ])
      }
    }

    stage('Merge Testing into Main') {
      steps {
        sshagent(['farah-github-key']) {
          sh '''
            git config user.email "jenkins@example.com"
            git config user.name "Jenkins CICD"

            git fetch origin
            git checkout main
            git pull origin main

            git merge origin/testing --no-ff -m "Merge testing branch into main [automated]"

            git push origin main
          '''
        }
      }
    }

    stage('Setup Python Environment') {
      steps {
        sh '''#!/bin/bash
          python3 -m venv venv
          source venv/bin/activate
          pip install -r requirements.txt
        '''
      }
    }

    stage('Deploy Dialogflow Agent') {
      steps {
        sh '''#!/bin/bash
          source venv/bin/activate
          python deploy_agent.py \
            --project=$PROJECT_ID \
            --location=$LOCATION \
            --agent_id=$AGENT_ID \
            --json_dir=.
        '''
      }
    }
  }
}
