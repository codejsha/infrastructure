FROM curlimages/curl:latest

USER root
WORKDIR /usr/local/bin

RUN curl -LJO "https://storage.googleapis.com/kubernetes-release/release/v1.18.8/bin/linux/amd64/kubectl" && \
    chmod +x kubectl
RUN curl -LJO "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv3.8.4/kustomize_v3.8.4_linux_amd64.tar.gz" && \
    tar -zxf kustomize_v*_linux_amd64.tar.gz && \
    rm -f kustomize_v*_linux_amd64.tar.gz

USER curl_user
WORKDIR /

CMD ["kustomize"]
