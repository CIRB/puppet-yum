# == Define: cirbrepo
#
# Add a repo located in CIRB infra
#
# === Parameters
# [*path*]
#   Path relative to http://pulp.irisnet.be/pulp/repos/ of the yum repo
#
# [*descr*]
#   Description of yum repo
#
# [*enable*]
#   0 is diabled en 1 is enbabled
#
# [ *exclude* ]
#   List of packages or shel globs to exclude from the repository
#   Default is absent, which means no "exclude=" line in the file
define yum::cirbrepo($path, $descr, $enabled=1, $exclude=absent) {

  yumrepo {"cirb-repo-${name}":
    descr           => $descr,
    baseurl         => "http://pulp.irisnet.be/pulp/repos/${path}",
    enabled         => $enabled,
    gpgcheck        => 0,
    http_caching    => 'packages',
    metadata_expire => 60,
    exclude         => $exclude,
  }
}
