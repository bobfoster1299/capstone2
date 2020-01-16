pipeline {
  agent any
  environment {
    DOCKER_IMAGE_NAME = "bobfoster1299/capstone2-${BRANCH-NAME}"
  }
  stages {
    stage('Check env variable') {
      steps {
        echo "${BRANCH_NAME}"
      }
    }     
    stage('Build Docker Image') {
      #when {
      #  branch 'master'
      #}
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
    stage('Deploy to Kubernetes') {
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