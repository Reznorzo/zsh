# Custom Colors
green='82'
blue='21'
red='196'

CURRENT_BG='NONE'

() {
  local LC_ALL="" LC_CTYPE="en_US.UTF-8"
  SEGMENT_SEPARATOR_TOP='╭─['
  SEGMENT_SEPARATOR_BOT='╰─'
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ $UID -eq 0 ]]; then
    echo -n "%{%f%} %{%k%F{yellow}%}#"
  else
    echo -n "%{%f%} %{%k%F{yellow}%}$"
  fi 
  CURRENT_BG=''
}

# Context: user@hostname (who am I and where am I)
prompt_context() {
  if [[ "$USER" != "root" ]]; then
    echo -n "%(!.%{%F{red}%}.)%{%k%F{white}%}$USER%{%k%F{yellow}%}%}@%{%k%F{blue}%}%m%{%k%F{$red}%}]-["
  else
    echo -n "%(!.%{%F{red}%}.)%{%k%F{$red}%}$USER%{%k%F{$red}%}@%{%k%F{$blue}%}%m%{%k%F{$red}%}]-["
  fi
}

# Dir: current working directory
prompt_dir() {
  echo -n  '%{%k%F{blue}%}%~%{%k%F{$red}%}]'
}

# VPN: htb vpn location
prompt_vpn_loc() {
  #this script can be found here https://github.com/theGuildHall/pwnbox
  #htb_vpn_loc=`/opt/vpnserver.sh`
  htb_vpn_loc=`cat /etc/openvpn/*.ovpn | grep "remote " | cut -d " " -f 2 | cut -d "." -f 1 | cut -d "-" -f 2-|head -n1`
  if 
  echo -n  "%{%k%F{white}%}${htb_vpn_loc}%{%k%F{$red}%}]-["
}

# VPN: htb vpn IP
prompt_vpn_ip() {
   #this script can be found here https://github.com/theGuildHall/pwnbox
   htb_vpn_ip=`/opt/vpnbash.sh`
   echo -n "%{%k%F{white}%}${htb_vpn_ip}%{%k%F{$red}%}]-["
}

# Virtualenv: current working virtualenv
prompt_virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    echo -n  "(`basename $virtualenv_path`)"
  fi
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  FAIL_CHAR=$'\u2622'
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{$red}%}${FAIL_CHAR}"
  [[ $UID -eq 0 ]] && symbols+="%{%F{$red}%}⚡"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙"

  [[ -n "$symbols" ]] && echo -n "%{%F{$red}%}[$symbols%{%F{$red}%}]"
}

prompt_newline() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n "%{%k%F{$CURRENT_BG}%}
%{%k%F{$red}%}$SEGMENT_SEPARATOR_BOT"
  else
    echo -n "%{%k%}"
  fi

  echo -n "%{%f%}"
  CURRENT_BG=''
}

prompt_spacer() {
  echo -n "%{%k%F{$red}%}]-["
}

prompt_header() {
  echo -n "%{%k%F{$red}%}$SEGMENT_SEPARATOR_TOP"
}

## Main prompt
build_prompt() {
  RETVAL=$?
  prompt_header
  prompt_context
#  prompt_vpn_loc
  prompt_vpn_ip
  prompt_virtualenv
  prompt_dir
  prompt_newline
  prompt_status
  prompt_end
}

PROMPT='%{%f%B%k%}$(build_prompt) '

