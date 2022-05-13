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
