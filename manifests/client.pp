# == Class: client
#
# Standard Yum repos
#
class yum::client {

  $rel = $::operatingsystemmajrelease ?  {
    default => '6',
  }

  augeas {
    'yum_exclude':
      context   => '/files/etc/yum.conf/main',
      changes   => $::architecture ? {
        'i386'  => 'set exclude \'*.x86_64\'',
        default => 'set exclude \'*.i387 *.i586\'',
      },
  }

  file {
    "/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${rel}":
      ensure => present,
      source => "puppet:///modules/yum/RPM-GPG-KEY-EPEL-${rel}";
  }

  yum::cirbrepo {
    'os':
      descr => 'CentOS Base',
      path  => "CentOS/${::operatingsystemrelease}/os/${::architecture}",
  }
  yum::cirbrepo {
    'updates':
      descr => 'CentOS Updates',
      path  => "CentOS/${::operatingsystemrelease}/os/${::architecture}",
  }
  yum::cirbrepo {
    'epel':
      descr    => "Extra Packages for Enterprise Linux ${rel}",
      path     => "epel/${rel}/${::architecture}",
      exclude  => "salt*",
  }
  yum::cirbrepo {
    'cirb':
      descr => 'CIRB Internal Packages',
      path  => "cirb/prod/infra/${rel}/${::architecture}",
  }
  yum::cirbrepo {
    'ius':
      descr   => 'IUS Community packages',
      path    => "ius/${rel}/${::architecture}",
      enabled => 0,
  }
  yum::cirbrepo {
    'cirb-testing':
      descr   => 'CIRB Internal Packages (testing)',
      path    => "cirb/testing/infra/${rel}/${::architecture}",
      enabled => 0,
  }
  yum::cirbrepo {
    'pulp':
      descr   => 'Pulp utilities',
      path    => "pulp/${::architecture}",
      enabled => 0,
  }
  yum::cirbrepo {
    'vendor':
      descr   => 'Closed source Packages',
      path    => 'vendor',
      enabled => 0,
  }

  yum::cirbrepo {
    'postgres93':
      descr   => 'PostGreSQL 9.3 official Packages',
      path    => "postgresql/${rel}/${::architecture}",
      enabled => 1,
  }

  # Remove old repo files
  file {'/etc/yum.repos.d/cirb.repo':
    ensure => absent
  }
  file {'/etc/yum.repos.d/cirb-centos.repo':
    ensure => absent
  }
  file {'/etc/yum.repos.d/CentOS-Debuginfo.repo':
    ensure => absent
  }
  file {'/etc/yum.repos.d/CentOS-Debuginfo.repo.off':
    ensure => absent
  }
  file {'/etc/yum.repos.d/CentOS-Media.repo':
    ensure => absent
  }
  file {'/etc/yum.repos.d/CentOS-Media.repo.off':
    ensure => absent
  }
  file {'/etc/yum.repos.d/CentOS-Vault.repo':
    ensure => absent
  }
  file {'/etc/yum.repos.d/CentOS-Vault.repo.off':
    ensure => absent
  }

}
