FROM        ubuntu:12.10

MAINTAINER  Adam Alexander, adamalex@gmail.com

# INSTALL OS DEPENDENCIES AND NODE.JS
RUN         apt-get update; apt-get install -y software-properties-common g++ make
RUN         add-apt-repository -y ppa:chris-lea/node.js
RUN         apt-get update; apt-get install -y nodejs=0.10.22-1chl1~quantal1

# COMMIT APP FILES
ADD         package.json /root/
ADD         app.js /root/

# INSTALL APP DEPENDENCIES
RUN         cd /root; npm install

# EXECUTE NPM START BY DEFAULT
WORKDIR     /root
ENTRYPOINT  ["/usr/bin/npm"]
CMD         ["start"]
