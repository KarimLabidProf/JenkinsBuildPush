def pipelineContext = [:]

node {
     def registry = 'registry.gitlab.com'
    def registryProjet = 'registry.gitlab.com/mygroup4574346/myreg'
    def IMAGE = "${registryProjet}:version-${env.BUILD_ID}"
    def CONTAINER_NAME = "myapp-${env.BUILD_ID}"
    def img

    stage('Clone') {
        checkout scm
    }

    stage('Build') {
        img = docker.build("${IMAGE}", '.')
    }

    stage('Run Container') {
        // Lance le conteneur en arrière-plan
        bat "docker run -d --name ${CONTAINER_NAME} -p 83:80 ${IMAGE}"

        // Optionnel : attends que le conteneur soit prêt
        bat 'timeout /t 5 > nul'

        // Test simple avec curl
        bat 'curl http://localhost:83'

        // Tu peux ici ajouter d'autres tests HTTP, intégration, etc.
    }

    stage('Push to Registry') {
        docker.withRegistry('https://registry.gitlab.com', 'gitlab-registry-creds') {
            img.push('latest')
            img.push()
        }
    }

    stage('Clean Up') {
        // Arrête et supprime le conteneur
        bat "docker rm -f ${CONTAINER_NAME}"
    }
}
