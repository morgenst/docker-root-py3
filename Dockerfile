FROM fedora
  
RUN yum update -q -y && yum install -y root python3-root

CMD bash
