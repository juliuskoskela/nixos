# Script to install NixOS configuration.nix on a new system

# Ask for a path to configuration.nix
echo "Enter absolute path to configuration.nix"
read -p "Path: " path

# Check if the path exists
if [ ! -f $path ]; then
	echo "Can't find configuration.nix at $path"
	exit 1
fi

# Chekc if the file already exists
if [ -f /etc/nixos/configuration.nix ]; then
	echo "File /etc/nixos/configuration.nix already exists"
	# Do you want to overwrite it?
	read -p "Do you want to overwrite it? [y/n] " overwrite
	if [ $overwrite != "y" ]; then
		echo "Aborting"
		exit 1
	else
		rm /etc/nixos/configuration.nix
		echo "Removed /etc/nixos/configuration.nix"
	fi
fi

# Symlink configuration.nix
sudo ln -s $path /etc/nixos/configuration.nix
echo "Symlinked $path to /etc/nixos/configuration.nix"