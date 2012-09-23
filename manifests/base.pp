package { 'apt-install':
  name => ['puppet', 
           'build-essential',
           'vim', 
           'ruby', 
           'nodejs',
           'sqlite',
           'mysql-client'],
  ensure => present,
}

define gem($ensure=present){
  package {"gem-${title}":
    name => $title,
    ensure => $ensure,
    provider => 'gem',
    require => Package['apt-install'],
  }
}

gem {'rails':}
gem {"json":
       ensure => '1.7.5'}

Gem["json"] -> Gem['rails']


exec {'gem-server':
  path => $path,
  cwd => "/vagrant",
  command => 'gem server --daemon',
  unless => 'wget -O /dev/null localhost:8808',
}
