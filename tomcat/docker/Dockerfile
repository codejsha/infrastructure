FROM tomcat:9.0.41-jdk11-openjdk

WORKDIR /usr/local/tomcat
COPY server.xml conf/server.xml
COPY context.xml conf/context.xml
COPY tomcat-users.xml conf/tomcat-users.xml
RUN find conf -type f | xargs chmod 600

RUN mkdir webapps/ROOT && \
    mkdir -p conf/Catalina/localhost

EXPOSE 8080
CMD ["catalina.sh", "run"]
