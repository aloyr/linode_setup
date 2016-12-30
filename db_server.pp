$db = [
  'mariadb-server',
  'mariadb',
  'mysqltuner',
  'mysqlreport',
]

package { $db:
  ensure => 'installed',
}
$db_services = [
  'mariadb',
]
service { $db_services:
  enable => true,
  ensure => 'running',
  require => Package[$db],
}
