package { 'apt-install':
  name => ['puppet', 
           'vim', 
           'ruby', 
           'nodejs',
           'sqlite',
           'mysql-client'],
  ensure => latest,
}

package {'gem-rails':
  name => 'rails',
  ensure => present,
  provider => 'gem',
  require => Package['apt-install'],
}

exec {'gem-server':
  path => $path,
  cwd => "/vagrant",
  command => 'gem server --daemon',
  unless => 'wget -o /dev/null localhost:8808',
}
