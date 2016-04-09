#!/bin/bash
sudo cp -r deepin/ /usr/share/sddm/themes/
sudo sed -i "s/^Current=.*/Current=deepin/g" /etc/sddm.conf
echo "Theme has been installed. Enjoy it!"
