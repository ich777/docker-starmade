FROM ich777/debian-baseimage

LABEL maintainer="admin@minenet.at"

ENV DATA_DIR="/starmade"
ENV RUNTIME_NAME="basicjre"
ENV JAR_NAME="template"
ENV DL_URL="http://files.star-made.org/StarMade-Starter.jar"
ENV GAME_PARAMS=""
ENV EXTRA_JVM_PARAMS=""
ENV UMASK=000
ENV UID=99
ENV GID=100
ENV USER="starmade"
ENV DATA_PERM=770

RUN mkdir $DATA_DIR && \
	useradd -d $DATA_DIR -s /bin/bash $USER && \
	chown -R $USER $DATA_DIR && \
	ulimit -n 2048

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/
COPY /server.cfg /tmp/server.cfg

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]