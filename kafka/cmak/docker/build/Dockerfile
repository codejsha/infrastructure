FROM openjdk:11

ARG CMAK_VERSION="3.0.0.5"

RUN curl -o /etc/cmak.zip -LJO https://github.com/yahoo/CMAK/releases/download/${CMAK_VERSION}/cmak-${CMAK_VERSION}.zip && \
    unzip -q -o /etc/cmak.zip -d /etc && \
    mv /etc/cmak-${CMAK_VERSION} /etc/cmak && \
    rm -f /etc/cmak.zip

WORKDIR /etc/cmak
ENV PATH="${PATH}:/etc/cmak/bin"
EXPOSE 9000

CMD ["cmak", "-Dapplication.home=/etc/cmak"]
