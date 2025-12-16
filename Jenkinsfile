pipeline {
    agent any

    environment {
        APP_NAME        = "trend-app"
        DOCKER_IMAGE    = "manasadevi09/trend-app"
        DOCKER_TAG      = "latest"
        DOCKER_REGISTRY = "https://index.docker.io/v1/"
    }

    triggers {
        githubPush()
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Verify Workspace') {
            steps {
                sh 'ls -la'
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    withDockerRegistry(
                        [url: "${DOCKER_REGISTRY}", credentialsId: 'dockerhub-creds']
                    ) {
                        sh """
                          docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .
                          docker push ${DOCKER_IMAGE}:${DOCKER_TAG}
                        """
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([
                    file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')
                ]) {
                    sh '''
                      kubectl apply -f deployment.yml
                      kubectl apply -f service.yml
                      kubectl rollout status deployment/trend-app
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "✅ CI/CD Pipeline completed successfully!"
        }
        failure {
            echo "❌ Pipeline failed. Check logs."
        }
    }
}
