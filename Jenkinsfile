pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "todo-server"
        DOCKER_TAG = "ci-${env.BUILD_ID}"
        ANSIBLE_HOST_KEY_CHECKING = 'False'
    }

    stages {
        stage('Install Dependencies') {
            steps {
                dir('todo-src') {
                    sh 'npm ci'
                }
            }
        }

        stage('Run Lint & Security Checks in Parallel') {
            parallel {
                stage('Lint') {
                    steps {
                        dir('todo-src') {
                            sh 'npm run lint:check'
                        }
                    }
                }

                stage('Security Audit') {
                    steps {
                        dir('todo-src') {
                            sh 'npm audit'
                        }
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                dir('todo-src') {
                    sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'docker-hub-credentials',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker tag $DOCKER_IMAGE:$DOCKER_TAG $DOCKER_USER/$DOCKER_IMAGE:$DOCKER_TAG
                        docker push $DOCKER_USER/$DOCKER_IMAGE:$DOCKER_TAG
                    '''
                }
            }
        }

        stage('Deploy to EC2 via Ansible') {
            steps {
                withCredentials([
                    sshUserPrivateKey(
                        credentialsId: 'aws-keypair',
                        keyFileVariable: 'SSH_KEY',
                        usernameVariable: 'SSH_USER'
                    )
                ]) {
                    dir('ansible') {
                        sh '''
                            ansible-playbook -i inventory playbook.yml \
                            --user=$SSH_USER --private-key=$SSH_KEY
                        '''
                    }
                }
            }
        }

        stage('Deploy to Kubernetes Locally') {
            steps {
                script {
                    sh '''
                        kubectl apply -f k8s/
                        kubectl rollout status deployment/todo-server
                    '''
                }
            }
        }
    }

    post {
        success {
            withCredentials([string(credentialsId: 'slack-webhook', variable: 'SLACK_WEBHOOK')]) {
                sh """
                    curl -X POST -H 'Content-type: application/json' \
                    --data '{"text":"✅ Build Success: Job ${JOB_NAME} #${BUILD_NUMBER}"}' $SLACK_WEBHOOK
                """
            }
        }

        failure {
            withCredentials([string(credentialsId: 'slack-webhook', variable: 'SLACK_WEBHOOK')]) {
                sh """
                    curl -X POST -H 'Content-type: application/json' \
                    --data '{"text":"❌ Build Failed: Job ${JOB_NAME} #${BUILD_NUMBER}"}' $SLACK_WEBHOOK
                """
            }
        }
    }
}

