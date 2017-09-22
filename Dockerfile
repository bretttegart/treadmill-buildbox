FROM centos:7
MAINTAINER brett.tegart@morganstanley.com

RUN yum install rpm-build rpmdevtools python-devel -y
RUN yum groupinstall "Development Tools" -y
RUN yum install epel-release -y
RUN yum install python-3.4 python34-pip python34-devel -y
RUN yum install git wget krb5-devel sudo -y
RUN yum clean all
RUN pip3 install wheel 

RUN ln -s /usr/bin/pip3 /usr/bin/pip

COPY treadmill /build/treadmill
COPY treadmill-pid1 /build/treadmill-pid1

WORKDIR /build/treadmill

# This line in the requirements file conflicts with Pex- comment it out when building PEX file. 
# It gets cloned in during the build_binary script in any event. 
# See https://github.com/pantsbuild/pex/issues/164
RUN sed -i 's/git+https:\/\/github.com\/ceache\/kazoo/#git+https:\/\/github.com\/ceache\/kazoo/' requirements.txt

ENTRYPOINT ["/build/treadmill/build_binary.sh"]
