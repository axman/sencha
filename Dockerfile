FROM maven:3-jdk-8
LABEL maintainer "Eric Axley (solway01@gmail.com)"

ENV SENCHA_VERSION=4.0.5.87

RUN curl -o /cmd.run.zip https://cdn.sencha.com/cmd/$SENCHA_VERSION/SenchaCmd-$SENCHA_VERSION-linux-x64.run.zip && \
    unzip -p /cmd.run.zip > /cmd-install.run && \
    chmod +x /cmd-install.run && \
    /cmd-install.run --mode unattended --debuglevel 4 --prefix /opt && \
    install -dm777 -o root -g root /opt/Sencha/Cmd/repo && \
    rm /cmd-install.run /cmd.run.zip && \
    ln -s /opt/Sencha/Cmd/$SENCHA_VERSION/sencha /opt/Sencha/sencha && \
    apt-get update && apt-get install -y --no-install-recommends \
        ruby \
        libffi6 \
        build-essential \
        ruby-dev \
        libffi-dev && \
    gem update --system && \
    gem install compass && \
    apt-get remove -y ruby-dev build-essential libffi-dev && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* 
