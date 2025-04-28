pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "todo-server"
        DOCKER_TAG = "ci-${env.BUILD_ID}"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                dir('todo-src') {
                    sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'
                }
            }
        }

        stage('Run Tests') {
            steps {
                dir('todo-src') {
                    sh 'npm install'
                    sh 'npm run lint:check'
                    sh 'npm audit'
                }
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                sh 'docker compose down'
                sh 'docker compose up --build -d'
            }
        }
    }

    post {
        success {
            sh '''
            curl -X POST -H 'Content-type: application/json' --data '{"text":"✅ Build Success: Job ${JOB_NAME} #${BUILD_NUMBER}!"}' https://hooks.slack.com/services/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
            '''
        }
        failure {
            sh '''
            curl -X POST -H 'Content-type: application/json' --data '{"text":"❌ Build Failed: Job ${JOB_NAME} #${BUILD_NUMBER}"}' https://hooks.slack.com/services/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
            '''
        }
    }
}

