FROM readytalk/nodejs
MAINTAINER nathan@hurel.me

RUN apt-get update && apt-get install -y git\
	pkg-config\
	libgnome-keyring1.0-cil\ 
	libgnome-keyring1.0-cil-dev\ 
	libgnome-keyring-dev\ 
	libgnome-keyring-common\ 
	fakeroot
WORKDIR /tmp
ENV N1_RELEASE 0.3.32
RUN curl -L https://github.com/nylas/N1/archive/$N1_RELEASE.tar.gz | tar xvz 
#RUN tar -xvzf N1-$N1_RELEASE.tar.gz && rm N1-$N1_RELEASE.tar.gz 
WORKDIR /tmp/N1-$N1_RELEASE
RUN script/bootstrap

ADD entrypoint.sh /entrypoint.sh
ENV ENGINE_URL http://selfhosted:5555
CMD /entrypoint.sh 
