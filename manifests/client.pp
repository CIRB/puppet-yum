# == Class: client
#
# Yum epel repo
#
class yum::client {

  augeas {
    'yum_exclude':
      context   => '/files/etc/yum.conf/main',
      changes   => $::architecture ? {
        'i386'  => 'set exclude \'*.x86_64\'',
        default => 'set exclude \'*.i386 *.i586\'',
      },
  }

  file {
    "/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${::operatingsystemmajrelease}":
      ensure => present,
      source => "puppet:///modules/yum/RPM-GPG-KEY-EPEL-${::operatingsystemmajrelease}";
  }


  yumrepo {
    'epel':
      descr    => "Extra Packages for Enterprise Linux ${::operatingsystemmajrelease}",
      baseurl  => "http://pulp.irisnet.be/pulp/repos/epel/${::operatingsystemmajrelease}/${::architecture}",
      enabled  => 1,
      gpgcheck => 1,
      gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${::operatingsystemmajrelease}",
      require  => File["/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${::operatingsystemmajrelease}"];
  }


}
