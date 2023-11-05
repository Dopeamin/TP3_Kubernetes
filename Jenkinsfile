pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "tp_kubernetes"
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
                    def imageNameWithTag = "$DOCKER_IMAGE:latest"
                    docker.build(imageNameWithTag)
                }
            }
        }
        
        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-account', passwordVariable: 'DOCKERHUB_PASS', usernameVariable: 'DOCKERHUB_USER')]) {
                    script {
                        sh 'echo $DOCKERHUB_PASS | docker login --username $DOCKERHUB_USER --password-stdin'
                        sh "docker push dopeamin/$DOCKER_IMAGE:latest"
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
