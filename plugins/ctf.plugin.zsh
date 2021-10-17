#!/bin/bash

function get_ip(){
   # It can be thm or htb IP
   tunnel_ip=$(ifconfig tun0 2>/dev/null | grep netmask | awk '{print $2}') 
   # Use eth0 as default IP,
   default_ip=$(ifconfig eth0 2>/dev/null | grep netmask | awk '{print $2}')
   if [[ $tunnel_ip == *"10."* ]]; then
      echo "$tunnel_ip"
   else
      echo "$default_ip"
   fi
}

function mknote() {
   if [[ "$1" == "" ]]; then
      echo "Usage: mknote <box-name>"
   else
      mkdir nmap gobuster loot logs exploits ssh-keys dump post-exploits
      cat << EOF > ./"$1"-notes.md
# 00 - Loot

Credentials:

| Service | Username | Password | Found at |
| ------- | -------- | -------- | -------- |
|         |          |          |          |
|         |          |          |          |
|         |          |          |          |

Valid Usernames

```

```

Emails

```

```

...

# 10 - Reconnaissance

## Port scanning - Nmap

### TCP

Full scan.

### UDP

Top 20 TCP

# 15 - Enumeration

## TCP 21 - FTP

## TCP 80 - Website



# 20 - Foothold



# 25 - Privilege Escalation



# 30 - Post-Exploit



# 90 - Summary

Foothold: 

- 
- 

Privilege Escalation:

- 
- 

# 99 - Trial-error/Try list

> What to put here:
>
> - Options you want to try (upper=highest priority, lower=try later)
> - Track things you have tried but failed.
> - Tips/Trick you learned during completing the box.
> - Take a rest if you keep putting/looking your note in here for more than 45 minutes.

EOF
fi
}

alias cls="clear" # Muscle memory for me 
alias vim="nvim" # Muscle memory and helpful with scripts
alias cp='rsync --progress -avz' # Faster and easier

# When on a remote machine what tools are available
alias rtc='which awk perl python python3 python3 ruby lua gcc cc vi vim nmap find netcat nc wget tftp ftp 2>/dev/null'

# Useful for getting files to a remote box. No matter the language the alias does not change.
# These and many other can be found at https://gist.github.com/willurd/5720255
# alias webserver="sudo python2 -m SimpleHTTPServer 80" # Python 2
alias webserver="sudo python3 -m http.server 8000" # Python 3
# alias webserver="ruby -run -ehttpd . -p8000" # Ruby 1.9.2+

# Force Nano
alias edit=nano

# VPN
alias htbon='openvpn /etc/openvpn/htb-sg.ovpn 1>/dev/null &' 
alias htbfort='openvpn /etc/openvpn/htb-fortress.ovpn 1>/dev/null &'
alias htbrel='openvpn /etc/openvpn/htb-release.ovpn 1>/dev/null &'
alias thmon='openvpn /etc/openvpn/thm.ovpn 1>/dev/null &' 
alias thmwreath='openvpn /etc/openvpn/thm-wreath.ovpn 1>/dev/null &'
alias thm='openvpn /etc/openvpn/hyper.conf 1>/dev/null &' 
alias kvpn='pkill openvpn'
alias htbspvip='openvpn /etc/openvpn/vip_starting_point_MLGeoff.ovpn 1>/dev/null &'
alias htbmachine='openvpn /etc/openvpn/lab_MLGeoff.ovpn 1>/dev/null &'
alias pentestit='openvpn /etc/openvpn/lab.pentestit.ru.conf 1>/dev/null &'

# sudo
alias sudo='sudo -v; [ $? ] && sudo '
