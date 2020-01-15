pipeline {
  agent any
  environment {
    DOCKER_IMAGE_NAME = "bobfoster1299/capstone2"
  }
  stages {
    stage('Build Docker Image') {
      when {
        branch 'master'
      }
      steps {
        script {
          app = docker.build(DOCKER_IMAGE_NAME)
          app.inside {
            sh 'echo $(curl localhost:8080)'
          }
        }
      }
    }
    stage('Push Docker Image') {
      when {
        branch 'master'
      }
      steps {
        script {
          docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
          }
        }
      }
    }
    stage('Deploy to Staging') {
      when {
        branch 'staging'
      }
      steps {
        input 'Deploy to staging???'
        kubernetesDeploy(
          kubeconfigId: 'kubeconfig',
          configs: 'capstone-staging-kube.yml',
          enableConfigSubstitution: true
        )
      }
    }
    stage('Deploy to Production') {
      when {
        branch 'master'
      }
      steps {
        input 'Deploy to production???'
        kubernetesDeploy(
          kubeconfigId: 'kubeconfig',
          configs: 'capstone-kube.yml',
          enableConfigSubstitution: true
        )
      }
    }
  }
}