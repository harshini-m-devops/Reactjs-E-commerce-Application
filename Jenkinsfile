pipeline {
    agent any

    environment {
        DOCKER_USER = "harshinimdocker"
        IMAGE_NAME = "devops-app"
        DEV_REPO = "devops-app-dev"
        PROD_REPO = "devops-app-prod"
    }

    stages {

        stage('Build Image') {
            steps {
                sh 'chmod +x build.sh'
                sh './build.sh'
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {

                    def repo = ""

                    if (env.BRANCH_NAME == "dev") {
                        repo = DEV_REPO
                    } else if (env.BRANCH_NAME == "main") {
                        repo = PROD_REPO
                    } else {
                        repo = DEV_REPO
                    }

                    echo "Branch: ${env.BRANCH_NAME}"
                    echo "Using repo: ${repo}"

                    withCredentials([usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )]) {

                        sh """
                        echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin
                        docker tag ${IMAGE_NAME} \$DOCKER_USER/${repo}:latest
                        docker push \$DOCKER_USER/${repo}:latest
                        """
                    }
                }
            }
        }

        stage('Deploy') {
            when {
                branch 'dev'
            }
            steps {
                sh 'chmod +x deploy.sh'
                sh './deploy.sh'
            }
        }
    }

    post {
        success {
            echo "Pipeline executed successfully " 
        }
        failure {
            echo "Pipeline failed " 
        }
    }
}
