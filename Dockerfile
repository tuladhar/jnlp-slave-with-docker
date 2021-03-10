FROM jenkinsci/jnlp-slave:3.16-1

USER root

RUN apt-get update && \
    apt-get install -qq -y --no-install-recommends \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    apt-key fingerprint 0EBFCD88 && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable" && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable" && \
    apt-get update && \
    apt-get install -qq -y --no-install-recommends docker-ce && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -fsSL https://baltocdn.com/helm/signing.asc | apt-key add - && \
    echo "deb https://baltocdn.com/helm/stable/debian/ all main" > /etc/apt/sources.list.d/helm-stable-debian.list && \
    apt-get update && \
    apt-get install helm
    
RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.20.4/bin/linux/amd64/kubectl" && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl
