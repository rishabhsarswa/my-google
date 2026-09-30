#!/bin/bash

set -eu

cover_url="http://127.0.0.1/coverups/awn/awn.tar.xz.acrypt.aparts/awn.tar.xz.acrypt.ApartHead"
cover_url="http://127.0.0.1/coverups/web/web.tar.xz.acrypt"
acry_key="cry15360"

cover_url="$1"
acry_key="$2"

function a_download()
{
	echo "Downloding $2"
	while ! wget -c $1 -O $2
	do
		echo "  retry .."
		sleep 5
	done
	echo "done"

}

cover_url_dirname=$(dirname "$cover_url")
cover_basename=$(basename "$cover_url")
#echo $(basename "$cover_basename" | cut -d. -f2-)
#cover_extension=$(echo "$cover_basename" | awk -F. '{print $NF}')
cover_extension="${cover_basename##*.}"
cover_corename="${cover_basename%.*}"
echo $cover_extension $cover_corename


if [ "$cover_extension" == "ApartHead" ]
then
	mkdir -p "$cover_corename.aparts"
	cd "$cover_corename.aparts"
	a_download "$cover_url_dirname/$cover_basename" "$cover_basename"
	cover_parts="$(acrypt parts "$cover_corename")"
	
	for i in $cover_parts
	do
		echo " don $i"
		a_download "$cover_url_dirname/$cover_corename.$i" "$cover_corename.$i"
		
	done
	
	cd ..
	acrypter join "$cover_corename" "$cover_corename"
	
	cover_enc_extension="${cover_corename##*.}"
	cover_enc_corename="${cover_corename%.*}"
	
	if [ "$cover_enc_extension" == "acrypt" ]
	then
		acrypter decrypt $acry_key "$cover_corename" "$cover_enc_corename"
	fi

else
	a_download "$cover_url_dirname/$cover_basename" "$cover_basename"
	#cover_enc_extension="${cover_basename##*.}"
	#cover_enc_corename="${cover_basename%.*}"
	if [ "$cover_extension" == "acrypt" ]
	then
		acrypter decrypt $acry_key "$cover_basename" "$cover_corename"
	fi
fi


echo "all done"

