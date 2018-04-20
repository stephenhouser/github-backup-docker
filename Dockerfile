FROM alpine:3.2

ENV LFS_VERSION 1.0.2

RUN apk add --update git openssh
RUN apk add --update --virtual build-dependencies curl && \
	curl -sLO https://github.com/github/git-lfs/releases/download/v${LFS_VERSION}/git-lfs-linux-amd64-${LFS_VERSION}.tar.gz && \
	tar xzf /git-lfs-linux-amd64-${LFS_VERSION}.tar.gz -C / && \
	mv /git-lfs-${LFS_VERSION}/git-lfs /usr/local/bin/ && \
	git-lfs init && \
	apk del build-dependencies && \
	rm -rf /git-lfs-${LFS_VERSION} && \
	rm -rf /git-lfs-linux-amd64-${LFS_VERSION}.tar.gz && \
	rm -rf /var/cache/apk/*

RUN echo "IdentityFile /data/private-key" >> /etc/ssh/ssh_config && \
	echo -e "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

COPY git-fetch-all.sh /

VOLUME [ "/data" ]

CMD ["/git-fetch-all.sh", "-vc", "/data"]
#CMD ["/bin/sh"]