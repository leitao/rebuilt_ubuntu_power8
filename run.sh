#!/bin/bash -x
DRY_RUN=1

for i in `combine packages.txt not ported.txt`;
do
	mkdir $i
	cd $i
	apt-get source $i
	cd `find . -type d | head -n 2 | tail -n 1`
	sudo apt-get build-dep -y $i
	dch --local "p8" "p8build"
	dpkg-buildpackage  2>&1 > $i_log.txt
	cd ..
	[[ -n "$DRY_RUN" ]] && reprepro -b /home/ubuntu/repo/ includedeb vivid  *deb
	echo $i >> ported.txt
	rm -fr $i
	cd ~/source
done 
