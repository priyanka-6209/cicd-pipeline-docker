pipeline {
    agent any
    stages {
	stage('Initialize'){
        def dockerHome = tool 'docker'
        env.PATH = "${dockerHome}/bin:${env.PATH}"
    	}
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
	    app=docker.build("DOCKERHUB-ID/node-app")
	    app.inside{
	      sh 'echo $(curl localhost:8080)'
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
	   docker.withregistry('https://registry.hub.docker.com','DOCKERHUB-ID'){
	      app.push("${env.BUILD_NUMBER}")
	      app.push("latest")
	   }
      }
      }
   }
    }
}
