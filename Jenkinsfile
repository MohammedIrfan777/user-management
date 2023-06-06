pipeline {
    environment {
        REGISTRY_NAME = "khazi123/user-management"
     }

    agent any
    tools {
        maven "MAVEN_HOME"
    }
    stages {
        stage('Checkout') {
            steps {
                cleanWs()
                withCredentials([string(credentialsId: 'GITHUB_TOKEN_PS', variable: '')]) {
                    git branch: 'main', url: 'https://github.com/hackathone2023/user-management.git'
                }
            }
        }
        stage('Build') {
            steps {
                sh "mvn clean install -DskipTests"
            }
        }

         stage('Test & Code Coverage') {
            steps {
                sh "mvn -Dmaven.test.failure.ignore=true clean package"
            }
             post {
                success {
                     archiveArtifacts 'target/*.jar'
                     junit 'target/surefire-reports/*.xml'
                     jacoco execPattern: 'target/jacoco.exec'
                }
            }
        }

        stage('Building image') {
          steps{
            sh 'docker build -t $REGISTRY_NAME:$BUILD_NUMBER .'
          }
        }

        stage('Docker Build & Push') {
            steps {
                withDockerRegistry(credentialsId: 'DOCKER_HUB_USER_TOKEN', url: '') {
                    sh 'docker push $REGISTRY_NAME:$BUILD_NUMBER'
                }
            }
        }
    }

    post {
       always {
           deleteDir()
       }
   }
}
