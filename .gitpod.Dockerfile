#FROM gitpod/workspace-full:latest
#FROM mcr.microsoft.com/dotnet/nightly/sdk
#FROM mcr.microsoft.com/dotnet/sdk:6.0
#FROM bitnami/dotnet-sdk:latest
#FROM bitnami/dotnet-sdk:6
FROM codeconsultants/dotnet-sdk

# Install Node (and NPM)
RUN apt-get update -yq && apt-get upgrade -yq && apt-get install -yq curl git nano less \
    && curl -sL https://deb.nodesource.com/setup_14.x | bash - && apt-get install -yq nodejs build-essential \
    && npm install -g npm \
    && npm --version

# install AWS Serverless CLI
RUN apt-get update -yq && apt-get upgrade -yq && apt-get install -yq curl git nano unzip zip \
    && wget https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip \
    && unzip aws-sam-cli-linux-x86_64.zip -d sam-installation \
    && ./sam-installation/install \
    && sam --version \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && aws --version \
    && dotnet --version

# Moved to .gitpod.yml
## Install lambda tools
# RUN mkdir -p /home/gitpod/.dotnet/tools && dotnet tool install Amazon.Lambda.Tools --tool-path /home/gitpod/.dotnet/tools
RUN mkdir -p /opt/gitpod/.dotnet/tools && chmod +r /opt/gitpod && chmod +r /opt/gitpod/.dotnet && dotnet tool install Amazon.Lambda.Tools --tool-path /opt/gitpod/.dotnet/tools
##RUN dotnet tool install -g Amazon.ECS.Tools
##RUN dotnet tool install -g Amazon.ElasticBeanstalk.Tools
#ENV PATH=${PATH}:/home/gitpod/.dotnet/tools
RUN chmod -R +rx /opt/gitpod/.dotnet/tools
ENV PATH=${PATH}:/opt/gitpod/.dotnet/tools
