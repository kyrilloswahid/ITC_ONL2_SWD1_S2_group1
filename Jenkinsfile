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
                sh 'docker compose up -d'
            }
        }
    }

    post {
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}

