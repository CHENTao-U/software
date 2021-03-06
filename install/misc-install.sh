#!/usr/bin/env bash
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive

# **************** vim ****************

apt-get -y install wget vim

# **************** zsh ****************

apt-get -y install zsh

# The stacks should be mounted at /home/software/cuauv/software
rm /home/software/.bashrc

sudo -u software cat > /home/software/.zshrc <<'EOF'
. /home/software/.zshrc_user
. /opt/auv/.zshrc_system
EOF

sudo -u software ln -s /home/software/cuauv/software/install/zshrc /home/software/.zshrc_user

ZSH=/home/software/.oh-my-zsh
sudo -u software git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git "${ZSH}"
# cp $ZSH/templates/zshrc.zsh-template /home/software/.zshrc
chsh -s $(grep /zsh$ /etc/shells | tail -1) software

# **************** ssh ****************

apt-get -y install openssh-server sshfs

echo "PermitEmptyPasswords yes" | tee -a /etc/ssh/sshd_config
echo "PasswordAuthentication yes" | tee -a /etc/ssh/sshd_config
echo "X11UseLocalhost no" | tee -a /etc/ssh/sshd_config
echo "UsePAM yes" | tee -a /etc/ssh/sshd_config

echo "auth sufficient pam_permit.so" > /etc/pam.d/sshd

sudo -u software mkdir -p /home/software/.ssh

sudo -u software cat > /home/software/.ssh/config <<'EOF'
Host loglan
  Hostname cuauv.org
  Port 2222
  User software
  ForwardX11 yes
  ForwardX11Timeout 20d
  ForwardX11Trusted yes
EOF

# **************** sloth ****************

mkdir -p /build_tmp_sloth

cd /build_tmp_sloth
git clone https://github.com/alexrenda/sloth.git sloth

cd sloth

python3 setup.py install

rm -rf /build_tmp_sloth
