install_lw() {
    echo " ************************"
    echo " **** Install lw ****"
    echo " ************************"
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EE0CC692
    sudo add-apt-repository 'deb [arch=amd64] https://packages.lacework.net/DEB/ubuntu/18.04/ bionic main'
    sudo apt-get update
    sudo apt-get install lacework
    sudo mkdir /var/lib/lacework
    sudo mkdir /var/lib/lacework/config
    sudo mv /tmp/config.json /var/lib/lacework/config/config.json
}

install_lw
