# Install deps
sudo apt update && sudo apt install -y nano sudo neofetch wget curl libicu-dev git gpg libarchive-tools

### Install dotnet 5.0
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

sudo apt-get update; \
  sudo apt-get install -y apt-transport-https && \
  sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-5.0

### Install useful dotnet templates

dotnet new -i SAFE.Template && \
dotnet new --install Microsoft.Azure.WebJobs.ProjectTemplates::3.1.1624 && \
dotnet new --install Microsoft.Azure.WebJobs.ItemTemplates::3.1.1624

### Install code-server (allows a Visual Code Editor to be user remotely)
curl -fsSL https://code-server.dev/install.sh | sh

### Install code-server extensions
# VSCode extensions
HOME_DIR=$HOME
# Setup User Visual Studio Code Extentions
CODE_SERVER_EXTENSIONS="$HOME_DIR/.local/share/code-server/extensions"

# Setup User Visual Studio Code Workspace Storage
CODE_SERVER_WORKSPACESTORAGE="$HOME_DIR/.code-server/User/workspaceStorage"

# Mkdir Workspace Storage
sudo mkdir -p $CODE_SERVER_WORKSPACESTORAGE

# Setup C# Extension
sudo mkdir -p $CODE_SERVER_EXTENSIONS/csharp && \
sudo curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-dotnettools/vsextensions/csharp/latest/vspackage | sudo bsdtar --strip-components=1 -xf - -C $CODE_SERVER_EXTENSIONS/csharp extension

# Setup Python Extension
sudo mkdir -p ${CODE_SERVER_EXTENSIONS}/python && \
sudo curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-python/vsextensions/python/latest/vspackage | sudo bsdtar --strip-components=1 -xf - -C ${CODE_SERVER_EXTENSIONS}/python extension

# Setup Ionide-fsharp Extension
sudo mkdir -p ${CODE_SERVER_EXTENSIONS}/ionide-fsharp && \
sudo curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/Ionide/vsextensions/Ionide-fsharp/latest/vspackage | sudo sudo bsdtar --strip-components=1 -xf - -C ${CODE_SERVER_EXTENSIONS}/ionide-fsharp extension

# Setup Ionide-paket Extension
sudo mkdir -p ${CODE_SERVER_EXTENSIONS}/ionide-paket && \
sudo curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/Ionide/vsextensions/Ionide-Paket/latest/vspackage | sudo bsdtar --strip-components=1 -xf - -C ${CODE_SERVER_EXTENSIONS}/ionide-paket extension

# Setup Ionide-FAKE Extension
sudo mkdir -p ${CODE_SERVER_EXTENSIONS}/ionide-fake && \
sudo curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/Ionide/vsextensions/Ionide-FAKE/latest/vspackage | sudo bsdtar --strip-components=1 -xf - -C ${CODE_SERVER_EXTENSIONS}/ionide-fake extension

# Setup RainbowCSV Extension
sudo mkdir -p ${CODE_SERVER_EXTENSIONS}/rainbow-csv && \
sudo curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/mechatroner/vsextensions/rainbow-csv/latest/vspackage | sudo bsdtar --strip-components=1 -xf - -C ${CODE_SERVER_EXTENSIONS}/rainbow-csv extension

# Setup Debugger For Chrome Extension
sudo mkdir -p ${CODE_SERVER_EXTENSIONS}/debugger-for-chrome && \
sudo curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/msjsdiag/vsextensions/debugger-for-chrome/latest/vspackage | sudo bsdtar --strip-components=1 -xf - -C ${CODE_SERVER_EXTENSIONS}/debugger-for-chrome extension

# Setup Azure Tools Pack Extension
sudo mkdir -p ${CODE_SERVER_EXTENSIONS}/azure-tools && \
sudo curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-vscode/vsextensions/vscode-node-azure-pack/latest/vspackage | sudo bsdtar --strip-components=1 -xf - -C ${CODE_SERVER_EXTENSIONS}/azure-tools extension

# Setup Azure Functions Extension
sudo mkdir -p ${CODE_SERVER_EXTENSIONS}/azure-functions && \
sudo curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-azuretools/vsextensions/vscode-azurefunctions/latest/vspackage | sudo bsdtar --strip-components=1 -xf - -C ${CODE_SERVER_EXTENSIONS}/azure-functions extension

# Setup Azure Account Extension
sudo mkdir -p ${CODE_SERVER_EXTENSIONS}/azure-account && \
sudo curl -JLs --retry 5  https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-vscode/vsextensions/azure-account/latest/vspackage | sudo bsdtar --strip-components=1 -xf - -C ${CODE_SERVER_EXTENSIONS}/azure-account extension

sudo curl https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor > microsoft.gpg && \
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-$(lsb_release -cs)-prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/dotnetdev.list' && \
sudo apt update && sudo apt install azure-functions-core-tools-3

code-server --auth none --bind-addr 0.0.0.0:8443


#EXECUTE WITH:
#sudo curl -JLs --retry 5 https://raw.githubusercontent.com/LuisFX/multipass/a2846ddc9ed9120a77d9b51ff537980f77250f6f/multipass_guest_dev_env.sh | sudo bash