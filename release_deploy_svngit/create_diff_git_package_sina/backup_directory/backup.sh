#!/bin/bash

# General variables.
directorios_creados=0
ficheros_creados=0
ficheros_modificados=0

# Recursive function to iterate over children directories.
# Parameters:
# 				$1 Source directory.
#				$2 Destine directory.
recurse() {
	# Iterate over all directories.
	for i in "$1"/*;do
		DIR=`dirname "$i"` # get path
		NAME=`basename "$i"` # get name
		FILE="$DIR/$NAME" # complete path
		if [ -d "$i" ];then # if we iterate over directory...
			if [ ! -d $2/$NAME ];then # if it doesn't exist we create it
				echo "Directorio no existe $2/$NAME"
				mkdir "$2/$NAME"
				directorios_creados=$((directorios_creados+1))
			fi
			# As it is a directory we must enter it in order to iterate over its children directories.
			recurse "$i" "$2/$NAME"
		elif [ -f "$i" ]; then # if we iterate over file...
			if [ ! -f "$2/$NAME" ];then # if it doesn't exist we copy it
				echo "Fichero no existe $2/$NAME"
				cp "$FILE" "$2"
				ficheros_creados=$((ficheros_creados+1))
			else # if it exist but its MD5 doesn't macth, we copy it.
				MD5_SRC=`md5sum "$FILE" | awk '{print $1}'`
				MD5_DST=`md5sum "$2/$NAME" | awk '{print $1}'`
				if [ $MD5_SRC != $MD5_DST ];then
					cp "$FILE" "$2"
					ficheros_modificados=$((ficheros_modificados+1))
					echo "Fichero modificado $2/$NAME"
				fi
			fi
		fi
	done
}

# Call our recursive function.
recurse $1 $2 $directorios_creados $ficheros_creados $ficheros_modificados

# Print information.
echo "Total de fichero copiados:\t\t $ficheros_creados"
echo "Total de directorios creadas:\t\t $directorios_creados"
echo "Total de fichero modificados:\t\t $ficheros_modificados"
