# LearningDocker
- script file
	- check content csv
	- crawl csv


- commands
	- PS: docker images -q | foreach {docker rmi $_}
	- PS: docker ps -a -q | foreach {docker rm $_}
	- docker run -it --name test dangle316/learningdocker


- links
	- https://app.pluralsight.com/library/courses/integrating-docker-with-devops-automated-workflows/table-of-contents
	- https://app.pluralsight.com/library/courses/docker-images-containers-aspdotnet-core/table-of-contents
