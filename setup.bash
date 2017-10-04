#!/bin/bash
rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
yum install -y puppet-agent
echo 'PATH="$PATH:/opt/puppetlabs/bin"' > /etc/profile.d/puppet.sh
/opt/puppetlabs/bin/puppet module install saz-timezone
/opt/puppetlabs/bin/puppet module install saz-sudo
curl -s https://raw.githubusercontent.com/aloyr/system_config_files/master/setup.bash | GITEMAIL="username@gmail.com" bash
if [ ! -d ~/.ssh ]; then
  ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa
  curl -s https://raw.githubusercontent.com/aloyr/ssh-keys/master/combined.pub > ~/.ssh/authorized_keys
  chmod 600 ~/.ssh/authorized_keys
fi
sed -i.bak 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
systemctl restart sshd
iptables -F
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -m multiport -m tcp -p tcp --dports 22,80,443 -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m limit --limit 6/min -j LOG --log-prefix "IPT: "
iptables -A INPUT -j DROP
site=$(curl -s https://raw.githubusercontent.com/aloyr/linode_setup/master/site.pp)
/opt/puppetlabs/bin/puppet apply -e "$site"
sed -i.bak 's/apply_updates = no/apply_updates = yes/g' /etc/yum/yum-cron.conf
echo 'To setup a LAMP stack, use the following commands:'
echo 'lamp=$(curl -s https://raw.githubusercontent.com/aloyr/linode_setup/master/lamp_stack.pp);'
echo '/opt/puppetlabs/bin/puppet apply -e "$lamp"'

echo '---------------------------------------------'

echo 'To setup a DB server, use the following commands:'
echo 'db=$(curl -s https://raw.githubusercontent.com/aloyr/linode_setup/master/db_server.pp);'
echo '/opt/puppetlabs/bin/puppet apply -e "$db"'
