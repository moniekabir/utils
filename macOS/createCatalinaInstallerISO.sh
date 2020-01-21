#!/usr/bin/env bash
# Create macOS Catalina Installer ISO.
# https://github.com/moniekabir


installer_path=/Applications/Install\ macOS\ Catalina.app

img_name=Install\ macOS\ Catalina
img_size_spec=8.25g
img_path=/tmp/Install\ macOS\ Catalina.dmg
img_mountpoint=/Volumes/Install\ macOS\ Catalina


echo "Creating ISO disk image"

if [ ! -d "${installer_path}" ]; then
	echo "Please download macOS installer from Appstore, first"
	exit 1
fi


while true
do
    read -p "Are you sure? (yes/no): " reply
    case "$reply" in
        [yY][eE][sS]|[yY] ) break ;;
        [nN][oO]|[nN] ) echo "Operation cancelled by User" ; exit 1 ;;
        * ) echo "Invalid input" ;;
    esac
done


echo " "
echo "Creating a temporary disk image"
hdiutil create -size "${img_size_spec}" -ov -layout SPUD -fs HFS+J -volname "${img_name}" "${img_path}"
if [ ! -f "${img_path}" ]; then
	echo "Couldn't create disk image"
	exit 1
fi


echo " "
echo "Mounting ${img_name}"
hdiutil attach "${img_path}" -noverify -mountpoint "${img_mountpoint}"
if [ $? != 0 ]; then
	echo "Couldn't mount disk"
	exit 1
fi


echo " "
echo "Creating bootable install media"
sudo "${installer_path}"/Contents/Resources/createinstallmedia --volume "${img_mountpoint}" --nointeraction
if [ ! -f "${img_path}" ]; then
	echo "Couldn't find disk"
	exit 1
fi


if [ -d "${img_mountpoint}" ]; then
	echo "Unmounting ${img_name}"
	hdiutil detach  "${img_mountpoint}"
	if [ $? != 0 ]; then
		echo "Couldn’t unmount disk"
		exit 1
	fi
	sleep 3
fi


echo " "
echo "Converting disk image to CD-R export image"
hdiutil convert -format UDTO -o /tmp/"${img_name}" -ov "${img_path}"  
if [ ! -f /tmp/"${img_name}.cdr" ]; then
	echo "Couldn't convert disk"
	exit 1
fi

mv /tmp/"${img_name}.cdr" ~/Downloads/"${img_name}.iso"

if [ -f "${img_path}" ]; then
	rm "${img_path}"
fi


echo " "
echo "Process has completed successfully, You have a new file in 'Download' folder."
