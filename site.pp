package { epel-release: ensure => 'installed' }
$common_packages = [
  'atop',
  'curl',
  'fail2ban',
  'htop',
  'iotop',
  'iptables-services',
  'iptables-utils',
  'iptraf',
  'pv',
  'rsyslog',
  'screen',
  'tcpdump',
  'tmux',
  'vim-enhanced',
  'yum-cron',
  'wget',
]

package { $common_packages:
  ensure => 'installed',
  require => Package['epel-release'],
}

service { 'iptables':
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
