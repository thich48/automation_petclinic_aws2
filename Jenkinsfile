pipeline {
  agent any
  stages {
    stage('verify supported software') {
      steps {
        sh '''
         java -version
         docker version
        '''
      }
    }
 stage('Clean Docker remove all images and containers') {
      steps {
        echo 'Clean docker : remove all the images'
        sh 'docker system prune -a --volumes -f'
        sh 'docker ps -a'
      }
    }
    stage('Maven build + Build docker compose build') {
      steps {
        echo 'Build docker : using docker compose multiple microservices'
        sh './scripts/run_all.sh'
      }
    }

    stage('Run tests against the container') {
      steps {
        echo 'Test should be applied after the deployment on the different servers'
        sh 'docker-compose logs'
        echo 'Discovery Server - http://localhost:8761'
        sh 'curl -Is http://localhost:8761 | head -n 1'
        echo 'Config Server - http://localhost:8888'
        sh 'curl -Is http://localhost:8888 | head -n 1'
        echo 'AngularJS frontend (API Gateway) - http://localhost:8085'
        sh 'curl -Is http://localhost:8085 | head -n 1'
        echo 'Tracing Server (Zipkin) - http://localhost:9411/zipkin/'
        sh 'curl -Is http://localhost:9411/zipkin/ | head -n 1'
        echo 'Admin Server (Spring Boot Admin) - http://localhost:9090'
        sh 'curl -Is http://localhost:9090 | head -n 1'
        echo 'Grafana Dashboards - http://localhost:3000'
        sh 'curl -Is http://localhost:3000 | head -n 1'
        echo 'Prometheus - http://localhost:9091'
        sh 'curl -Is http://localhost:9091 | head -n 1'
      }
    }

    stage('Deploiement en dev') {
      environment {
        KUBECONFIG = credentials('config')
      }
      steps {
        script {
          echo 'Created only one docker compose to default for docker environment'
         
        }

      }
    }

  }
  environment {
    DOCKER_ID = 'abrarhm'
    DOCKER_IMAGE = 'springcommunity'
    DOCKER_TAG = "v.${BUILD_ID}.0" // we will tag our images with the current build in order to increment the value by 1 with each new build
  }
}
