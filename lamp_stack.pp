$lamp = [
  'httpd',
  'mod_ssl',
  'mariadb',
  'mariadb-server',
  'php',
  'php-mysql',
  'php-pecl-imagick',
]
package { $lamp:
  ensure => 'installed',
}
$lamp_services = [
  'httpd',
  'mariadb',
]
service { $lamp_services:
  enable => true,
  ensure => 'running',
}
