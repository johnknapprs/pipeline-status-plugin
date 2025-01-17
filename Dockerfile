FROM maven:3.6-jdk-8 as builder

WORKDIR /app
COPY pom.xml .
RUN mvn -B dependency:go-offline

COPY src/ src/
RUN mvn -B package

FROM jenkins/jenkins:lts

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# install plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# install plugin for testing
COPY --from=builder --chown=jenkins:jenkins /app/target/pipeline-status-plugin.hpi /var/jenkins_home/plugins/
RUN touch /var/jenkins_home/plugins/pipeline-status-plugin.hpi.pinned
