FROM        ubuntu:12.10

MAINTAINER  Adam Alexander, adamalex@gmail.com

# INSTALL OS DEPENDENCIES
RUN         apt-get update
RUN         apt-get install -y curl git

# INSTALL NVM WITH LATEST NODE 0.10
RUN         curl https://raw.github.com/creationix/nvm/master/install.sh | HOME=/root sh
RUN         echo "[[ -s /root/.nvm/nvm.sh ]] && . /root/.nvm/nvm.sh" > /etc/profile.d/nvm.sh
RUN         bash -l -c "nvm install 0.10"
RUN         bash -l -c "nvm alias default 0.10"

# COMMIT THE CONTAINING PROJECT FILES
ADD         . /root

# EXECUTE APP.JS BY DEFAULT
WORKDIR     /root
ENTRYPOINT  ["/bin/bash"]
CMD         ["-l", "-c", "node app.js"]
