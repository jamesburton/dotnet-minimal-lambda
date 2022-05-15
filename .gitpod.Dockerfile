#FROM gitpod/workspace-full:latest
FROM gitpod/workspace-basic:latest
#FROM mcr.microsoft.com/dotnet/nightly/sdk
#FROM mcr.microsoft.com/dotnet/sdk:6.0
#FROM bitnami/dotnet-sdk:latest
#FROM bitnami/dotnet-sdk:6
#FROM codeconsultants/dotnet-sdk

# Add Microsoft package source and key(s)
RUN wget https://packages.microsoft.com/config/ubuntu/21.10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
 && dpkg -i packages-microsoft-prod.deb \
 && rm packages-microsoft-prod.deb
# Install .NET SDK 6.0
RUN apt-get update \
  && apt-get install -y apt-transport-https \
  && apt-get update \
  && apt-get install -y dotnet-sdk-6.0

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

# Install lambda tools
RUN mkdir -p /opt/dotnet/tools && chmod +r /opt/dotnet \
 && dotnet tool install Amazon.Lambda.Tools --tool-path /opt/dotnet/tools
#RUN dotnet tool install -g Amazon.ECS.Tools --tool-path /opt/dotnet/tools
#RUN dotnet tool install -g Amazon.ElasticBeanstalk.Tools --tool-path /opt/dotnet/tools
RUN chmod -R +rx /opt/dotnet/tools
ENV PATH=${PATH}:/opt/dotnet/tools
## Configure path for gitpod/home/gitpod/.dotnet/6.0.300.toolpath.sentinel
#RUN mkdir -p /home/gitpod/.dotnet/tools \
# && chmod -R +r /home/gitpod/.dotnet/ \
# && chmod -R +rx /home/gitpod/.dotnet/tools \
# && mkdir -p /home/gitpod/.dotnet/6.0.300.toolpath.sentinel \
# && mkdir -p /home/gitpod/.dotnet/omnisharp \
# && chmod -R 777 /home/gitpod/.dotnet/omnisharp \
# && chmod -R 777 /home/gitpod/.dotnet/6.0.300.toolpath.sentinel