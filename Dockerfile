FROM readytalk/nodejs
MAINTAINER nathan@hurel.me

RUN apt-get update && apt-get install -y git
WORKDIR /tmp
ENV N1_RELEASE 0.3.26
RUN git clone https://github.com/nylas/N1.git 
WORKDIR /tmp/N1
RUN apt-get install -y pkg-config libgnome-keyring1.0-cil libgnome-keyring1.0-cil-dev libgnome-keyring-dev libgnome-keyring-common fakeroot
RUN git checkout $N1_RELEASE && script/bootstrap

#RUN  m=$(sed -n '/localhost/=' /tmp/N1/src/flux/nylas-api.coffee); echo "@@ -$m,0 +$((m+1)),3 @@\n\
#+    else if env in ['selfhosted']\n\
#+      @AppID = 'n/a'\n\
#+      @APIRoot = 'http://selfhosted:5555'"\
#> /tmp/nylas-api.coffee.patch

#RUN patch /tmp/N1/src/flux/nylas-api.coffee /tmp/nylas-api.coffee.patch
ADD entrypoint.sh /entrypoint.sh
ENV ENGINE_URL http://selfhosted:5555
CMD /entrypoint.sh 
