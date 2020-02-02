FROM fedora
  
RUN yum update -q -y && yum install -y  krb5-libs krb5-server \
krb5-workstation freetype-devel python3-devel.x86_64 which git cmake make clang libX11-devel libXpm-devel libXft-devel libXext-devel openssl-devel

RUN pip install numpy

RUN cd /tmp \
 && git clone https://github.com/root-project/root /usr/src/root \
 && cmake /usr/src/root \
	-Dcxx14=ON \
	-Dbuiltin_xrootd=ON \
	-Dpython=ON \
 && cmake --build . -- -j$(nproc) \
 && cmake --build . --target install \
 && rm -rf /tmp/* /usr/src/root
 
COPY krb5.conf /etc/krb5.conf

ENV PYTHONPATH /usr/local/lib

CMD bash
