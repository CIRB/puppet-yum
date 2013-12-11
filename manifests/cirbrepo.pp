# == Define: cirbrepo
#
# Add a repo located in CIRB infra
#
# === Parameters
# [*url*]
#   Url of the yum repo
#
# [*descr*]
#   Description of yum repo
#
# [*enable*]
#   0 is diabled en 1 is enbabled
#
define yum::cirbrepo($path, $descr, $enabled=1) {

  yumrepo {"cirb-repo-${name}":
    descr           => $descr,
    baseurl         => "http://pulp.irisnet.be/pulp/repos/${path}",
    enabled         => $enabled,
    gpgcheck        => 0,
    http_caching    => 'packages',
    metadata_expire => 60
  }
}
