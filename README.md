# Pipeline CI/CD — GitHub, Maven, Jenkins, Artifactory, SonarQube, Docker, Tomcat
## _Manual for CI/CD Pipeline Deployment_

**Application:** Spring Boot Hello World

### Tools Used

- **GitHub** — Source Code Management
- **Maven** — Build Tool
- **Jenkins** — Continuous Integration (CI/CD)
- **JFrog Artifactory** — Artifact Repository Manager
- **SonarQube** — Code Quality and Code Analysis
- **Docker**— Container Engine
- **Tomcat** — Application Server

![Architecture Diagram](https://training-materials-bloomy360.s3.us-east-2.amazonaws.com/images/cicdarch.png "Architecture")

### Pre-requisites:

- Tools like Jenkins, Artifactory, SonarQube Server is installed and the server is up and running
- Jenkins CI/CD — JFrog Artifactory Jenkins Integration
- Jenkins CI/CD — SonarQube Jenkins Integration
- Please make sure the following Jenkins Plugins are installed for this lab setup in the Jenkins Server ---- **Pipeline**, **Artifactory**,         **SonarQube Scanner for Jenkins**, **Email Extension Plugin.**

## Lab Setup :

### Jenkins CI/CD — JFrog Artifactory Jenkins Integration
  Pre-requisites:
    Jenkins and Artifactory Server is installed and the server is up and running
    
- Install the Artifactory Plugin in Jenkins
    Manage Jenkins → Manage Plugins → Click on the Available tab and search for the ‘Artifactory Plugin’ → Click on ‘Download now and install after restart

    ![Artifactory Plugin](https://training-materials-bloomy360.s3.us-east-2.amazonaws.com/images/artifactoryplugin.png "Artifactory")
    
- Go to Jenkins Home Page, Click on Manage Jenkins → Configure System  → Search for the JFrog Section.
 
    ![JFrog Artifactory Plugin](https://training-materials-bloomy360.s3.us-east-2.amazonaws.com/images/jfrog.png "JFrog Artifactory")

    Fill the Server ID : ```artifactory``` ( It can be any logical name )
    Place your JFrog Platform URL in the URL: ```http://jfrog.doriginlabs.com:8082```
    Under ```Default Deployer Credentials``` add the Username and Password and click on the ```Test Connection``` Button.
    If the provided URL, username and password is correct, after clicking on the Test Connection, A message is displayed as shown ```Found Artifactory 7.38.7```

    ![JFrog DashBoard](https://training-materials-bloomy360.s3.us-east-2.amazonaws.com/images/jfrogdash.png "JFrog DashBoard")
    
### Jenkins CI/CD — SonarQube Jenkins Integration

Pre-requisites:

Jenkins and SonarQube Server is installed and the server is up and running

-  Install the SonarQube Scanner for Jenkins in Jenkins
    Manage Jenkins → Manage Plugins → Click on the Available tab and search for the ‘SonarQube Scanner for Jenkins’ → Click on ‘Download now and install after restart’

    ![sonar scanner plugin](https://training-materials-bloomy360.s3.us-east-2.amazonaws.com/images/sonar.png "sonar scanner plugin")
- Go to SonarQube Home Page, Click on Administration → Under Security drop down click on Users
    
    ![sonarqube admin](https://training-materials-bloomy360.s3.us-east-2.amazonaws.com/images/sonar+dash.png "sonarqube admin")

- In the administrator user, Click on the Token Section ( marked below)

    ![sonarqube token](https://training-materials-bloomy360.s3.us-east-2.amazonaws.com/images/sonar+token.png "sonarqube token")
    
- After clicking, a window will pop up like the below.

    Enter the Token name as Jenkins-Sonar ( It can be any logical name ) and click on the Generate Button. Copy the token in the notepad and click on the done button
    
    ![sonarqube token](https://training-materials-bloomy360.s3.us-east-2.amazonaws.com/images/token.png "sonarqube token")

- Go to Jenkins Home Page, Click on the Credentials and add the generated token from the SonarQube.

    ![sonarqube credentials](https://training-materials-bloomy360.s3.us-east-2.amazonaws.com/images/jenkins+cred.png "sonarqube credentials")
    
- Go to Jenkins Home Page, Click on Manage Jenkins → Configure System → Search for the SonarQube Section.
 
    ![sonarqube credentials](https://training-materials-bloomy360.s3.us-east-2.amazonaws.com/images/sonarauth.png "sonarqube credentials")

- Fill the Name: ```sonar```( It can be any logical name )
    Place your sonar URL in the Server URL: ```http://sonarqube.doriginlabs.com:9000```
    In Server authentication token, select the recently added secret text of the generated token from the ```SonarQube``` ( Step 4 ) and click on the save button.

### Creation of the Jenkins Job --- Pipeline Project

   ![Jenkins Pipeline](https://training-materials-bloomy360.s3.us-east-2.amazonaws.com/images/pipeline+project.png "Jenkins Pipeline")
   
  - Go to Pipeline Section, Select the Git Repository and save the job
  **GitHub URL:** https://github.com/dorigintech/CI-CD-Demo.git
  **Branch:** main

    ![Git Pipe](https://training-materials-bloomy360.s3.us-east-2.amazonaws.com/images/gitpipe.png "Git Pipe")
    
- Clicking on the build to trigger the Job.
- Please find the Output Below.
    > Jenkins Console Output Log is attached for your reference:

    ![Tomcat output](https://training-materials-bloomy360.s3.us-east-2.amazonaws.com/images/output.png "Tomcat output")
    
- To check the code is deployed correctly, Please follow the below URL Pattern:

    **http://jenkins.doriginlabs.com:8050/helloworld-0.0.1-SNAPSHOT/hello**
    
- Jenkins Pipeline Stages Screenshot:

    ![Pipeline output](https://training-materials-bloomy360.s3.us-east-2.amazonaws.com/images/pipeline+output.png "Pipeline output")
    
### Breaking the Code:


![Pipeline output](https://training-materials-bloomy360.s3.us-east-2.amazonaws.com/images/pipelinecode.png "Pipeline output")

- In the above Screenshot **Fig.1**

- Defined the maven and Artifactory methods globally in Jenkins File
- Set the tools name of Java and Maven location as mentioned in the Jenkins — Global Tool Configuration ( Refer Screenshot          **Fig.2**) below.

    ![jdk path](https://training-materials-bloomy360.s3.us-east-2.amazonaws.com/images/jdkpath.png "jdk payj")
    ![sonar path](https://training-materials-bloomy360.s3.us-east-2.amazonaws.com/images/sonarpath.png "sonar path")
    ![maven path](https://training-materials-bloomy360.s3.us-east-2.amazonaws.com/images/mavenpath.png "maven path")
    
- Included the options to have the timestamps and log rotation of the builds.
- Set the Environment of SonarQube scanner tool name as mentioned in the Jenkins — Global Tool Configuration ( Refer Screenshot Fig.2) above.
    
    ```sh
    stages {
    stage('Artifactory_Configuration') {
      steps {
        script {
		  rtMaven.tool = 'Maven'
		  rtMaven.resolver releaseRepo: 'libs-release', snapshotRepo: 'libs-snapshot', server: server
		  buildInfo = Artifactory.newBuildInfo()
		  rtMaven.deployer releaseRepo: 'libs-release-local', snapshotRepo: 'libs-snapshot', server: server
          buildInfo.env.capture = true
        }			                      
      }
    }
    stage('Execute_Maven') {
	  steps {
	    script {
		  rtMaven.run pom: 'pom.xml', goals: 'clean install', buildInfo: buildInfo
        }			                      
      }
    }	
    stage('SonarQube_Analysis') {
      steps {
	    script {
          scannerHome = tool 'sonar-scanner'
        }
        withSonarQubeEnv('sonar') {
      	  sh """${scannerHome}/bin/sonar-scanner"""
        }
      }	
    }	
	stage('Quality_Gate') {
	  steps {
	    timeout(time: 1, unit: 'MINUTES') {
		  waitForQualityGate abortPipeline: true
        }
      }
    }
    ```
    
- In the above code explains the Artifactory, SonarQube Analysis, SonarQube Quality gate Stage.
    >Note: “ Quality Gate” stage is written in the Jenkins File to make the Jenkins build fail if the Sonar Quality Gate metrics is not met.

    ![docker delete](https://training-materials-bloomy360.s3.us-east-2.amazonaws.com/images/dockerdeletecode.png "docker delete")    
    
- **“Deleting docker images and Containers”** stage is written to make sure if any docker images and containers are running to be removed before the actual build happens.
    > Note: In screenshot Fig.4 the mentioned “delete_cont.sh” shell script is found below.

    ```sh
    
    
    ![docker build](https://training-materials-bloomy360.s3.us-east-2.amazonaws.com/images/build+docker.png "docker build") 
    
- In the Screenshot above **Fig.5** explains the below:
    Building the Docker Image
    Docker login to perform the pushing of the build image to the Dockerhub
    Running the Docker Container of tomcat to port 8050
    > Note: Dockerfile is found here.

    ![docker build](https://training-materials-bloomy360.s3.us-east-2.amazonaws.com/images/dockerfile.png "docker build")
    
- In the above Screenshot **Fig.6**, changed the **RUN** command to startup the tomcat server with the Port 8050 ( Default port is 8080)

    ```sh post {
        always {
    		mail bcc: '', body: "<br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br>URL: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "Success: Project name -> ${env.JOB_NAME}", to: "sudhan@thrivetech.in";
        }
        failure {
    sh 'echo "This will run only if failed"'
          mail bcc: '', body: "<br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br>URL: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "ERROR: Project name -> ${env.JOB_NAME}", to: "sudhan@thrivetech.in";
        }
      }
    }
    ```
    
    
- Defines one or more additional steps that are run upon the completion of a Pipeline’s or stage’s run
- Triggers the mail based up on the Success or Failure of the Build
    
    ![success](https://training-materials-bloomy360.s3.us-east-2.amazonaws.com/images/success.png "success")
    
    Hope you have enjoyed setting up the Pipeline 😊
    
