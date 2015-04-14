for i in `cat packages.txt`;
do
	mkdir $i
	cd $i
	apt-get source $i
	cd `find . -type d | head -n 2 | tail -n 1`
	sudo apt-get build-dep -y $i
	dch --local "p8" "p8build"
	dpkg-buildpackage 
	cd ..
	reprepro -b /home/ubuntu/repo/ includedeb vivid  *deb
	rm -fr $i
	cd ~/source
done 
