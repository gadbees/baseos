FROM ubuntu:16.04
MAINTAINER gadbees gadbees@gmail.com
LABEL Description="This image is the base os images."  Version="1.0"

#sudo docker run -d -p 127.0.0.1:50000:5000 --restart=always --name registry  -v  `pwd`/data:/var/lib/registry  registry:2


RUN apt-get update
RUN apt-get install -y vim openssh-server  openssh-client curl  

#ssh
RUN rm -f /etc/ssh/ssh_host_dsa_key /etc/ssh/ssh_host_rsa_key /root/.ssh/id_rsa
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

RUN mkdir -p /usr/java
COPY jdk1.8.0_144 /usr/java/jdk1.8.0_144
ENV JAVA_HOME=/usr/java/jdk1.8.0_144
ENV PATH=$JAVA_HOME/bin:$PATH

RUN apt-get install -y  zsh
RUN apt-get install -y  git

RUN git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
    && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
    && chsh -s /bin/zsh

RUN apt-get install -y ssh inetutils-ping net-tools

WORKDIR /root


RUN ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
RUN cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys


#service ssh restart && zsh

CMD tail -f /dev/null





