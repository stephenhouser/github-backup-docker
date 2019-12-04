# Node-RED Dockerfile modified to add custom modules
FROM python:3-alpine
LABEL maintainer "Stephen Houser - https://github.com/stephenhouser"

RUN apk update && apk add openssl git \
  && apk add --update --virtual build-dependencies curl \
  && curl -sLO https://github.com/git-lfs/git-lfs/releases/download/v2.5.1/git-lfs-linux-amd64-v2.5.1.tar.gz \
  && tar xf git-lfs-linux-amd64-v2.5.1.tar.gz  && mv git-lfs /usr/bin/ \
  && rm -Rf git-lfs git-lfs-linux-amd64-v2.5.1.tar.gz

COPY requirements.txt /
RUN pip install --no-cache-dir -r requirements.txt

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENV GITHUB_USER=
ENV GITHUB_TOKEN=
ENV GITHUB_BACKUP_USER=
VOLUME /backup

WORKDIR /backup
CMD ["/entrypoint.sh"]
# At 2am every day
#RUN echo '* 2 * * * /entrypoint.sh' > /etc/crontabs/root
#CMD crond -l 2 -f
