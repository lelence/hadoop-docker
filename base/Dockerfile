FROM centos

MAINTAINER Toan <lelence@163.com>

USER root

RUN yum -y install initscripts; yum clean all

RUN yum update -y; yum clean all
RUN	yum install -y wget tar which sudo openssh-server openssh-clients; yum clean all
RUN	yum install -y snappy snappy-devel openssl openssl-devel; yum clean all

RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && \
	ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
	ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa	&& \
	ssh-keygen -q -N "" -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key && \
	ssh-keygen -q -N "" -t ed25519 -f /etc/ssh/ssh_host_ed25519_key && \
	cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

# RUN sed  -i "/^[^#]*UsePAM/ s/.*/#&/"  /etc/ssh/sshd_config
# RUN sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config && \
#	sed -i 's/UsePrivilegeSeparation sandbox/UsePrivilegeSeparation no/' /etc/ssh/sshd_config
ADD ssh_config /root/.ssh/config


# wget oracle java
RUN wget --header "Cookie: oraclelicense=accept-securebackup-cookie" 'http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.rpm' && \
	rpm -ivh jdk-8u181-linux-x64.rpm && \
	rm -rf jdk-8u181-linux-x64.rpm

# load local file
# ADD jdk-8u181-linux-x64.rpm /root
# RUN rpm -ivh /root/jdk-8u181-linux-x64.rpm && \
# 	rm -rf /root/jdk-8u181-linux-x64.rpm

ENV JAVA_HOME /usr/java/jdk1.8.0_181-amd64
ENV PATH $JAVA_HOME/bin:$PATH

# wget hadoop
RUN wget http://mirrors.hust.edu.cn/apache/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz && \
	tar -zxvf hadoop-2.7.7.tar.gz -C /usr/local/ && \
	ln -s /usr/local/hadoop-2.7.7 /usr/local/hadoop

# load local file
# ADD hadoop-2.7.7.tar.gz /usr/local/
# RUN ln -s /usr/local/hadoop-2.7.7 /usr/local/hadoop

ENV HADOOP_PREFIX /usr/local/hadoop
ENV HADOOP_COMMON_HOME /usr/local/hadoop
ENV HADOOP_HDFS_HOME /usr/local/hadoop
ENV HADOOP_MAPRED_HOME /usr/local/hadoop
ENV HADOOP_YARN_HOME /usr/local/hadoop
ENV HADOOP_CONF_DIR /usr/local/hadoop/etc/hadoop
ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop

ENV PATH $HADOOP_PREFIX/bin:$PATH

ADD config/core-site.xml.template $HADOOP_PREFIX/etc/hadoop/core-site.xml.template
ADD config/hdfs-site.xml $HADOOP_PREFIX/etc/hadoop/hdfs-site.xml
ADD config/mapred-site.xml $HADOOP_PREFIX/etc/hadoop/mapred-site.xml
ADD config/yarn-site.xml $HADOOP_PREFIX/etc/hadoop/yarn-site.xml

RUN sed s/HOSTNAME/localhost/ $HADOOP_CONF_DIR/core-site.xml.template > $HADOOP_CONF_DIR/core-site.xml

RUN sed -i '/^export JAVA_HOME/ s:.*:export JAVA_HOME=/usr/java/jdk1.8.0_181-amd64\nexport HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop/:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh


RUN	$HADOOP_PREFIX/bin/hadoop namenode -format

ADD bootstrap.sh /etc/bootstrap.sh
RUN chown root:root /etc/bootstrap.sh && \
	chmod u+x /etc/bootstrap.sh


ENTRYPOINT ["/etc/bootstrap.sh"]

EXPOSE 22
# Hdfs ports
EXPOSE 50010 50020 50070 50075 50090 8020 9000
# Mapred ports
EXPOSE 10020 19888
#Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088



