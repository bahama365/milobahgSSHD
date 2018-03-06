# Docker SSHD server

A simple SSH server that can be run using a persistant Docker data volume. The server only allows public-key auth, add your key in the Dockerfile entry and connect using the 'sftpuser'.

To run:

docker run --rm -d --name sshd -v sftpdata:/home/sftpuser -p 2222:22 milobahg/sshd

All sftpuser data will then be put into a Docker volume on your host called: /var/lib/docker/volumes/sftpdata/_data
