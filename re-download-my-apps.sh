#!/bin/bash
#title           :re-download-my-apps.sh
#description     :This script will force redownloading the apps spk files
#author		 	 :Memento
#date            :20160410
#version         :0.1    
#usage			 :./re-download-apps.sh
#notes           :Please make sure you backed up the content of your apps directory, or at least print the content of the directory (ls command). I cannot be held responsible for any damage you could do with this script.
#bash_version    :4.3.11(1)-release
#Copyright (C) 2016 Memento
#
#This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
#This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses/.
#==============================================================================

#Stop Sandstorm
sandstorm stop
service sandstorm stop

for f in `find /opt/sandstorm/var/sandstorm/apps/ -maxdepth 1 -type d | cut -c 35-`
do
	#Remove the app directory
	rm -R "$f"
	#Remove the .appid file
	rm "$f.appid"
	#Download the app spk from sandstorm repository
	wget "https://app-index.sandstorm.io/packages/$f" -O "$f.spk"
	#unpack the app spk and create the .appid file with the app id in it
	spk unpack "$f.spk" > "$f.appid"
	#remove the app spk
	rm "$f.spk"

done

#remove the extra .appid
rm ..appid

#Start Sandstorm
service sandstorm start
