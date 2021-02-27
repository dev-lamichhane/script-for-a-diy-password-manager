#!/usr/bin/bash
#
apt=`ls /etc | grep apt | head -1`
pacman=`ls /etc | grep pacman | head -1 `

if [ ! -z $apt ]; then
	distro="debian"
	command="sudo apt install --no-install-recommends"
	packages="gpg xclip"
elif
	[ ! -z $pacman ]; then
	distro="arch"
	command="sudo pacman -S --needed"
	packages="gnupg xclip"
fi


if [ -z $apt ] && [ -z $pacman ]; then
	echo "This script is only for Arch or Debian based distros. Bye!!"
	exit $?
else 
	echo "You're using $distro!"
fi

$command $packages

key_status=`gpg --list-secret-key | grep sec | awk '{print $1}' `
echo "key status is $key_status"
if [ -z $key_status ]; then
	read -p "Please follow instructions to create a gpg keypair. Write down the name, email and passphrase you used to create the keypair!! Press enter to start gpg key generation."
	gpg --generate-key
else
	echo "You already have gpg keys!!"
fi


