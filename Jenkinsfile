pipeline {
    agent any 
    stages {
        stage('Initialise input variables') { 
            steps {
				sh 'echo "Initialising environment"'
                sh 'echo URL to download is: ${URL}'
                sh 'echo ${URL} | rev | cut -d "/" -f 1 | rev > name.sh'
            }
        }
		stage('Cloning repo') { 
            steps {
				sh 'echo Cleaning previous repo'
				sh 'rm -rf MangaBank-DL-main'
				sh 'rm -f main.zip'
				sh 'echo Downloading previous repo'
				sh 'wget https://github.com/s1ddly/MangaBank-DL/archive/refs/heads/main.zip'
				sh 'unzip main.zip'
            }
        }
        stage('Download Manga') { 
            steps {
				sh 'pwd'
				sh '''
					cd ./MangaBank-DL-main/
					chmod -R 777 *
					name=$(cat ../name.sh)
					./chapt-get.sh ${URL}
					./renamer.sh $name
					./2pdf.sh $name
					./split.sh $name
					cd output/$name/pdfs
					zip -r $name.zip *.pdf
					
				'''
            }
        }
        stage('Provide link') { 
            steps {
                sh '''
					name=$(cat name.sh)
					echo ${BUILD_URL}execution/node/3/ws/MangaBank-DL-main/output/$name/pdfs/$name.zip
				'''
            }
        }
    }
}