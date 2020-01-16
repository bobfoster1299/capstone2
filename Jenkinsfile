pipeline {
  agent any
  environment {
    DOCKER_IMAGE_NAME = "bobfoster1299/capstone2-${BRANCH_NAME}"
  }
  stages {
    stage('Check env variable') {
      steps {
        echo "${BRANCH_NAME}"
      }
    }     
    stage('Build Docker Image') {
      steps {
        script {
          app = docker.build(DOCKER_IMAGE_NAME)
          app.inside {
            sh 'echo $(curl localhost:80)'
          }
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
          if (env.BRANCH_NAME == 'master') {
            NODE_PORT = '30001'
          } else {
          NODE_PORT = '30002'
          }
        }
        input "Deploy to ${BRANCH_NAME}???"
        kubernetesDeploy(
          kubeconfigId: 'kubeconfig',
          configs: 'capstone-kube.yml',
          enableConfigSubstitution: true
        )
      }
    }
  }
}