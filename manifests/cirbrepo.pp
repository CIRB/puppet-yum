define yum::cirbrepo($url, $descr, $enabled=1) {

  yumrepo {"cirb-repo-${name}":
    descr           => $descr,
    baseurl         => $url,
    enabled         => $enabled,
    gpgcheck        => 0,
    http_caching    => 'packages',
    metadata_expire => 60
  }
}
