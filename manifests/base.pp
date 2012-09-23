package { 'apt-install':
  name => ['puppet', 
           'vim', 
           'ruby', 
           'nodejs',
           'sqlite',
           'mysql-client'],
  ensure => present,
}

define gem(){
  package {"gem-${title}":
    name => $title,
    ensure => present,
    provider => 'gem',
    require => Package['apt-install'],
  }
}

gem {'rails':}
gem {'bundle':}

exec {'gem-server':
  path => $path,
  cwd => "/vagrant",
  command => 'gem server --daemon',
  unless => 'wget -O /dev/null localhost:8808',
}
