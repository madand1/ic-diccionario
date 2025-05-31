pipeline {
    agent {
        docker {
            image 'debian'
            args '-u root:root'
        }
    }
    stages {
        stage('Clone') {
            steps {
                git branch: 'master', url: 'https://github.com/madand1/ic-diccionario.git'
            }
        }

        stage('Install') {
            steps {
                sh 'apt-get update && apt-get install -y aspell aspell-es'
            }
        }

        stage('Test') {
            steps {
                sh '''
                    export LC_ALL=C.UTF-8
                    OUTPUT=$(cat doc/*.md | aspell list -d es -p ./.aspell.es.pws)
                    if [ -n "$OUTPUT" ]; then
                        echo "Se han encontrado errores ortográficos:"
                        echo "$OUTPUT"
                        exit 1
                    else
                        echo "Sin errores ortográficos."
                    fi
                '''
            }
        }
    }

    post {
        always {
            mail to: 'asirandyglez@gmail.com',
            subject: "Estado del pipeline: ${currentBuild.fullDisplayName}",
            body: "${env.BUILD_URL} ha finalizado con resultado: ${currentBuild.result}"
        }
    }
}
