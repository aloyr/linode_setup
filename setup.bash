#!/bin/bash
rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
yum install puppet hiera facter
curl -s https://raw.githubusercontent.com/aloyr/system_config_files/master/setup.bash | GITEMAIL="username@gmail.com" bash
sed -i.bak 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
systemctl restart sshd
iptables -F
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -m multiport -m tcp -p tcp --dports 22,80,443 -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m limit --limit 6/min -j LOG --log-prefix "IPT: "
iptables -A INPUT -j DROP
