function createsshuser()
{
  USER="$1"
  shift 
  SSH_PUBLIC_KEY="$*"
  
  PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
 
  # create a user with a random password
  adduser ${USER}
  echo ${USER}:${PASSWORD} | chpasswd

  # add the user to the wheel group so they can sudo
  usermod -a -G wheel ${USER}

  # add the ssh public key
  su - ${USER} -c "umask 022 ; mkdir .ssh ; echo $SSH_PUBLIC_KEY >> .ssh/authorised_keys"
}


## Useage

# createsshuser bob ssh-rsa AAAA...B3FBdxaQ== bob@example.com