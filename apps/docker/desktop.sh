set -e
# ref: https://docs.docker.com/desktop/setup/install/linux/rhel/
install(){
  sudo subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms
  sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
  sudo dnf install -y pass

  # For GNOME desktop environment 
  if [ "$(printenv XDG_CURRENT_DESKTOP)" = "GNOME" ]; then
    sudo dnf install -y gnome-shell-extension-appindicator
    sudo gnome-extensions enable david-khala@hotmail.com
  else
    sudo dnf install -y gnome-terminal
  fi
  sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
  wget https://desktop.docker.com/linux/main/amd64/docker-desktop-x86_64-rhel.rpm
  sudo dnf install -y ./docker-desktop-x86_64-rhel.rpm
  rm ./docker-desktop-x86_64-rhel.rpm

  # post install
  sudo ln -s /usr/local/bin/com.docker.cli /usr/bin/docker
  sudo ln -s /usr/libexec/qemu-kvm /usr/local/bin/qemu-system-x86_64

}


$@
