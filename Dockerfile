FROM microsoft/nanoserver
LABEL Description="Windows 2016 Nano Server" Vendor="Guytenaerefe"

#ARG NODE_VERSION
ENV NODE_VERSION="7.10.1" 
ENV NODE_SHA256="617590f06f9a0266ceecb3fd17120fc2fbf8669980974f339a83f3b56ed05f7b"

WORKDIR C:/build

# Download and unzip node
#ADD https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-win-x64.zip C:\\build\\node-v${NODE_VERSION}-win-x64.zip
RUN powershell -Command Invoke-WebRequest -OutFile node.zip "https://nodejs.org/dist/v${Env:NODE_VERSION}/node-v${Env:NODE_VERSION}-win-x64.zip" -UseBasicParsing
RUN powershell -Command if ((Get-FileHash node.zip -Algorithm sha256).Hash -ne $Env:NODE_SHA256) {exit 1}
RUN powershell -Command Expand-Archive C:\build\node.zip C:\; Rename-Item c:\node-v${Env:NODE_VERSION}-win-x64 node

RUN SETX PATH C:\node

ENTRYPOINT ["cmd.exe"]