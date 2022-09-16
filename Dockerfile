FROM maven:3.8.4-openjdk-17-slim
LABEL maintainer "Eric Axley (solway01@gmail.com)"

RUN apt-get update && apt-get install -y --no-install-recommends \
        unzip \
        ruby \
        libffi7 \
        build-essential \
        ruby-full \
        libffi-dev && \
#    gem update --system && \
#    gem install compass && \
#    apt-get remove -y ruby-dev build-essential libffi-dev && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* 


ENV SENCHA_VERSION=4.0.5.87

ADD SenchaCmd-$SENCHA_VERSION-linux-x64.run.zip /cmd.run.zip

RUN unzip -p /cmd.run.zip > /cmd-install.run && \
    chmod +x /cmd-install.run && \
    /cmd-install.run --mode unattended --debuglevel 4 --prefix /opt && \
    install -dm777 -o root -g root /opt/Sencha/Cmd/repo && \
    rm /cmd-install.run /cmd.run.zip && \
    ln -s /opt/Sencha/Cmd/$SENCHA_VERSION/sencha /opt/Sencha/sencha 

ADD jre-8u202-linux-x64.tar.gz /opt
#RUN cd /opt && tar xzf jre-8u202-linux-x64.tar.gz
RUN sed -i -e 's:java:/opt/jre1.8.0_202/bin/java:g' /opt/Sencha/Cmd/4.0.5.87/sencha

