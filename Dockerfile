FROM centos
MAINTAINER Sthapaun Patinthu <contact@sthapaun.com>


# Update system and install emacs
RUN yum update; yum -y install emacs; yum -y install wget; yum -y install zip; yum -y install unzip; cd ~/; mkdir Desktop; cd Desktop; wget https://storage.googleapis.com/ddd-cdn/dev/editors/emacs.tar.gz; tar -zxvf emacs.tar.gz; cd emacs; cp emacs ~/.emacs; cp -r emacs.d ~/.emacs.d; rm ~/Desktop/emacs.tar.gz; rm -r ~/Desktop/emacs; echo '\n\nexport TERM="xterm"' >> ~/.bashrc;

# Install go 1.5.1
RUN wget https://storage.googleapis.com/golang/go1.5.1.linux-amd64.tar.gz; \
    tar -C /usr/local -xzf go1.5.1.linux-amd64.tar.gz; \
    mkdir ~/gocode
    echo 'export GOPATH=$HOME/gocode' >> ~/.bashrc; \
    echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bashrc; \
    mkdir -p $GOPATH/src/github.com/user; \