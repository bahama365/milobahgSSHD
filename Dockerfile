FROM ubuntu:16.04
LABEL maintainer=milobahg
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd; useradd -m sftpuser; mkdir -p /home/sftpuser/.ssh; touch /home/sftpuser/.ssh/authorized_keys
## Add your public key below
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIEAxv2Nt7xaC7wCFxlXsEErr+sQ+dGekVf5eYry/GvUbocLrfjadgEgD2NB8gu5KIaKJKE6Q5xVDDWQ/UoCNYN9Wq1OsNIKHxvqdzQyUoR3rUey9Mo2SzyWD09Zl1cNelkZxArGYqxUF5TqBjfMOANAzvLDLWpKf3UxXeIqpo3Ab/E= rsa-key-20160429" >> /home/sftpuser/.ssh/authorized_keys
RUN chown -R sftpuser:sftpuser /home/sftpuser; chmod 700 /home/sftpuser/.ssh; chmod 600 /home/sftpuser/.ssh/authorized_keys
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config; \
  sed -i 's/#PasswordAuthentication yes/#PasswordAuthentication no/' /etc/ssh/sshd_config; \
  sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
