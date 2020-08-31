echo "Updating repositories"
sudo apt update

echo "Updating system"
sudo apt dist-upgrade -y

echo "Installing git"
sudo apt install git -y

echo "Installing Google Chrome"
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo apt update && sudo apt install google-chrome-stable

echo "Installing Docker"
sudo apt install apt-transport-https ca-certificates curl gnupg software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt install docker-ce
sudo systemctl start docker && sudo systemctl enable docker
docker --version

echo "Installing Docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "Installing VSCode"
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo apt update && sudo apt install code

echo "Installing extensions to VSCode"
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

echo "Installing Python3, PIP and VENV"
sudo apt install python3
sudo apt install -y python3-pip
sudo apt install -y python3-venv

echo "Installing Node v12 and NPM"
sudo apt update && sudo apt upgrade
sudo curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt install -y nodejs

echo "Installing Yarn"
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install yarn

echo "Installing aws-cli"
sudo apt install awscli -y
aws --version

echo "Installing Dbeaver via snap"
sudo snap install dbeaver

echo "Installing Discord via snap"
sudo snap install discord

echo "Installing Postman via snap"
sudo snap install postman

echo "Installing Insomnia via snap"
sudo snap install insomnia

echo "Do you want install gnome tweaks and gnome shell to manage theme? (y/n)"
read install_gnome_theme
if echo "$install_gnome_theme" | grep -iq "^y" ;then
	echo "Installing Gnome tweaks and shell to manage themes"
	sudo apt install gnome-tweaks gnome-shell-extensions
	echo "Press Alt+F2, then type r and press Enter to restart Gnome"
else
	echo "Ok, finished installation. :)"
fi
