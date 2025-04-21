
# ===========================================================
1 => Utiliser le "AlmaLinux minimal ISO"
2 => Préparer un 'kickstart file'
3 => Boot with inst.ks=<URL_to_kickstart>
exemple : 
# Basic configuration
lang en_US.UTF-8
keyboard fr
timezone UTC
rootpw --plaintext temporarypassword
# Partitioning (adjust as needed)
clearpart --all --initlabel
autopart
# Network (adjust as needed)
network --bootproto=dhcp --device=link --activate
# Installation source
url --url=http://repo.almalinux.org/almalinux/8/BaseOS/x86_64/os/
# Package selection
%packages --excludedocs
@core
python3
openssh-server
%end
# Post-installation script to set up Ansible
%post
dnf install -y epel-release
dnf install -y ansible-core git
# Clone your playbook repo
mkdir -p /opt/ansible
git clone https://github.com/your/repo.git /opt/ansible
# Create a script to run your playbook on first boot
cat > /etc/systemd/system/firstboot-playbook.service << 'EOF'
[Unit]
Description=Run Ansible playbook on first boot
After=network-online.target
Wants=network-online.target
[Service]
Type=oneshot
ExecStart=/usr/bin/ansible-playbook -i localhost, /opt/ansible/yourplaybook.yml
[Install]
WantedBy=multi-user.target
EOF
systemctl enable firstboot-playbook.service
%end
# Reboot when done
reboot
# ===========================================================
# FUTURE AMELIORATIONS
# After minimal install that defineds the Content and the Network ot internet
dnf update -y
dnf install -y epel-release
dnf install -y ansible-core git
git clone https://github.com/your/repo.git
cd your/repo
ansible-playbook -i localhost, yourplaybook.yml
# ===========================================================

# update the OS
sudo dnf update -y
sudo dnf install -y dnf-automatic
sudo systemctl enable dnf-automatic.timer
sudo systemctl start dnf-automatic.timer

# Nomme le computer
sudo hostnamectl set-hostname "YourHostname"

# Ajouter le Wifi
sudo dnf install -y wpa_supplicant NetworkManager NetworkManager-wifi
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager

# Creer une connexion wifi sécurisée
nmcli c add type wifi con-name "<NetworkNametoDisplay>" ifname <NomDeLinterface> ssid "<NomDuSsid>"
nmcli c modify <NomDeLaConnexion> wifi-sec.key-mgnt wpa-psk wifi-sec.psk <passwordSsid>
nmcli c modify "NetworkNameToDisplay" connection.autoconnect yes


# lister les interafces Devices ==> nmcli d
# lister les connexions actives ==> nmcli c



# Permettre la prise en main via ansible : 
dnf install epel-release git ansible

# Get the Playbook
git clone https:// ...

# Définir l'applicabilité Local pour ansible
echo "localhost ansible_connection=local" > inventory.ini
ansible-playbook path/to/your/playbook.yaml -i inventory.ini

