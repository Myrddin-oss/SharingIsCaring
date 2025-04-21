
# update the OS
sudo dnf update -y

sudo dnf install nano

sudo dnf install -y dnf-automatic
sudo systemctl enable dnf-automatic.timer
sudo systemctl start dnf-automatic.timer

# Nomme le computer
sudo hostnamectl set-hostname "YourHostname"

# Ajouter le Wifi
sudo dnf install -y wpa_supplicant NetworkManager NetworkManager-wifi
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager

# lister les interafces Devices ==> nmcli d
# lister les connexions actives ==> nmcli c

# Creer une connexion wifi sécurisée
nmcli c add type wifi con-name "<NetworkNametoDisplay>" ifname <NomDeLinterface> ssid "<NomDuSsid>"
nmcli c modify <NomDeLaConnexion> wifi-sec.key-mgnt wpa-psk wifi-sec.psk <passwordSsid>
nmcli c modify "NetworkNameToDisplay" connection.autoconnect yes

# Permettre la prise en main via ansible : 
dnf install epel-release git ansible

# Get the Playbook
git clone https:// ...

# Définir l'applicabilité Local pour ansible
echo "localhost ansible_connection=local" > inventory.ini
ansible-playbook path/to/your/playbook.yaml -i inventory.ini

