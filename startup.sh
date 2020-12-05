COLOR_RED="\e[01;31m"
COLOR_GREEN="\e[01;32m"
COLOR_YELLOW="\e[01;33m"
COLOR_BLUE="\e[01;34m"
COLOR_PURPLE="\e[01;35m"
COLOR_CYAN="\e[01;36m"
COLOR_UNSET="\e[0m"

# -------------------------------------
# UBUNTU
# -------------------------------------
echo "${COLOR_GREEN}Updating repositories${COLOR_UNSET}"
sudo apt update

echo "${COLOR_GREEN}Updating system${COLOR_UNSET}"
sudo apt dist-upgrade -y

# -------------------------------------
# CLI TOOLS
# -------------------------------------
echo "${COLOR_GREEN}Installing curl${COLOR_UNSET}"
sudo apt install curl -y

echo "${COLOR_GREEN}Installing git${COLOR_UNSET}"
sudo apt install git -y

echo "${COLOR_YELLOW}Type your GIT user.name"${COLOR_UNSET}
echo "For example: '${COLOR_BLUE}Lucas França'${COLOR_UNSET}"
read git_config_user_name
git config --global user.name "$git_config_user_name"

echo "${COLOR_YELLOW}Type your GIT user.email?"${COLOR_UNSET}
echo "For example: '${COLOR_BLUE}lucasfrancaid@gmail.com'${COLOR_UNSET}"
read git_config_user_email
git config --global user.email $git_config_user_email

echo "${COLOR_GREEN}Installing xclip${COLOR_UNSET}"
sudo apt install xclip -y

echo "${COLOR_GREEN}Generating SSH Key${COLOR_UNSET}"
ssh-keygen -t rsa -b 4096 -C $git_config_user_email
ssh-add ~/.ssh/id_rsa
eval `ssh-agent`
cat ~/.ssh/id_rsa.pub | xclip -selection clipboard

# -------------------------------------
# BROWSER
# -------------------------------------
echo "${COLOR_GREEN}Installing Google Chrome${COLOR_UNSET}"
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo apt update && sudo apt install google-chrome-stable

# -------------------------------------
# DOCKER
# -------------------------------------
echo "${COLOR_GREEN}Installing Docker${COLOR_UNSET}"
sudo apt install -y apt-transport-https ca-certificates curl gnupg software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt install -y docker-ce
sudo systemctl start docker && sudo systemctl enable docker
echo "${COLOR_CYAN}Docker version:${COLOR_UNSET}"
echo "$(docker --version)"

echo "${COLOR_GREEN}Installing Docker-compose${COLOR_UNSET}"
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# -------------------------------------
# CODE EDITOR
# -------------------------------------
echo "${COLOR_GREEN}Installing VSCode${COLOR_UNSET}"
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo apt update && sudo apt install code

echo "${COLOR_GREEN}Installing extensions to VSCode${COLOR_UNSET}"
code --install-extension ms-python.python
code --install-extension magicstack.MagicPython
code --install-extension batisteo.vscode-django
code --install-extension esbenp.prettier-vscode
code --install-extension dbaeumer.vscode-eslint
code --install-extension VisualStudioExptTeam.vscodeintellicode
code --install-extension dracula-theme.theme-dracula
code --install-extension PKief.material-icon-theme
code --install-extension coenraadS.bracket-pair-colorizer-2
code --install-extension eamodio.gitlens
code --install-extension formulahendry.code-runner
code --install-extension octref.vetur
code --install-extension jcbuisson.vue
code --install-extension sdras.vue-vscode-snippets
code --install-extension ritwickdey.liveserver

# -------------------------------------
# LANGUAGES, PACKAGES MANAGERS AND UTILS
# -------------------------------------
echo "${COLOR_GREEN}Installing Python3, PIP3 and VENV${COLOR_UNSET}"
sudo apt install -y python3
sudo apt install -y python3-pip
sudo apt install -y python3-venv

echo "${COLOR_GREEN}Installing Python2, PIP and Virtualenv${COLOR_UNSET}"
sudo apt install -y python2
curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py
sudo python2 get-pip.py && rm get-pip.py

echo "${COLOR_GREEN}Installing Node v12 and NPM${COLOR_UNSET}"
sudo apt update && sudo apt upgrade
sudo curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt install -y nodejs

echo "${COLOR_GREEN}Installing Yarn${COLOR_UNSET}"
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install -y yarn

# -------------------------------------
# CLOUD COMPUTING
# -------------------------------------
echo "${COLOR_GREEN}Installing aws-cli${COLOR_UNSET}"
sudo apt install awscli -y
echo "${COLOR_CYAN}AWS and dependencies version:${COLOR_UNSET}"
echo "$(aws --version)"

echo "${COLOR_GREEN}Installing Serverless${COLOR_UNSET}"
sudo npm install serverless -g

# -------------------------------------
# DATABASE MANAGER
# -------------------------------------
echo "${COLOR_GREEN}Installing Dbeaver via snap${COLOR_UNSET}"
sudo snap install dbeaver-ce

# -------------------------------------
# COMUNICATION
# -------------------------------------
echo "${COLOR_GREEN}Installing Discord via snap${COLOR_UNSET}"
sudo snap install discord

# -------------------------------------
# MUSIC APP
# -------------------------------------
echo "${COLOR_GREEN}Installing Spotify via snap${COLOR_UNSET}"
sudo snap install spotify

# -------------------------------------
# REQUEST APPS
# -------------------------------------
echo "${COLOR_GREEN}Installing Postman via snap${COLOR_UNSET}"
sudo snap install postman

echo "${COLOR_GREEN}Installing Insomnia via snap${COLOR_UNSET}"
sudo snap install insomnia

# -------------------------------------
# THEME
# -------------------------------------
echo "${COLOR_YELLOW}Do you want install gnome tweaks and gnome shell to manage theme? (y/n)${COLOR_UNSET}"
read install_gnome_theme
if echo "$install_gnome_theme" | grep -iq "^y" ;then
	echo "${COLOR_GREEN}Installing Gnome tweaks and shell to manage themes${COLOR_UNSET}"
	sudo apt install -y gnome-tweaks gnome-shell-extensions
	echo "${COLOR_YELLOW}Press Alt+F2, then type r and press Enter to restart Gnome${COLOR_UNSET}"
else
	echo "${COLOR_YELLOW}Ok, finished installation. :)${COLOR_UNSET}"
fi
