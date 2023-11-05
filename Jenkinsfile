pipeline {
    agent any

    environment {
        DOCKER_IMAGE = ""
        DOCKERHUB_CREDENTIALS = credentials('docker_account')
        KUBECONFIG_CREDENTIALS = credentials('minikube-kubeconfig')
        PATH = "/usr/local/bin:$PATH"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Dopeamin/TP3_Kubernetes'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    DOCKER_IMAGE = docker.build('dopeamin/tp3')
                }
            }
        }
        
        stage('Push to DockerHub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', DOCKERHUB_CREDENTIALS) {
                        DOCKER_IMAGE.push()
                    }
                }
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withCredentials([file(credentialsId: KUBECONFIG_CREDENTIALS, variable: 'KUBECONFIG')]) {
                        sh 'kubectl apply -f k8s/deployment.yaml'
                        sh 'kubectl apply -f k8s/service.yaml'
                    }
                }
            }
        }
    }
}
