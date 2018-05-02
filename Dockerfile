FROM golang:1.10-alpine3.7

ENV DEP_VERSION=v0.4.1
ENV DOCKER_VERSION=17.03.1

RUN apk add --update git make bash curl unzip tar && \
		curl -fsSL -o /usr/bin/dep https://github.com/golang/dep/releases/download/${DEP_VERSION}/dep-linux-amd64 && \
		chmod +x /usr/bin/dep && \ 
	    rm -rf /var/cache/apk/*

RUN curl -Lo /tmp/docker.tgz https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}-ce.tgz && \
    tar --extract --file /tmp/docker.tgz --strip-components 1 --directory /usr/local/bin/ 		

WORKDIR $GOPATH/src/github.com/operator-framework/
RUN git clone https://github.com/operator-framework/operator-sdk.git && \
	cd operator-sdk && \
	git checkout tags/v0.0.5 && \
	dep ensure && \
	go install github.com/operator-framework/operator-sdk/commands/operator-sdk
