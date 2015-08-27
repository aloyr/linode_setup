package { epel-release: ensure => 'installed' }
$common_packages = [
  'atop',
  'curl',
  'yum-cron',
  'htop',
  'iotop',
  'iptraf',
  'pv',
  'rsyslog',
  'screen',
  'tcpdump',
  'tmux',
  'vim-enhanced',
  'wget',
]

package { $common_packages:
          ensure => 'installed',
          require => Package ['epel-release'],
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
