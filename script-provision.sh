#!/bin/bash
echo "**********************"
echo "apt-spy-2-bootstrap.sh"
echo "**********************"
# apt-spy-2-bootstrap.sh
# Uses the Ruby gem apt-spy2 to ensure the apt sources.list file is configured appropriately for this location, and that it selects mirrors that are currently functional

# Do the initial apt-get update
echo "Initial apt-get update..."
apt-get update >/dev/null

echo "Installing 'apt-spy2'. This tool lets us autoconfigure your 'apt' sources.list to a nearby location."
echo "  This may take a while..."

# Ensure dependencies are installed (These are needed to dynamically determine your country code).
# (Note: ruby >= 1.9.2 is needed for apt-spy2)
apt-get install -y ruby1.9.3 curl geoip-bin >/dev/null

# figure out the two-letter country code for the current locale, based on IP address
# (Only return something that looks like an IP address: i.e. ###.###.###.###)
export CURRENTIP=`curl -s http://ipecho.net/plain | grep -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"`

export COUNTRY=`geoiplookup $CURRENTIP | awk -F:\  '{print $2}' | sed 's/,.*//'`

#If country code is empty or != 2 characters, then use "US" as a default
if [ -z "$COUNTRY" ] || [ "${#COUNTRY}" -ne "2" ]; then
   COUNTRY = "BR"
fi

if [ "$(gem search -i apt-spy2)" = "false" ]; then
  gem install apt-spy2
  echo "... apt-spy2 installed!"
  echo "... Setting 'apt' sources.list for closest mirror to country=$COUNTRY"
  apt-spy2 fix --launchpad --commit --country=$COUNTRY ; true
else
  echo "... Setting 'apt' sources.list for closest mirror to country=$COUNTRY"
  apt-spy2 fix --launchpad --commit --country=$COUNTRY ; true
fi

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

sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo apt-get update
sudo apt-get install git subversion php5-cli php-pear sublime-text-installer php5-sqlite

mkdir ~/translation_fest
cd ~/translation_fest

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

echo "********************"
echo "Checkout repository "
echo "********************"

cd ~/translation_fest
svn co https://svn.php.net/repository/phpdoc/modules/doc-pt_BR
cd doc-pt_BR

echo "*****************************************************************"
echo "All requirements were installed. You can start your translations!"
echo "*****************************************************************"
