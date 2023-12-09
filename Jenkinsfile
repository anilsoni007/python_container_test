pipeline {
    agent any
    stages {
        stage('checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/anilsoni007/python_container_test.git'
            }
        }
        stage('SQ_Analysis') {
            steps {
                script {
          scannerHome = tool 'SonarScanner';
                    
                    withSonarQubeEnv('sonar-server') {
                        // Run SonarQube analysis
                        sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=python-app"
            }
            }
            }
        }
        stage('BuildImage') {
            steps {
                script {
                    sh 'docker build -t asoni007/pycon:${BUILD_NUMBER} .'
                }
            }
        }
        stage(initiaize_and_test){
            steps {
                script {
                    sh 'docker container run --name pycon -itd -p 80:9090 asoni007/pycon:${BUILD_NUMBER} && sleep 15 && docker stop pycon  && docker rm pycon'
                }
            }
        }
        stage(Publish_and_Sanitize){
            steps {
                script {
                    withCredentials([string(credentialsId: 'Docker_hub_creds', variable: 'Docker_hub_creds')]) {
                  sh 'docker login -u asoni007 -p ${Docker_hub_creds}'
                  sh 'docker push asoni007/pycon:${BUILD_NUMBER} && docker rmi asoni007/pycon:${BUILD_NUMBER}'
                }
            }
        }
    }
}
}
