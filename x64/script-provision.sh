#!/bin/bash
echo "*************************"
echo "Updating system packages"
echo "*************************"

sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo apt-get -y update
sudo apt-get -y upgrade
sudo locale-gen pt_BR.UTF-8

echo "*********************"
echo "Installing oh-my-zsh"
echo "*********************"

sudo apt-get -y install zsh
sudo su - vagrant -c 'curl -L http://install.ohmyz.sh | zsh'
sudo sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/' /home/vagrant/.zshrc
sudo sed -i 's=:/bin:=:/bin:/sbin:/usr/sbin:=' /home/vagrant/.zshrc
chsh vagrant -s $(which zsh);

echo "*********************"
echo "Installing subversion"
echo "*********************"

sudo apt-get -y install subversion

echo "****************************"
echo "Installing php5 dev packages"
echo "****************************"

sudo apt-get -y install php5-dev php-pear

echo "***********************"
echo "Installing dependencies"
echo "***********************"

source <(wget -qO- https://gist.github.com/royopa/599259ebeffa6ab7b1cb/raw/)

echo "********************"
echo "Checkout repository "
echo "********************"

cd ~
svn co https://svn.php.net/repository/phpdoc/modules/doc-pt_BR
cd doc-pt_BR

echo "*****************************************************************"
echo "All requirements were installed. You can start your translations!"
echo "*****************************************************************"
