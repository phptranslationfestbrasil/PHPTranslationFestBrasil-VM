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

echo "*****************************"
echo "Installing other dependencies"
echo "*****************************"

sudo apt-get -y install git subversion php5-cli php-pear sublime-text-installer php5-sqlite

echo "**************"
echo "Installing PHD"
echo "**************"

cd ~
git clone https://git.php.net/repository/phd.git
cd phd
sudo pear install package.xml package_generic.xml package_php.xml

# Set the path to PHP from environment or use which to discover it
if [ "$PHP" == "" ];
then
  PHP=$(which php 2>/dev/null)
fi

# Sets the path to PHD from environment or use which to discover it
if [ "$PHD" == "" ];
then
  PHD=$(which phd 2>/dev/null)
fi

# Sets the browser application from environment or falls back on open if it is found
if [ "$BROWSER" == "" ];
then
  BROWSER=$(which open 2>/dev/null)
fi

# Test for executability of PHP
if [ ! -x "$PHP" ];
then
  echo "Cannot execute PHP ($PHP) !"
  exit 1
fi

# Test for executability of PHD
if [ ! -x "$PHD" ];
then
    echo "Cannot execute $PHD, is PHD installed ?"
    exit 2
fi

echo "*****************************"
echo "Checkout repository doc-pt_BR"
echo "*****************************"

cd ~
svn co https://svn.php.net/repository/phpdoc/modules/doc-pt_BR

echo "*****************************************************************"
echo "All requirements were installed. You can start your translations!"
echo "*****************************************************************"
