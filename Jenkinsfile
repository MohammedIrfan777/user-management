pipeline {
    environment {
        REGISTRY_NAME = "khazi123/ecausermgmt"
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
                    git branch: 'main', url: 'https://github.com/vishabsingh09/eca-usermgmt.git '
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
                withDockerRegistry(credentialsId: 'DOCKER_HUB_USER_PS', url: '') {
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
