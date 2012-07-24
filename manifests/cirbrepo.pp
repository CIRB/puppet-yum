define yum::cirbrepo($url, $descr) {

  yumrepo {$url:
    descr           => $descr,
    baseurl         => $url,
    enabled         => 1,
    gpgcheck        => 0,
    http_caching    => 'packages',
    metadata_expire => 60
  }
}
