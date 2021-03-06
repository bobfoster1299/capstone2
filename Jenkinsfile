pipeline {
  agent any
  environment {
    DOCKER_IMAGE_NAME = "bobfoster1299/capstone2-${BRANCH_NAME}"
  }
  stages {
    stage('Lint HTML') {
      steps {
        script {
          sh 'tidy -q -e public-html/*.html'
        }
      }     
    }
    stage('Build Docker Image') {
      steps {
        script {
          app = docker.build(DOCKER_IMAGE_NAME)
        }
      }     
    }
    stage('Push Docker Image') {
      steps {
        script {
          docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
          }
        }
      }
    }
    stage('Deploy to Kubernetes') {
      steps {
        script {
          if (env.BRANCH_NAME == 'production') {
            env.NODE_PORT = '30001'
          }
          else if (env.BRANCH_NAME == 'staging') {
            env.NODE_PORT = '30002'
          }
        }
        input "Deploy to ${BRANCH_NAME}?"
        kubernetesDeploy(
          kubeconfigId: 'kubeconfig',
          configs: 'capstone-kube.yml',
          enableConfigSubstitution: true
        )
      }
    }
  }
}