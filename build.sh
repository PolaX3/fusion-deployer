FILENAME="fusion-flasher"
FORMAT="raw"
DIRECTORY="fusion"
DATE=$(date '+%Y%m%d-%H%M%S')

rm -f $FILENAME.$FORMAT

./alpine-make-vm-image \
	--image-format $FORMAT \
	--image-size 256M \
	--boot-mode DOSBIOS \
	-P \
	--arch x86 \
	--repositories-file $DIRECTORY/repositories \
	--packages "$(cat $DIRECTORY/packages)" \
	--fs-skel-dir $DIRECTORY/rootfs \
	--fs-skel-chown root:root \
	--script-chroot \
	$FILENAME.$FORMAT -- ./$DIRECTORY/configure.sh

echo "compressing..."
gzip -cvf $FILENAME.$FORMAT > $FILENAME-$DATE.img.gz

