class amavis::config(
  $bypass_virus_checks_maps =undef,
  $bypass_spam_checks_maps  =undef,
  $final_virus_destiny      =undef,
  $final_banned_destiny     =undef,
  $final_spam_destiny       =undef,
  $final_bad_header_destiny =undef,
) {
  file { [ '/etc/', '/etc/amavis/', '/etc/amavis/conf.d/' ]:
    ensure  => directory,
  }
  file { '/etc/amavis/conf.d/51-puppet':
    ensure  => present,
    content => template('amavis/51-puppet'),
    notify  => Service['amavis'],
  }
  include amavis
  file { '/etc/amavis/conf.d/15-content_filter_mode':
    ensure  => present,
    content => template('amavis/15-content_filter_mode'),
    require => Exec['amavis'],
    notify  => Service['amavis'],
  }
}
