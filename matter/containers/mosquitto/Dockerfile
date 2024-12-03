from eclipse-mosquitto:latest

ARG BUILD_ENV_USERNAME
ARG BUILD_ENV_UID
ARG BUILD_ENV_GID 
ARG BUILD_ENV_GROUPNAME

ENV ENV_USERNAME=$BUILD_ENV_USERNAME
ENV ENV_USER_UID=$BUILD_ENV_UID
ENV ENV_USER_GID=$BUILD_ENV_GID 
ENV ENV_USER_GROUPNAME=$BUILD_ENV_GROUPNAME

WORKDIR .

EXPOSE 1883:1883 8080:8080

#RUN cd /etc/mosquitto
#RUN echo "" > mosquitto.pwd
#RUN mosquitto_passwd -b mosquitto.pwd usertest passwordtest
#RUN echo "password_file /etc/mosquitto/mosquitto.pwd" >> mosquitto.conf
#RUN echo "allow_anonymous false" >> /etc/mosquitto/mosquitto.conf

COPY ./config/mosquitto.conf /etc/mosquitto/mosquitto.conf

CMD ["mosquitto", "-c", "/etc/mosquitto/mosquitto.conf"]
