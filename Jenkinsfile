pipeline {
    agent any

    stages {

        stage('Sanity Check') {
            steps {
                sh '''
                  echo "User:"
                  whoami
                  echo "Workspace:"
                  pwd
                  echo "Files:"
                  ls -la
                '''
            }
        }

        stage('Check Tools') {
            steps {
                sh '''
                  echo "Docker:"
                  docker --version || echo "Docker NOT found"
                  echo "Kubectl:"
                  kubectl version --client || echo "Kubectl NOT found"
                  echo "Node:"
                  node --version || echo "Node NOT found"
                  npm --version || echo "NPM NOT found"
                '''
            }
        }
    }

    post {
        always {
            echo "Pipeline finished (diagnostic run)"
        }
    }
}
