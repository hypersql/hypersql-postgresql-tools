FROM ubuntu:impish

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul

# packages
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y \ 
	perl sudo make git rpm alien gcc cpanminus libyaml-dev libaio1 libnsl-dev libpq-dev postgresql-client expect

# user
RUN adduser --disabled-password --gecos '' hypersql && \
	usermod -aG sudo hypersql && \
	echo "hypersql  ALL=(ALL)  NOPASSWD: ALL" >> /etc/sudoers

USER hypersql
# install oracle client
COPY ./build/lib /home/hypersql/lib
RUN cd ~/lib && \
	for FILE in *; do sudo alien -i --scripts $FILE; done && \
	sudo rm -rf ~/lib

# oracle library env setting
RUN echo 'export ORACLE_HOME=`sudo find /usr/lib/oracle -maxdepth 3 -name "client64" -type d`' >> ~/.bashrc && \
	echo 'export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$LD_LIBRARY_PATH' >> ~/.bashrc && \
	echo 'export PATH=$ORACLE_HOME/bin:$PATH' >> ~/.bashrc

# install perl modules
RUN	cpanm -q --sudo DBI && \
	cpanm -q --sudo Compress::Zlib && \
	cpanm -q --sudo Test::NoWarnings && \
	cpanm -q --sudo DBD::Oracle && \
	cpanm --sudo DBD::Pg

# clone ora2pg and install
RUN git clone https://github.com/darold/ora2pg.git ~/ora2pg && \
	cd ~/ora2pg && \
	sudo perl Makefile.PL && sudo make && sudo make install

RUN sudo chown -R hypersql:hypersql /home/hypersql
