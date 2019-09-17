#!/bin/bash
rpm -Uvh https://yum.puppetlabs.com/puppet-release-el-7.noarch.rpm
yum install -y puppet-agent
echo 'PATH="$PATH:/opt/puppetlabs/bin"' > /etc/profile.d/puppet.sh
/opt/puppetlabs/bin/puppet module install saz-timezone
/opt/puppetlabs/bin/puppet module install saz-sudo
curl -s https://raw.githubusercontent.com/aloyr/system_config_files/master/setup.bash | GITEMAIL="username@gmail.com" bash
if [ ! -d ~/.ssh ]; then
  ssh-keygen -q -t ed25519 -N '' -f ~/.ssh/id_ed25519
  curl -s https://raw.githubusercontent.com/aloyr/ssh-keys/master/combined.pub > ~/.ssh/authorized_keys
  chmod 600 ~/.ssh/authorized_keys
fi
sed -i.bak 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
systemctl restart sshd
iptables -F
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -m multiport -m tcp -p tcp --dports 22,80,443 -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -i tun+ -j ACCEPT
iptables -A INPUT -m limit --limit 6/min -j LOG --log-prefix "IPT: "
iptables -A INPUT -j DROP
site=$(curl -s https://raw.githubusercontent.com/aloyr/linode_setup/master/site.pp)
/opt/puppetlabs/bin/puppet apply -e "$site"
sed -i.bak 's/apply_updates = no/apply_updates = yes/g' /etc/yum/yum-cron.conf
f2bfile="/etc/fail2ban/jail.local"
echo ""               >> $f2bfile
echo '[DEFAULT]'      >> $f2bfile
echo 'bantime = 3600' >> $f2bfile
echo ""               >> $f2bfile
echo '[sshd]'         >> $f2bfile
echo 'enabled = true' >> $f2bfile
echo ""               >> $f2bfile
systemctl restart fail2ban
sed -ibak 's/#server_address=127.0.0.1/server_address=10.14.0.1/g' /etc/nagios/nrpe.cfg
systemctl restart nrpe
echo 'To setup a LAMP stack, use the following commands:'
echo 'lamp=$(curl -s https://raw.githubusercontent.com/aloyr/linode_setup/master/lamp_stack.pp);'
echo '/opt/puppetlabs/bin/puppet apply -e "$lamp"'

echo '---------------------------------------------'

echo 'To setup a DB server, use the following commands:'
echo 'db=$(curl -s https://raw.githubusercontent.com/aloyr/linode_setup/master/db_server.pp);'
echo '/opt/puppetlabs/bin/puppet apply -e "$db"'

echo '---------------------------------------------'

echo 'To setup a docker node, use the following commands:'
echo 'docker=$(curl -s https://raw.githubusercontent.com/aloyr/linode_setup/master/docker.pp);'
echo '/opt/puppetlabs/bin/puppet apply -e "$docker"'
