FROM fedora
  
RUN yum update -q -y && yum install -y root python3-root krb5-libs krb5-server krb5-workstation

COPY krb5.conf /etc/krb5.conf

CMD bash
