$docker_req = [
  'yum-utils',
  'device-mapper-persistent-data',
  'lvm2',
]

package { $docker_req:
  ensure => 'installed',
}

exec { 'docker-yum':
  command => 'yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo',
  creates => '/etc/yum.repos.d/docker-ce.repo',
  require => Package[$docker_req],
}

$docker = [
  'docker-ce',
  'docker-ce-cli',
  'containerd.io',
]

package { $docker:
  ensure => 'installed',
  require => Exec['docker-yum'],
}

service { 'docker':
  enable => true,
  ensure => 'running',
  require => Package[$docker],
}
