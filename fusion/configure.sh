#!/bin/sh

_step_counter=0
step() {
	_step_counter=$(( _step_counter + 1 ))
	printf '\n\033[1;36m%d) %s\033[0m\n' $_step_counter "$@" >&2  # bold cyan
}

uname -a

step 'Set up timezone'
setup-timezone -z UTC

echo 'fusion' > /etc/hostname

step 'Set up networking'
cat > /etc/network/interfaces <<-EOF
	iface lo inet loopback
	iface eth0 inet dhcp
EOF
ln -s networking /etc/init.d/net.lo
ln -s networking /etc/init.d/net.eth0agetty
rc-update add net.eth0 default
rc-update add net.lo boot

step 'Enable services'
rc-update add acpid default
rc-update add crond default
rc-update add termencoding boot

step 'List /usr/local/bin'
ls -la /usr/local/bin

#auto login
sed -i 's/getty 38400/agetty --autologin root/g' /etc/inittab

step 'Setting up bootloader'

kernel_opts='quiet random.trust_cpu=on tsc=unstable'

#sed -Ei \
#	-e "s|^[# ]*(default_kernel_opts)=.*|\1=\"$kernel_opts\"|" \
#	/etc/update-extlinux.conf
#update-extlinux

cat > /etc/default/grub <<-EOF
	GRUB_DISTRIBUTOR="fusion-flasher"
	GRUB_TIMEOUT=0
	GRUB_CMDLINE_LINUX_DEFAULT="$kernel_opts"
	GRUB_DISABLE_RECOVERY=true
	GRUB_DISABLE_SUBMENU=true
	GRUB_DISABLE_OS_PROBER=true
EOF

#--allow-floppy works on the older MK9 bios.
grub-install --target=i386-pc --allow-floppy "/dev/$(lsblk -oMOUNTPOINT,PKNAME -rn | awk '$1 ~ /^\/$/ { print $2 }')"
grub-mkconfig -o /boot/grub/grub.cfg

#the search command gives and error which may confuse some users.
sed -i 's/search/#search/g' /boot/grub/grub.cfg

#make pip quiet about global packages
mkdir -p ~/.config/pip
echo -e "[global]\nbreak-system-packages = true" > ~/.config/pip/pip.conf

step 'Installing flasher'

FX2_LOC="/opt/libfx2"
git clone --depth 1 https://github.com/whitequark/libfx2 $FX2_LOC
(cd $FX2_LOC/software && python setup.py develop --user)

step 'Pulling latest release'

#TODO: pull latest from public github.

unzip -j /tmp/fusion.zip
mv *.ihex /boot/fusion/firmware

mv flash /usr/bin/flash
chmod a+x /usr/bin/flash

rm /tmp/fusion.zip
