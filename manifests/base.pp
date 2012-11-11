# project
class project{
  exec {'bundle':
    path => $path,
    cwd => '/vagrant/depot'
  }
}

stage {'after':
  require => Stage['main']
}

class {'project':
  stage => after,
}

# apt-get update
exec { "apt-update":
  command => "apt-get update",
  path => $path
}

# main installation
package { 'apt-install':
  name => ['puppet',
           'curl',
           'build-essential',
           'git',
           'vim', 
           'ruby', 
           'nodejs',
           'sqlite3',
           'libsqlite3-dev',
           'mysql-client'],
  ensure => present,
  require => Exec['apt-update']
}

define gem($ensure=present){
  package {"gem-${title}":
    name => $title,
    ensure => $ensure,
    provider => 'gem',
    require => Package['apt-install'],
  }
}

# rails dependencies
gem {'rails':}
gem {'sqlite3':}
gem {"json":
       ensure => '1.7.5'
}

# haml2html dependecies
gem {'haml':}
gem {'hpricot':}
gem {'ruby_parser':}

exec {'gem-server':
  path => $path,
  cwd => "/vagrant",
  command => 'gem server --daemon',
  unless => 'wget -O /dev/null localhost:8808',
}
