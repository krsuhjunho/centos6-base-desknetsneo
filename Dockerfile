#########################################################################
#       Centos6-Base-DeskNetsNeo  Container Image                       #
#       https://github.com/krsuhjunho/centos6-base-desknetsneo          #
#       BASE IMAGE: centos:centos6.10             #
#########################################################################

FROM centos:centos6.10

#########################################################################
#       Repository Init-Shell Copy && Run                              #
#########################################################################
COPY yum-repo.sh /usr/local/src/yum-repo.sh
RUN /usr/local/src/yum-repo.sh 

#########################################################################
#       Install && Update                                               #
#########################################################################

RUN yum install -y -q make \
		httpd \
		gcc-c++ \
		gnu-make \
		readline-devel \
		zlib-devel &&\
		yum update -y -q &&\
		yum clean all

RUN /usr/local/src/yum-repo.sh && \
	yum install -y perl 

#########################################################################
#       POSTGRESQL 9.2.1 Source File Copy                              #
#########################################################################
ADD postgresql-9.2.1.tar.gz /usr/local/src

#########################################################################
#       Postgresql 9.2.1 Init-Shell Copy && Run                        #
#########################################################################
COPY RUN-INIT.sh /usr/local/src/RUN-INIT.sh
RUN /usr/local/src/RUN-INIT.sh && \
    rm -rf /usr/local/src/RUN-INIT.sh 
	
	
#########################################################################
#       DeskNetsNeo Init-Shell Copy && Run                        #
#########################################################################
COPY RUN-INSTALL-DESKNETSNEO.sh /usr/local/src/RUN-INSTALL-DESKNETSNEO.sh
RUN /usr/local/src/RUN-INSTALL-DESKNETSNEO.sh && \	
    rm -rf /usr/local/src/* 


#########################################################################
#       HEALTHCHECK                                                     #
#########################################################################
HEALTHCHECK --interval=30s --timeout=30s --start-period=30s --retries=3 CMD curl -f http://127.0.0.1/cgi-bin/dneo/dneo.cgi? || exit 1

#########################################################################
#       WORKDIR SETUP                                                   #
#########################################################################
WORKDIR /var/www

#########################################################################
#       PORT OPEN                                                       #
#       SSH PORT 22                                                     #
#       HTTP PORT 80                                                    #
#########################################################################
EXPOSE 22
EXPOSE 80


#########################################################################
#       AutoStart Setup                                                 #
#########################################################################
COPY endpoint.sh /endpoint.sh
RUN /endpoint.sh
	
	