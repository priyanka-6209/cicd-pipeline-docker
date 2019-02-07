pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Running build automation'
                sh './gradlew build --no-daemon'
                archiveArtifacts artifacts: 'dist/trainSchedule.zip'
            }
        }
        stage('Build Docker Image'){
	/*when {
	   branch 'master'
	}*/
	steps {
	  script{
	    app=docker.build("priyanka6209/node-app")
	    app.inside{
	      sh 'echo $(curl localhost:8081)'
	    }
	  }
	}
   }
   stage('Push Docker Image'){
      /*when{
	branch 'master'
      }*/
      steps{
	script{
	   docker.withRegistry('https://registry.hub.docker.com','priypri-dockerhub'){
	      app.push("${env.BUILD_NUMBER}")
	      app.push("latest")
	   }
      }
      }
   }
    stage('Deploy kubernetes'){
          steps {
		  sh 'kubectl delete -f application.yaml'
             kubernetesDeploy(
                kubeconfigId: 'kubeconfig',
                configs: 'application.yaml',
                enableConfigSubstitution: false)
                echo 'App url: http://54.186.233.130:30026'
          }
                     
        }
    }
}
