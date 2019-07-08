# LearningDocker
- script file
	- HTML Report
	- crawl csv

- Usage
	- docker pull dangle316/learningdocker
	- docker run --name test -it dangle316/learningdocker
	- /csvParserBasic.sh
	- /csvParser.sh
	- /csvParserFull.sh


- helpful commands
	- PS: docker images -q | foreach {docker rmi $_}
	- PS: docker ps -a -q | foreach {docker rm $_}
	- SH: /csvParserFull.sh -f | tee test.txt
	- docker cp test:/test.txt test.txt

- links
	- https://guides.codechewing.com/bash/reuse-html-template-bash
	- https://app.pluralsight.com/library/courses/integrating-docker-with-devops-automated-workflows/table-of-contents
	- https://app.pluralsight.com/library/courses/docker-images-containers-aspdotnet-core/table-of-contents
