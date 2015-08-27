#!/bin/bash
rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
curl -s https://raw.githubusercontent.com/aloyr/system_config_files/master/setup.bash | GITEMAIL="username@gmail.com" bash
sed -i.bak 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
