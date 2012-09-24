package { 'apt-install':
  name => ['puppet', 
           'build-essential',
           'vim', 
           'ruby', 
           'nodejs',
           'sqlite3',
           'libsqlite3-dev',
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
gem {'sqlite3':}
gem {"json":
       ensure => '1.7.5'
}

exec {'gem-server':
  path => $path,
  cwd => "/vagrant",
  command => 'gem server --daemon',
  unless => 'wget -O /dev/null localhost:8808',
}
