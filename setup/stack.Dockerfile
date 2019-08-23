# Before docker build, you need subscription-manager register on RHEL

FROM registry.access.redhat.com/codeready-workspaces/stacks-java-rhel8:1.2

USER root

RUN curl -L https://github.com/openshift/odo/raw/master/scripts/installer.sh | bash

RUN wget -O /tmp/oc.tar.gz https://mirror.openshift.com/pub/openshift-v4/clients/oc/4.1/linux/oc.tar.gz && cd /usr/bin && tar -xvzf /tmp/oc.tar.gz && chmod a+x /usr/bin/oc && rm -f /tmp/oc.tar.gz

RUN wget -O /tmp/graalvm.tar.gz https://github.com/oracle/graal/releases/download/vm-19.1.1/graalvm-ce-linux-amd64-19.1.1.tar.gz && cd /usr/local && tar -xvzf /tmp/graalvm.tar.gz && rm -rf /tmp/graalvm.tar.gz
ENV GRAALVM_HOME="/usr/local/graalvm-ce-19.1.1"
RUN ${GRAALVM_HOME}/bin/gu install native-image

RUN wget -O /tmp/mvn.tar.gz http://www.eu.apache.org/dist/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz
RUN tar xzf /tmp/mvn.tar.gz && rm -rf /tmp/mvn.tar.gz && mkdir /usr/local/maven && mv apache-maven-3.6.0/ /usr/local/maven/ && alternatives --install /usr/bin/mvn mvn /usr/local/maven/apache-maven-3.6.0/bin/mvn 1

RUN wget -O /tmp/tkn_0.2.2_Linux_x86_64.tar.gz https://github.com/tektoncd/cli/releases/download/v0.2.2/tkn_0.2.2_Linux_x86_64.tar.gz && cd /usr/local/bin && tar -xvzf /tmp/tkn_0.2.2_Linux_x86_64.tar.gz && rm -rf /tmp/tkn_0.2.2_Linux_x86_64.tar.gz

ENV PATH="/usr/local/maven/apache-maven-3.6.0/bin:/usr/local/bin/:${PATH}"

ENV MAVEN_OPTS="-Xmx4G -Xss128M -XX:MetaspaceSize=1G -XX:MaxMetaspaceSize=2G -XX:+CMSClassUnloadingEnabled"

RUN yum install -y gcc zlib-devel && yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && yum install -y siege jq

RUN chown -R jboss /home/jboss/.m2

USER jboss