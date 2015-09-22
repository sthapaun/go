FROM centos
MAINTAINER Sthapaun Patinthu <contact@sthapaun.com>


# Update system and install emacs
RUN yum update; yum -y install emacs; yum -y install wget; yum -y install zip; yum -y install unzip; cd ~/; mkdir Desktop; cd Desktop; wget https://storage.googleapis.com/ddd-cdn/dev/editors/emacs.tar.gz; tar -zxvf emacs.tar.gz; cd emacs; cp emacs ~/.emacs; cp -r emacs.d ~/.emacs.d; rm ~/Desktop/emacs.tar.gz; rm -r ~/Desktop/emacs; echo '\n\nexport TERM="xterm"' >> ~/.bashrc;

# Install go 1.5.1
RUN wget https://storage.googleapis.com/golang/go1.5.1.linux-amd64.tar.gz; \
    tar -C /usr/local -xzf go1.5.1.linux-amd64.tar.gz; \
    rm go1.5.1.linux-amd64.tar.gz; \
    mkdir ~/gocode; \
    echo 'export GOPATH=$HOME/gocode' >> ~/.bashrc; \
    echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bashrc; \
    mkdir -p /root/gocode/src/github.com/user; \
    ln -s /usr/local/go/bin/go /bin/go; \
    ln -s /usr/local/go/bin/godoc /bin/godoc; \
    ln -s /usr/local/go/bin/gofmt /bin/gofmt

# Create simple go webapp.
RUN cd ~/gocode/src; \
    mkdir app; cd app;\
    echo 'package main' > app.go; \
    echo '' >> app.go; \
    echo 'import (' >> app.go; \
    echo '  "fmt"' >> app.go; \
    echo '  "net/http"' >> app.go; \
    echo ')' >> app.go; \
    echo '' >> app.go; \
    echo 'func handler(w http.ResponseWriter, r *http.Request) {' >> app.go; \
    echo '  fmt.Fprintf(w, "Hi there, I love %s!", r.URL.Path[1:])' >> app.go; \
    echo '}' >> app.go; \
    echo '' >> app.go; \
    echo 'func main() {' >> app.go; \
    echo '  http.HandleFunc("/", handler)' >> app.go; \
    echo '  http.ListenAndServe(":8080", nil)' >> app.go; \
    echo '}' >> app.go; \
    go install

EXPOSE 8080

CMD ["app"]