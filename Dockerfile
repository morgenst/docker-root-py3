FROM fedora
  
RUN yum update -q -y && yum install -y  krb5-libs krb5-server \
krb5-workstation freetype-devel python3-devel.x86_64 which git cmake make clang libX11-devel libXpm-devel libXft-devel libXext-devel openssl-devel xrootd-client-1:4.10.0-1.fc31 hostname

RUN pip install numpy nose pandas tensorflow future mock nosedep coverage tabulate sklearn oyaml

RUN cd /tmp \
 && git clone https://github.com/root-project/root /usr/src/root \
 && cmake /usr/src/root \
	-Dcxx14=ON \
	-Dbuiltin_xrootd=ON \
	-Dpython=ON \
	-Dbuiltin_xrootd=ON \
 && cmake --build . -- -j4 \
 && cmake --build . --target install \
 && rm -rf /tmp/* /usr/src/root

RUN sudo useradd -m -s /bin/bash "tester" && gpasswd wheel -a tester \
&& echo "tester     ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER tester

WORKDIR /home/tester

COPY krb5.conf /etc/krb5.conf

ENV PYTHONPATH /usr/local/lib

CMD bash
