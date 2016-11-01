FROM ubuntu:16.04

MAINTAINER Ezequiel Zuccon "emzuccon@gmail.com"

# Host folders
RUN mkdir -p /home/android
VOLUME /home/android
RUN mkdir -p /opt/android-sdk-linux
VOLUME /opt/android-sdk-linux
RUN mkdir -p /root/.ssh
VOLUME /root/.ssh

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Update APT
RUN apt-get update

# Install base software packages
RUN apt-get install software-properties-common \
    python-software-properties \
    wget \
    curl \
    git \
    unzip -y && \
apt-get clean

# Install Vim
RUN apt-get install -y vim

# Install NetTools
RUN apt-get install -y net-tools

# Install lsof
RUN apt-get install -y lsof

# Install ssh
RUN apt-get install -y openssh-server
RUN cp /etc/ssh/sshd_config /etc/ssh/sshd_config.factory-default
RUN sed -i \
	-e 's~^PermitRootLogin prohibit-password~PermitRootLogin yes~g' \
	-e 's~^StrictModes yes~#StrictModes yes~g' \
  /etc/ssh/sshd_config
#RUN cp -r /home/android/config/.ssh /root/.ssh

# Install java8
RUN apt-get update && \
  apt-get install -y software-properties-common && \
  add-apt-repository -y ppa:webupd8team/java && \
  (echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections) && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  apt-get clean && \
  rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Deps
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y --force-yes expect git wget libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 python curl libqt5widgets5 && apt-get clean && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy install tools
COPY tools /opt/tools
ENV PATH ${PATH}:/opt/tools

# Install Android SDK, all this must be taken from the Docker host
#RUN cd /opt && wget --output-document=android-sdk.tgz --quiet http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz && \
#  tar xzf android-sdk.tgz && \
#  rm -f android-sdk.tgz && \
#  chown -R root.root android-sdk-linux && \
#  /opt/tools/android-accept-licenses.sh "android-sdk-linux/tools/android update sdk --all --no-ui --filter platform-tools,tools" && \
#  /opt/tools/android-accept-licenses.sh "android-sdk-linux/tools/android update sdk --all --no-ui --filter platform-tools,tools,build-tools-21.1.2,build-tools-22.0.1,build-tools-23.0.1,build-tools-23.0.2,build-tools-23.0.3,build-tools-24,build-tools-24.0.1,build-tools-24.0.2,build-tools-24.0.3,build-tools-25,android-21,android-22,android-23,android-24,android-25,addon-google_apis_x86-google-21,extra-android-support,extra-android-m2repository,extra-google-m2repository,extra-google-google_play_services,sys-img-armeabi-v7a-android-24,sys-img-armeabi-v7a-android-25"

# Setup environment
#ENV ANDROID_HOME /opt/android-sdk-linux
#ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools
#RUN which adb
#RUN which android
#CMD ["export", "ANDROID_HOME=/opt/android-sdk-linux/"]
#CMD ["export", "PATH=$ANDROID_HOME/platform-tools:$PATH/"]
#CMD ["export", "PATH=$ANDROID_HOME/tools:$PATH/"]

# Create emulator, if some elememnt of the Android sdk installation fail, the emulator creation fail and docker fail
#RUN /opt/android-sdk-linux/tools/android create avd \
#  --force \
#  --device "Nexus 5" \
#  --name test \
#  --target android-24 \
#  --abi armeabi-v7a \
#  --skin WVGA800 \
#  --sdcard 512M

# Install Gradle
ENV GRADLE_VERSION 2.4
RUN cd /usr/lib \
 && curl -fl https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o gradle-bin.zip \
 && unzip "gradle-bin.zip" \
 && ln -s "/usr/lib/gradle-${GRADLE_VERSION}/bin/gradle" /usr/bin/gradle \
 && rm "gradle-bin.zip"

# Set Appropriate Environmental Variables
ENV GRADLE_HOME /usr/lib/gradle
ENV PATH $PATH:$GRADLE_HOME/bin

# Install Node and global packages
ENV NODE_VERSION 6.9.1
RUN cd && \
    wget -q http://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz && \
    tar -xzf node-v${NODE_VERSION}-linux-x64.tar.gz && \
    mv node-v${NODE_VERSION}-linux-x64 /opt/node && \
    rm node-v${NODE_VERSION}-linux-x64.tar.gz
ENV PATH ${PATH}:/opt/node/bin

# Install Basic React-Native packages
RUN npm install react-native-cli -g
RUN npm install rnpm -g
RUN ln -s "/opt/node/bin/node" /usr/bin/node && \
  ln -s "/opt/node/bin/npm" /usr/bin/npm && \
  ln -s "/opt/node/bin/react-native" /usr/bin/react-native

# Cleaning
RUN apt-get clean

# GO to workspace
RUN mkdir -p /home/android/workspace
WORKDIR /home/android/workspace

# Change root password
RUN echo "root:root" | chpasswd

# Configure locale
CMD ["export", "LANGUAGE=en_US.UTF-8"]
CMD ["export", "LC_ALL=en_US.UTF-8"]
CMD ["locale-gen", "en_US.UTF-8"]
CMD ["update-rc.d", "ssh", "defaults"]

# Start SSH
#CMD ["service", "ssh", "start"]
