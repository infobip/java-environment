FROM codeany/ib-rte-base
LABEL key="Infobip"

# Custom Plugins
USER theia
COPY plugins/GabrielBB.vscode-lombok-1.0.1.vsix /home/theia/plugins/GabrielBB.vscode-lombok-1.0.1.vsix

# Project Settings
COPY settings/project-settings.json /home/project/.theia/settings.json

# Developer tools
USER root

# Java
RUN apt-get update && apt-get -y install openjdk-11-jdk maven

# Java :: restart java lang server & exclude files message dialog workaround
COPY settings/theia-settings.json /root/.theia/settings.json

# Copy POM file definition
COPY pom.xml /home/project

# Prepare source directory structure
COPY src /home/project/src
RUN find /home/project/src -name ".gitkeep" -type f -delete

# Download script
ADD https://raw.githubusercontent.com/infobip/team-legatus-utilities/master/scripts/adjust-container.sh /home/scripts/adjust-container.sh
