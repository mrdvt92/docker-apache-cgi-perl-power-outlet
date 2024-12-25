IMAGE_NAME=local/apache-cgi-perl-power-outlet
CONTAINER_NAME=perl-power-outlet
PORT=5028

all:

build:	Dockerfile index.html  power-outlet.ini
	docker build --rm --tag=$(IMAGE_NAME) .

rebuild: build rm run
	@echo -n

run_no_mount:
	docker run --detach --restart=unless-stopped --name $(CONTAINER_NAME) --publish $(PORT):80 $(IMAGE_NAME)

run:
	docker run --detach --restart=unless-stopped --name $(CONTAINER_NAME) --publish $(PORT):80 -v /etc/power-outlet.ini:/etc/power-outlet.ini $(IMAGE_NAME)

stop:
	docker stop $(CONTAINER_NAME)

rm:	stop
	docker rm $(CONTAINER_NAME)

bash:
	docker exec -it $(CONTAINER_NAME) /bin/bash && true

firewall:
	sudo firewall-cmd --zone=public --permanent --add-port=$(PORT)/tcp
	sudo firewall-cmd --reload
