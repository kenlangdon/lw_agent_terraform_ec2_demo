install_lw() {
    echo " ************************"
    echo " **** Install lw ****"
    echo " ************************"
    curl -sSL https://s3-us-west-2.amazonaws.com/www.lacework.net/download/4.2.0.218_2021-08-27_release-v4.2_918a6d2e7e45c361fce5e46d6f43134203be86ff/install.sh > /tmp/install.sh
    sudo sh /tmp/install.sh ${lw_token}

}

install_lw
