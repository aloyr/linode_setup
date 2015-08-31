$lamp = [
  'httpd',
  'mod_ssl',
  'mariadb',
  'mariadb-server',
  'memcached',
  'php',
  'php-mysql',
  'php-pecl-apcu',
  'php-pecl-imagick',
  'php-pecl-memcache',
  'varnish',
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
