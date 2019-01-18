# class: clamav 
class clamav (
  $manage_package  = true,
  $selinux_enabled = true,
  $cron_scheduled  = true,
){

  if $package_manage {
    package { 'clamav': ensure => 'latest' }
    package { 'clamav-update': ensure => 'latest' }
  }

  if $selinux_enabled {
    exec { 'setbool_virus_scan':
        cwd     => '/',
        command => 'setsebool -P antivirus_can_scan_system on',
        unless  => "getsebool -a | grep 'antivirus_can_scan_system --> on'",
    }
    exec { 'clamav_jit_selinux':
        cwd => '/',
        command => 'setsebool -P clamd_use_jit on',
        unless  => "getsebool -a |  'antivirus_use_jit --> on'",
    }
  }

  if $cron_scheduled {
    cron { 'clamav-update':
      command => '/bin/freshclam -v --no-warnings > /var/log/freshclam.log',
      user    => 'root',
      hour    => fqdn_rand(23),
      minute  => fqdn_rand(60),
      weekday => 0,
    }
  }

  cron { 'scheduled_scan':
      command => 'clamscan / -ir --exclude-dir=^/run --exclude-dir=^/opt --exclude-dir=^/proc --exclude-dir=^/sys --exclude-dir=^/dev | logger -t clamav',
      user    => 'root',
      hour    => fqdn_rand(23),
      minute  => fqdn_rand(60),
  }

}
