IMAGE_NAME=local/perl-power-outlet
CONTAINER_NAME=perl-power-outlet

all:

build:	Dockerfile index.html  power-outlet.ini
	docker build --rm --tag=$(IMAGE_NAME) .

rebuild: build rm run
	@echo -n

run_no_mount:
	docker run --privileged --detach --name $(CONTAINER_NAME) --publish 5028:80 -v /sys/fs/cgroup:/sys/fs/cgroup $(IMAGE_NAME)

run:
	docker run --privileged --detach --name $(CONTAINER_NAME) --publish 5028:80 -v /sys/fs/cgroup:/sys/fs/cgroup -v /etc/power-outlet.ini:/etc/power-outlet.ini $(IMAGE_NAME)

stop:
	docker stop $(CONTAINER_NAME)

rm:	stop
	docker rm $(CONTAINER_NAME)

bash:
	docker exec -it $(CONTAINER_NAME) /bin/bash

firewall:
	sudo firewall-cmd --zone=public --permanent --add-port=5028/tcp
	sudo firewall-cmd --reload

