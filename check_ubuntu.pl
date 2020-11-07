#!/usr/bin/perl

use strict;
use warnings;

if ( $< != 0 ) {
  print "This script must be run as root\n"; 
  exit (0);
}

my $command;
my $result;

print "1.  Checking for known malicious software packages\n";
$command = 'dpkg-query --list | grep -Ei "Password guessing program|cracker|netcat"';
print "$command\n";
$result = `$command`;
chomp $result;
if ($result) {
  print "$result\n";
} else {
  print "OK!\n";
}
print "\n";

print "2.  Checking for known insecure software packages\n";
$command = 'dpkg-query --list | grep -Ei "telnetd|rsh|ftpd|nmap"';
print "$command\n";
$result = `$command`;
chomp $result;
if ($result) {
  print "$result\n";
} else {
  print "OK!\n";
}
print "\n";

print "3.  Checking SSH server configuration\n";
$command = 'grep -iE "^PermitRootLogin yes|^PermitRootLogin without-password|^PermitEmptyPasswords yes" /etc/ssh/sshd_config';
print "$command\n";
$result = `$command`;
chomp $result;
if ($result) {
  print "$result\n";
} else {
  print "OK!\n";
}
print "\n";

print "4.  Listing users with privileged access (sudo)\n";
print "sudo -l -U {user from /etc/passwd}\n";
$command = "getent passwd | awk -F: '{ print \$1}'";
my @users = `$command`;
foreach my $user (@users) {
  chomp $user;
  $command = "sudo -l -U $user | grep \"may run the following commands\"";
  $result = `$command`;
  if ($result) {
    print "$user is privileged\n";
  } else {
    print "$user\n";
  }  
}
print "\n";
print "places to check\n - sudo group in /etc/group\n - /etc/sudoers file\n - /etc/sudoers.d/ directory\n - /etc/passwd group number\n"; 

$result = `grep "!authenticate" /etc/sudoers`;
if ($result) {
  print " - !authenticate found in /etc/sudoers file\n";
} 
print "\n";

print "5.  checking users have passwords (the second field in /etc/shadow\n";
$command = "cat /etc/shadow";
@users = `$command`;
foreach my $user (@users) {
  chomp $user;
  if ($user =~ /^(.*)::.*:.*:.*:.*:.*:.*:.*/) {
    $user = $1;
    print "$user has no password\n";
  }
}
print "\n";

print "6.  Checking firewall\n";
$command = 'ufw status';
print "$command\n";
$result = `$command`;
chomp $result;
print "$result\n";
print "\n";

print "7.  Checking password policy\n";
$command = 'grep -iE "minlen=|dcredit=|ucredit=|lcredit=|ocredit=" /etc/pam.d/common-password';
print "$command\n";
if ($result =~ /minlen=([0-9]+)/) {
  print "minimum length is $1\n";
} else {
  print "no minimum length set\n";
}
if ($result =~ /dcredit=([0-9]+)/) {
  print "minimum digits is $1\n";
} else {
  print "no digits required\n";
}
if ($result =~ /ucredit=([0-9]+)/) {
  print "minimum uppercase is $1\n";
} else {
  print "no uppercase required\n";
}
if ($result =~ /lcredit=([0-9]+)/) {
  print "minimum lowercase is $1\n";
} else {
  print "no uppercase required\n";
}
if ($result =~ /ocredit=([0-9]+)/) {
  print "minimum special is $1\n";
} else {
  print "no special required\n";
}
print "\n";

print "8.  Checking package updates\n";
$command = 'apt-get upgrade --simulate | grep -Eo "^[0-9]+ upgraded" | grep -Eo "[0-9]+"';
print "$command\n";
$result = `$command`;
chomp $result;
print "$result packages can be upgraded\n";
print "\n";

print "9.  Checking home dirs\n";
$command = 'ls -a /home | grep -vE "^\.$|^\.\.$"';
print "$command\n";
my @homedirs = `$command`;
foreach my $homedir (@homedirs) {
  chomp $homedir;
  $result = `grep -E "^$homedir:" /etc/passwd`;
  if (!$result) {
    print "** $homedir is not a valid user **\n";
  } else {
    print "$homedir is OK\n";
  }
}
print "\n";

print "10. Checking daily update check\n";
$command = 'grep -i "APT::Periodic::Update-Package-Lists" /etc/apt/apt.conf.d/10periodic';
print "$command\n";
$result = `$command`;
chomp $result;
if ($result =~ /"1"/) {
  print "OK\n";
} else {
  print "** package lists are not updating\n";
}
print "\n";

print "11. Check guest account\n";
$command = 'service lightdm status';
print "$command\n";
$result = `$command`;
if ($result =~ /running/) {
  print "lightdm (light desktop manager) is running\n";
  $command = "grep -E \"^allow-guest=false\" /etc/lightdm/*";
  $result = `grep -E "^allow-guest=false" /etc/lightdm/*`;
  if (!$result) {
    print "** guest account is not disabled\n";
    print "consider adding allow-guest=false to /etc/lightdm/lightdm.conf\n";
  }
}
print "\n";

print "12. Check suspicious network connections\n";
$command = 'netstat -ntlup | grep -E "\\netcat|\\nc"';
print "$command\n";
$result = `$command`;
if ($result) {
  print "suspicious network connections found\n";
  print "$result\n";
}
print "\n";

print "13. Check suspicious process names\n";
$command = 'ps -elf | grep -E " nc | netcat " | grep -v grep';
print "$command\n";
$result = `$command`;
if ($result) {
  print "suspicious processes found\n";
  print "$result\n";
}
print "\n";

