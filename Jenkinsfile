pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "manasadevi09/trend-app"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Docker Build & Push') {
            steps {
                withDockerRegistry(
                  [credentialsId: 'dockerhub-creds', url: 'https://index.docker.io/v1/']
                ) {
                    sh '''
                      docker build -t manasadevi09/trend-app:latest .
                      docker push manasadevi09/trend-app:latest
                    '''
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
                    '''
                }
            }
        }
    }
}
