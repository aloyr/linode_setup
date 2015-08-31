$lamp = [
  'http',
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
