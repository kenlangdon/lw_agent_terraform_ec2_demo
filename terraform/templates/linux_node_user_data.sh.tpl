install_lw() {
    echo " ************************"
    echo " **** Install lw ****"
    echo " ************************"
    curl -sSL https://packages.lacework.net/install.sh > /tmp/install.sh
    sudo sh /tmp/install.sh ${lw_token}

}

install_lw
