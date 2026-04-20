@Library("Shared") _
pipeline{
     agent any
     
     tools{
         jdk 'jdk17'
         nodejs 'node16'
     }
     environment {
         SCANNER_HOME=tool 'sonarqube-scanner'
     }
     
     stages {
         stage('Clean Workspace'){
             steps{
                 cleanWs()
             }
         }
         stage('Checkout from Git'){
             steps{
                 git branch: 'main', url: 'https://github.com/Kumar-Devansh/Swiggy-Clone-Deployment.git'
             }
         }
         stage("Sonarqube Analysis "){
             steps{
                 dir('a-swiggy-clone') {
                     withSonarQubeEnv('SonarQube-Server') {
                     sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=Swiggy-CI \
                     -Dsonar.projectKey=Swiggy-CI '''
                    }
                 }
            }
                 
         }
         stage("Quality Gate"){
            steps {
                 script {
                     waitForQualityGate abortPipeline: false, credentialsId: 'SonarQube-Token' 
                 }
             } 
         }
         stage('Install Dependencies') {
             steps {
                 dir('a-swiggy-clone'){
                     sh "npm install"
                 }
             }
         }
         stage('TRIVY FS SCAN') {
             steps {
                 sh 'trivy image devansh0111/swiggy-clone:latest > trivyimage.txt'
             }
         }
         stage("Docker Build") {
             steps {
                 dir('a-swiggy-clone'){
                     sh "docker build -t swiggy-clone:latest ."
                 }
            }
        }
          stage("Push to Docker Hub"){
            steps{
                withCredentials([usernamePassword(
                    credentialsId: "docker-hub-cred",
                    passwordVariable: "DockerHubPass",
                    usernameVariable: "DockerHubUser"
                    )]){
                        
                        sh "docker login -u ${env.DockerHubUser} -p ${env.DockerHubPass}"
                        sh "docker image tag swiggy-clone:latest ${env.DockerHubUser}/swiggy-clone:latest"
                        sh "docker push ${env.DockerHubUser}/swiggy-clone:latest "
                }
            }
        }
         stage("TRIVY"){
             steps{
                 sh "trivy image devansh0111/swiggy-clone:latest > trivyimage.txt" 
             }
         }
          stage('Deploy to Kubernets'){
             steps{
                 script{
                     dir('a-swiggy-clone/Kubernetes') {
                         kubeconfig(credentialsId: 'kubernetes') {
                         sh 'kubectl delete --all pods'
                         sh 'kubectl apply -f deployment.yml'
                         sh 'kubectl apply -f service.yml'
                         }   
                     }
                 }
             }
         }



     }
 }