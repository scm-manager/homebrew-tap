#!/usr/bin/env groovy
pipeline {
    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
        disableConcurrentBuilds()
    }

    parameters {
        string(name: 'Version', defaultValue: '', description: 'SCM-Manager Version')
    }

    agent {
        node {
            label 'docker'
        }
    }

    stages {

        stage('Update formula') {
            when {
                branch 'master'
                expression {
                  params.Version.length() > 0
                }
            }
            agent {
                docker {
                    image 'groovy:3.0.9-jdk11'
                }
            }
            steps {
                sh "groovy build/update.groovy ${params.Version}"
            }
        }

        stage('Update Repository') {
            when {
                branch 'master'
                expression {
                  params.Version.length() > 0
                }
            }
            agent {
                node {
                    label 'docker'
                }
            }
            steps {
                sh 'git add Formula/scm-server.rb'
                commit "Update scm-server formula to version ${params.Version}"
                authGit 'cesmarvin-github', 'push origin'
            }
        }

        stage('Docker') {
            when {
                branch 'master'
                expression {
                  params.Version.length() > 0
                }
            }
            agent {
                node {
                    label 'docker'
                }
            }
            steps {
                script {
                    dir('website') {
                        git branch: 'master', changelog: false, credentialsId: 'cesmarvin', poll: false, url: 'https://github.com/scm-manager/website.git'
                        String releaseFile = "content/releases/${params.Version.replace('.', '-')}.yml"
                        def release = readYaml file: releaseFile
                        if (!containsReleasePackage(release, 'osx')) {
                            release.packages.add([type: 'osx'])
                            writeYaml file: releaseFile, data: release, overwrite: true
                            sh "git add ${releaseFile}"
                            commit "Add ces package to release ${params.Version}"
                            authGit 'cesmarvin', 'push origin master'
                        } else {
                            echo "release ${params.ScmVersion} contains ces package already"
                        }
                    }
                }
            }
        }
    }

    post {
        failure {
            mail to: 'scm-team@cloudogu.com',
            subject: "${JOB_NAME} - Build #${BUILD_NUMBER} - ${currentBuild.currentResult}!",
            body: "Check console output at ${BUILD_URL} to view the results."
        }
    }
}

void commit(String message) {
    sh "git -c user.name='CES Marvin' -c user.email='cesmarvin@cloudogu.com' commit -m '${message}'"
}

void authGit(String credentials, String command) {
    withCredentials([
    usernamePassword(credentialsId: credentials, usernameVariable: 'AUTH_USR', passwordVariable: 'AUTH_PSW')
  ]) {
        sh "git -c credential.helper=\"!f() { echo username='\$AUTH_USR'; echo password='\$AUTH_PSW'; }; f\" ${command}"
  }
}