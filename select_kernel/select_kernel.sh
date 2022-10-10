#!/bin/sh

export DIALOGOPTS="--colors --backtitle \"Select Kernel\""
echo "screen_color = (RED,RED,ON)" > /tmp/dialog_err.rc

TEXT="
Choose the model of your console to adapt the Linux Kernel of OD Beta firmware.

Use \Zb\Z3Up/Down\Zn keys to select and \Zb\Z3Return\Zn to proceed."

DIR=""
while [[ $DIR == "" ]]
do
    # Ask for console model
    result=$(dialog --stdout --nocancel --title "Select model" --menu "$TEXT" 0 0 0 1 "RG280V" 2 "RG280M-v1.0" 3 "RG280M-v1.1" 4 "RG350/P" 5 "RG350M" 6 "PocketGo2 v2" 7 "RG300X")

    case $result in
      1)
        DIR="rg280v"
        ;;

      2)
        DIR="rg280m-v1.0"
        ;;

      3)
        DIR="rg280m-v1.1"
        ;;

      3)
        DIR="rg350"
        ;;

      4)
        DIR="rg350m"
        ;;

      5)
        DIR="pocketgo2v2"
        ;;

      6)
        DIR="rg300x"
        ;;

      *)
        DIR=""
        ;;
    esac
done

cp ${DIR}/uzImage.bin .
cp ${DIR}/uzImage.bin.sha1 .

status=$?

clear

if [ ${status} -eq 0 ] ; then
    dialog --msgbox "Modification completed!\n\nNow eject the card safelly from your computer and insert in your ${DIR}." 16 0
else
    dialog --msgbox "ERROR\n\nCheck that you have write permissions on the boot partition of the SD." 16 0
fi

clear

exit ${status}
