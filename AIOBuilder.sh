#!/bin/bash

tmp=$PWD/tmp
if [ ! -v tmp ];then mkdir $tmp
fi
function copy(){
cd DLC
for i in */ .*/ ; do
	if [ -f $i/update.lst ];then
		cat $i/update.lst >> $tmp/update.lst
		cp -vr $i/data/* $tmp/data/ 
		else
		echo -e "$i Folder didn't added" >> $tmp/err.log
	fi
	done 
}
copy
function clean(){
if [ -v $tmp/data/GameData/paths.dat];then rm $tmp/data/GameData/paths.dat;
fi
if [ -v $tmp/data/GameData/prioritymaterial.arc];then rm $tmp/data/GameData/prioritymaterial.arc;
fi
##regexp ideal "/(?!^0,0)0,0,)/\n0,0,/gs"
sed -i 's/0,0,/\n0,0,/g' $tmp/update.lst
## Not TESTED, optionally you can use a text editor and remplace \n\n to \n or \r\n\r\n to \r\n
sed -i 's/\r\n\r\n/\r\n/g' $tmp/update.lst
##
sed -i '/GameData\\paths.dat/d' $tmp/update.lst
sed -i '/GameData\\prioritymaterial.arc/d' $tmp/update.lst
sed -i '/GameData\\csv_cbl.arc/d' $tmp/update.lst
sed -i '/GameData\\csv.arc/d' $tmp/update.lst
sed -i '/GameData\\script_cbl.arc/d' $tmp/update.lst
}
clean
