RED='\033[0;33m'
NC='\033[0m'

HM=/home/

echo -e "\n${RED}Installing dependencies... ${NC}\n"

sudo apt-get install -y blueman polybar brightnessctl gnome-control-center

echo -e "\n${RED}Moving Files... ${NC}\n"

sudo mkdir -p $HOME/.config/polybar/trickish

sudo cp files/* $HOME/.config/polybar/

echo -e "\n${RED}Installing Fonts... ${NC}\n"

sudo cp -r fonts/* /usr/local/share/fonts

sudo fc-cache -f

echo -e "\n${RED}Adding Starting command to i3 config file... ${NC}\n"

sudo cp $HOME/.config/i3/config $HOME/.config/i3/config.save

echo -e "\n\n#### Trickish PolyBar Config #### \n\nexec --no-startup-id ${HOME}/.config/polybar/trickish/launch.sh \n\n#### Trickish PolyBar Config ####" >> $HOME/.config/i3/config

awk '
/^bar {/ {
    in_block = 1
    print "# " $0
    next
}
in_block && /^}/ {
    in_block = 0
    print "# " $0
    next
}
in_block {
    print "# " $0
    next
}
{ print }
' $HOME/.config/i3/config > /tmp/i3c && mv /tmp/i3c $HOME/.config/i3/config
