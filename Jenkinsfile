pipeline {
  agent any
  stages {
    stage('Build Docker Image') {
      steps {
        script {
          app = docker.build("bobfoster1299/capstone2")
          app.inside {
            sh 'echo $(curl localhost:8080)'
          }
        }
      }
    }
  }
}