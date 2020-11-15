#ENV VARIABLES
export VM_HOME=/home/ubuntu
export LOCAL_CODE=$CODE
export VM_CODE=$VM_HOME/code  #Configure the path to your code directory
export VM_NAME=ubuntu-net5

export HOME_DIR=$VM_HOME
export CODE_SERVER_EXTENSIONS="$HOME_DIR/.local/share/code-server/extensions"
export CODE_SERVER_WORKSPACESTORAGE="$HOME_DIR/.code-server/User/workspaceStorage"

export IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}') #Assumes en0. Verify your network interface
echo $IP

multipass launch ubuntu --name $VM_NAME
# multipass mount /Volumes/ssd/code $VM_NAME:/home/ubuntu/code

multipass exec $VM_NAME -- sudo apt update
multipass exec $VM_NAME -- sudo apt upgrade -y
multipass exec $VM_NAME -- sudo apt install -y nano sudo neofetch wget curl libicu-dev git gpg libarchive-tools

### Install dotnet 5.0
multipass exec $VM_NAME -- wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
multipass exec $VM_NAME -- sudo dpkg -i packages-microsoft-prod.deb

multipass exec $VM_NAME -- sudo apt-get update
multipass exec $VM_NAME -- sudo apt-get install -y apt-transport-https
multipass exec $VM_NAME -- sudo apt-get install -y dotnet-sdk-5.0

### Install useful dotnet templates

multipass exec $VM_NAME -- dotnet new -i SAFE.Template
multipass exec $VM_NAME -- dotnet new --install Microsoft.Azure.WebJobs.ProjectTemplates::3.1.1624
multipass exec $VM_NAME -- dotnet new --install Microsoft.Azure.WebJobs.ItemTemplates::3.1.1624

### Install code-server (allows a Visual Code Editor to be user remotely)
multipass exec $VM_NAME -- curl -fsSL https://code-server.dev/install.sh | multipass exec $VM_NAME sh

### Install code-server extensions
# VSCode extensions

# ########################################################################################################################
# Mkdir Workspace Storage
multipass exec $VM_NAME -- mkdir -p $CODE_SERVER_WORKSPACESTORAGE

multipass exec $VM_NAME -- sh -c 'echo "Processing Extension: csharp" && mkdir -p '$CODE_SERVER_EXTENSIONS/csharp' && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-dotnettools/vsextensions/csharp/latest/vspackage | bsdtar --strip-components=1 -xf - -C '${CODE_SERVER_EXTENSIONS}/csharp' extension'
multipass exec $VM_NAME -- sh -c 'echo "Processing Extension: python" && mkdir -p '${CODE_SERVER_EXTENSIONS}/python' && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-python/vsextensions/python/latest/vspackage | bsdtar --strip-components=1 -xf - -C '${CODE_SERVER_EXTENSIONS}/python' extension'
multipass exec $VM_NAME -- sh -c 'echo "Processing Extension: jupyter" && mkdir -p '${CODE_SERVER_EXTENSIONS}/jupyter' && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-toolsai/vsextensions/jupyter/latest/vspackage | bsdtar --strip-components=1 -xf - -C '${CODE_SERVER_EXTENSIONS}/jupyter' extension'
multipass exec $VM_NAME -- sh -c 'echo "Processing Extension: ionide-fsharp" && mkdir -p '${CODE_SERVER_EXTENSIONS}/ionide-fsharp' && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/Ionide/vsextensions/Ionide-fsharp/latest/vspackage | bsdtar --strip-components=1 -xf - -C '${CODE_SERVER_EXTENSIONS}/ionide-fsharp' extension'
multipass exec $VM_NAME -- sh -c 'echo "Processing Extension: ionide-paket" && mkdir -p '${CODE_SERVER_EXTENSIONS}/ionide-paket' && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/Ionide/vsextensions/Ionide-Paket/latest/vspackage | bsdtar --strip-components=1 -xf - -C '${CODE_SERVER_EXTENSIONS}/ionide-paket' extension'
multipass exec $VM_NAME -- sh -c 'echo "Processing Extension: ionide-fake" && mkdir -p '${CODE_SERVER_EXTENSIONS}/ionide-fake' && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/Ionide/vsextensions/Ionide-FAKE/latest/vspackage | bsdtar --strip-components=1 -xf - -C '${CODE_SERVER_EXTENSIONS}/ionide-fake' extension'
multipass exec $VM_NAME -- sh -c 'echo "Processing Extension: rainbow-csv" && mkdir -p '${CODE_SERVER_EXTENSIONS}/rainbow-csv' && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/mechatroner/vsextensions/rainbow-csv/latest/vspackage | bsdtar --strip-components=1 -xf - -C '${CODE_SERVER_EXTENSIONS}/rainbow-csv' extension'
multipass exec $VM_NAME -- sh -c 'echo "Processing Extension: debugger-for-chrome" && mkdir -p '${CODE_SERVER_EXTENSIONS}/debugger-for-chrome' && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/msjsdiag/vsextensions/debugger-for-chrome/latest/vspackage | bsdtar --strip-components=1 -xf - -C '${CODE_SERVER_EXTENSIONS}/debugger-for-chrome' extension'
multipass exec $VM_NAME -- sh -c 'echo "Processing Extension: azure-tools" && mkdir -p '${CODE_SERVER_EXTENSIONS}/azure-tools' && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-vscode/vsextensions/vscode-node-azure-pack/latest/vspackage | bsdtar --strip-components=1 -xf - -C '${CODE_SERVER_EXTENSIONS}/azure-tools' extension'
multipass exec $VM_NAME -- sh -c 'echo "Processing Extension: azure-functions" && mkdir -p '${CODE_SERVER_EXTENSIONS}/azure-functions' && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-azuretools/vsextensions/vscode-azurefunctions/latest/vspackage | bsdtar --strip-components=1 -xf - -C '${CODE_SERVER_EXTENSIONS}/azure-functions' extension'
multipass exec $VM_NAME -- sh -c 'echo "Processing Extension: " && mkdir -p '${CODE_SERVER_EXTENSIONS}/azure-account' && curl -JLs --retry 5  https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-vscode/vsextensions/azure-account/latest/vspackage | bsdtar --strip-components=1 -xf - -C '${CODE_SERVER_EXTENSIONS}/azure-account' extension'

multipass exec $VM_NAME -- sh -c 'curl https://packages.microsoft.com/keys/microsoft.asc |sudo gpg --dearmor > microsoft.gpg'
multipass exec $VM_NAME -- sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-$(lsb_release -cs)-prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/dotnetdev.list'
multipass exec $VM_NAME -- sudo apt update
multipass exec $VM_NAME -- sudo apt install azure-functions-core-tools-3
# multipass exec $VM_NAME -- sudo chmod 777 -R /home/ubuntu
multipass exec $VM_NAME -- code-server --auth none --bind-addr 0.0.0.0:8443
