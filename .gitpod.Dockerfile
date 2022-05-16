#FROM gitpod/workspace-full:latest
#FROM gitpod/workspace-base:latest
#FROM gitpod/workspace-dotnet
#FROM mcr.microsoft.com/dotnet/nightly/sdk
#FROM mcr.microsoft.com/dotnet/sdk:6.0
#FROM bitnami/dotnet-sdk:latest
#FROM bitnami/dotnet-sdk:6
#FROM codeconsultants/dotnet-sdk
#FROM public.ecr.aws/ubuntu/ubuntu:22.10
FROM public.ecr.aws/ubuntu/ubuntu:21.10

#RUN apt-get update && apt-get -y install sudo
#RUN useradd -ms /bin/bash gitpod
#RUN useradd -ms /bin/bash gitpod && usermod -aG sudo gitpod
#USER gitpod

## Get linux version from base image
#RUN lsb_release -d

# Fix from https://github.com/gitpod-io/template-dotnet-core-cli-csharp/commit/9d01b88fa900c7802103a13ca0cc18b2b02c4752
#.NET installed via .gitpod.yml task until the following issue is fixed: https://github.com/gitpod-io/gitpod/issues/5090
#ENV DOTNET_ROOT=/tmp/dotnet
#ENV PATH=$PATH:/tmp/dotnet 

RUN apt-get update && apt-get install -y wget

# Install dotnet-sdk via install script
RUN wget "https://dot.net/v1/dotnet-install.sh" \
 && chmod +x dotnet-install.sh \
 && ./dotnet-install.sh --install-dir /workspace/dotnet \
 && rm dotnet-install.sh \
 && ln -s /workspace/dotnet/dotnet /usr/bin/dotnet

## Add Microsoft package source and key(s)
#RUN wget https://packages.microsoft.com/config/ubuntu/21.10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
##RUN wget https://packages.microsoft.com/config/ubuntu/22.10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
# && dpkg -i packages-microsoft-prod.deb \
# && rm packages-microsoft-prod.deb
## Install .NET SDK 6.0
#RUN apt-get update \
# && apt-get install -y apt-transport-https \
# && apt-get update \
# && apt-get install -y dotnet-sdk-6.0 nuget
#RUN wget https://packages.microsoft.com/config/ubuntu/21.10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
#RUN wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
#RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
# && sudo dpkg -i packages-microsoft-prod.deb \
# && rm packages-microsoft-prod.deb
# Install .NET SDK 6.0
#RUN sudo apt-get update \
# && sudo apt-get install -y apt-transport-https \
# && sudo apt-get update \
# && sudo apt-get install -y dotnet-sdk-6.0 nuget

# Install Node (and NPM)
RUN apt-get update -yq && apt-get upgrade -yq && apt-get install -yq curl git nano less \
 && curl -sL https://deb.nodesource.com/setup_14.x | bash - && apt-get install -yq nodejs build-essential \
 && npm install -g npm \
 && npm --version
# Install Node (and NPM)
#RUN sudo apt-get update -yq && sudo apt-get upgrade -yq && sudo apt-get install -yq curl git nano less \
# && curl -sL https://deb.nodesource.com/setup_14.x | sudo bash - && sudo apt-get install -yq nodejs build-essential \
# && sudo npm install -g npm \
# && npm --version

# install AWS Serverless CLI
RUN apt-get update -yq && apt-get upgrade -yq && apt-get install -yq curl git nano unzip zip libicu-dev \
 && wget https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip \
 && unzip aws-sam-cli-linux-x86_64.zip -d sam-installation \
 && ./sam-installation/install \
 && sam --version \
 && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip \
 && ./aws/install \
 && aws --version \
 && dotnet --version
#RUN sudo apt-get update -yq && sudo apt-get upgrade -yq && sudo apt-get install -yq curl git nano unzip zip \
# && wget https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip \
# && unzip aws-sam-cli-linux-x86_64.zip -d sam-installation \
# && sudo ./sam-installation/install \
# && sam --version \
# && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
# && unzip awscliv2.zip \
# && sudo ./aws/install \
# && aws --version \
# && dotnet --version

# Install lambda tools
#RUN mkdir -p /opt/dotnet/tools && chmod +r /opt/dotnet \
#RUN sudo mkdir -p /opt/dotnet/tools && sudo chown -R gitpod /opt/dotnet \
# && dotnet tool install Amazon.Lambda.Tools --tool-path /opt/dotnet/tools
#RUN dotnet tool install -g Amazon.ECS.Tools --tool-path /opt/dotnet/tools
#RUN dotnet tool install -g Amazon.ElasticBeanstalk.Tools --tool-path /opt/dotnet/tools
#RUN chmod -R +rx /opt/dotnet/tools
#ENV PATH=${PATH}:/opt/dotnet/tools
### Configure path for gitpod/home/gitpod/.dotnet/6.0.300.toolpath.sentinel
##RUN mkdir -p /home/gitpod/.dotnet/tools \
## && chmod -R +r /home/gitpod/.dotnet/ \
## && chmod -R +rx /home/gitpod/.dotnet/tools \
## && mkdir -p /home/gitpod/.dotnet/6.0.300.toolpath.sentinel \
## && mkdir -p /home/gitpod/.dotnet/omnisharp \
## && chmod -R 777 /home/gitpod/.dotnet/omnisharp \
## && chmod -R 777 /home/gitpod/.dotnet/6.0.300.toolpath.sentinel

#RUN dotnet tool install --global Amazon.Lambda.Tools
# Attempt at fixing dotnet build permission error
#RUN sudo chmod -R +rx /usr/share/dotnet
#RUN sudo chmod -R +rx /usr/share/dotnet/sdk
#RUN chmod +rx /usr/share/dotnet/sdk
#RUN chmod +rx /usr/share/dotnet/sdk/6.0.*

#RUN ln -s /workspace/dotnet/dotnet /usr/bin/dotnet
#RUN ln -s ~/.dotnet/dotnet /usr/bin/dotnet

# Install lambda tools
RUN mkdir -p /workspace/dotnet/tools && chmod -R +rx /workspace/dotnet/tools \
 && dotnet tool install Amazon.Lambda.Tools --tool-path /opt/dotnet/tools
#RUN dotnet tool install -g Amazon.ECS.Tools --tool-path /opt/dotnet/tools
#RUN dotnet tool install -g Amazon.ElasticBeanstalk.Tools --tool-path /opt/dotnet/tools
ENV PATH=$PATH:/workspace/dotnet/tools
