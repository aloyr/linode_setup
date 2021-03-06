package { epel-release: ensure => 'installed' }
$common_packages = [
  'atop',
  'curl',
  'fail2ban',
  'git',
  'htop',
  'iotop',
  'iptables-services',
  'iptables-utils',
  'iptraf',
  'nagios-plugins-all',
  'nrpe',
  'openvpn',
  'pv',
  'python2-pip',
  'rsyslog',
  'screen',
  'tcpdump',
  'tmux',
  'vim-enhanced',
  'wget',
  'yum-cron',
]

package { $common_packages:
  ensure => 'installed',
  require => Package['epel-release'],
}

$services = [ 'fail2ban', 'iptables', 'ip6tables', 'nrpe' ]
service { $services:
  enable => true,
  ensure => 'running',
  require => Package[$common_packages],
}

Exec {
  path => [
    '/usr/local/bin',
    '/usr/local/sbin',
    '/usr/bin',
    '/usr/sbin',
    '/bin',
    '/sbin'
  ],
}

class { 'timezone': timezone => 'America/Chicago', }
