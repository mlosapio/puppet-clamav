# Simple ClamAV module

Minimialist module designed to do two things: 
1. run daily virus definition updates
2. run a daily scan on _most_ filesystems

Both of these are performed via cronjobs. 

## Compatibility
This module was only tested on Centos7 however there no obvious reason why it shouldn't work with the 
exception of package names may vary across distributions. 

There are a few parameters availble for this module: 
---

### manage_package
Type: Boolean
Default: True
Action: True will make the module manage the package installation. 

### selinux_enabled
Type: Boolean
Default: True
Action: True will update SELINUX to ensure the AV scanner will run correctly.

### cron_scheduled_updates
Type: Boolean
Default: True
Action: Will schedule the clamav updates.
