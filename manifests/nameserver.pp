# = Class: pdns::nameserver
#
# Installs and configures a PowerDNS nameserver - www.powerdns.com
#
# Currently supported backends: sqlite, postgresql
#
# Only supported on RedHat-based systems
#
# == Parameters:
#
# $listen_address:: The IP address that the nameserver listens on. Defaults to
#                   the primary IP address of the host.
# $backend::        The database backend store for DNS data. Possible values
#                   are 'postgresql' or 'sqlite'. Defaults to 'sqlite'.
# $db_password::    The password to be used for the database user.  Not 
#                   applicable for sqlite.  A default value is set but should
#                   not normally be used.
#
# == Examples:
#
#    class { 'pdns::nameserver':
#      backend     => 'sqlite'
#    }
#
#    class { 'pdns::nameserver':
#      backend     => 'postgresql'
#      db_password => 'sngy3ouunVKbg4zqYmyFqw'
#    }
#
class pdns::nameserver(
  $listen_address = $::ipaddress,
  $backend        = 'postgresql',
  $db_password    = 'vrJRcqfj3Ar1uDuY',
) {
  # TODO: Add use_extlookup and use_hiera to look up values in extlookup and hiera
  # TODO: Use ident auth for Postgresql (the default) if db_password is not set
  # TODO: Scripts to add and remove hosts, with reverse lookups
  # TODO: Make it easy to configure an internal DNS domain
  # TODO: Add an interface parameter so that we can use network_${interface} for 
  # the reverse lookups - default to the first entry in interfaces (eg. eth0)
  # Add a local_domain parameter - default to 'local'
  # Only run on RedHat derived systems.
  case $::osfamily {
    RedHat: { }
    default: {
      fail('This module only supports RedHat-based systems')
    }
  }
  require pdns::nameserver::config
  require pdns::nameserver::install
  require pdns::nameserver::service
}
