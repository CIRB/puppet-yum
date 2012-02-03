class yum::client {

  $rel = $::operatingsystemrelease ?  {
    '4.3'   => '4',
    '6.0'   => '6',
    '6.1'   => '6',
    '6.2'   => '6',
    default => '5',
  }

  augeas {
    'yum_exclude':
      context   => '/files/etc/yum.conf/main',
      changes   => $::architecture ? {
        'i386'  => 'set exclude \'*.x86_64\'',
        default => 'set exclude \'*.i386 *.i586 *.i686\'',
      },
  }

  file {
    "/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-$rel":
      ensure => present,
      source => "puppet:///modules/yum/RPM-GPG-KEY-EPEL-$rel",
  }

  yumrepo {
    'epel':
      descr    => 'Extra Packages for Enterprise Linux $releasever',
      baseurl  => "http://download.fedora.redhat.com/pub/epel/\$releasever/$::architecture",
      enabled  => 1,
      gpgcheck => 1,
      gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-$rel",
      require  => File["/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-$rel"],
  }


}
