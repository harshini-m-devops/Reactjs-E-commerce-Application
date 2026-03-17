pipeline {
    agent any

    environment {
        DOCKER_USER = "harshinimdocker"
        DEV_REPO = "devops-app-dev"
        PROD_REPO = "devops-app-prod"
        IMAGE_NAME = "devops-app"
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
                    }

                    withCredentials([usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )]) {

                        sh """
                        echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin
                        docker tag $IMAGE_NAME \$DOCKER_USER/\$repo:latest
                        docker push \$DOCKER_USER/\$repo:latest
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
}
