FROM python:3.12.4-bookworm

ARG BUILD_ENV_USERNAME
ARG BUILD_ENV_UID
ARG BUILD_ENV_GID 
ARG BUILD_ENV_GROUPNAME

ENV ENV_USERNAME=$BUILD_ENV_USERNAME
ENV ENV_USER_UID=$BUILD_ENV_UID
ENV ENV_USER_GID=$BUILD_ENV_GID 
ENV ENV_USER_GROUPNAME=$BUILD_ENV_GROUPNAME

ENV JUPYTER_TOKEN=podman

RUN apt-get update && apt-get -y install vim
RUN apt-get -y install unzip

RUN curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | bash
RUN apt-get update && apt-get install -y mariadb-server galera-4 mariadb-client libmariadb3 mariadb-backup mariadb-common
RUN apt-get install -y libmariadb-dev

WORKDIR /workdir

RUN echo groupadd --gid ${ENV_USER_GID} ${ENV_USERNAME}
RUN groupadd --gid ${ENV_USER_GID} ${ENV_USERNAME}
RUN echo useradd --uid ${ENV_USER_UID} --gid ${ENV_USER_GID} -m ${ENV_USERNAME}
RUN useradd --uid ${ENV_USER_UID} --gid ${ENV_USER_GID} -m ${ENV_USERNAME}

RUN chown ${ENV_USER_UID}:${ENV_USER_GID} /workdir

RUN mkdir /env
RUN chown ${ENV_USER_UID}:${ENV_USER_GID} /env

RUN mkdir /notebooks
RUN chown ${ENV_USER_UID}:${ENV_USER_GID} /notebooks


#USER ${ENV_USER}
USER ${ENV_USER_UID}:${ENV_USER_GID}

ENV VIRTUAL_ENV=/env
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN /env/bin/python3 -m pip install --upgrade pip
RUN . /env/bin/activate
RUN /env/bin/python3 --version
RUN whereis python3
RUN whereis pip3

COPY requirements.txt /env/requirements.txt
RUN /env/bin/pip3 install -r /env/requirements.txt

RUN /env/bin/pip3 freeze
#COPY . /workdir/.
##RUN ls -R /workdir/

EXPOSE 8888

CMD ["jupyter", "notebook", "--notebook-dir=/notebooks",  "--port=8888", "--no-browser", "--ip=0.0.0.0"]

