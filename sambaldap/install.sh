#! /bin/bash
# @edt ASIX M06 2018-2019
# instal.lacio
#  - crear usuaris locals
# -------------------------------------
groupadd localgrp01
groupadd localgrp02
useradd -g users -G localgrp01 local01
useradd -g users -G localgrp02 local02
echo "local01" | passwd --stdin local01
echo "local02" | passwd --stdin local02


mkdir /var/lib/samba/homes
chmod 777 /var/lib/samba/homes
cp /opt/docker/* /var/lib/samba/homes/.
cp /opt/docker/smb.conf /etc/samba/smb.conf




cp /opt/docker/nslcd.conf /etc/nslcd.conf
cp /opt/docker/ldap.conf /etc/openldap/ldap.conf
cp /opt/docker/nsswitch.conf /etc/nsswitch.conf
#cp /opt/docker/system-auth /etc/pam.d/system-auth
#cp /opt/docker/pam_mount.conf.xml /etc/security/pam_mount.conf.xml


# engegar el dimoni perque funcioni el getent
/usr/sbin/nslcd && echo "nslcd Ok"
/usr/sbin/nscd && echo "nscd Ok"


# se han de crear els homes perque aixi es pot montar 

mkdir /tmp/home
mkdir /tmp/home/pere
mkdir /tmp/home/pau
mkdir /tmp/home/anna
mkdir /tmp/home/marta
mkdir /tmp/home/jordi
mkdir /tmp/home/admin

cp README.md /tmp/home/pere
cp README.md /tmp/home/pau
cp README.md /tmp/home/anna
cp README.md /tmp/home/marta
cp README.md /tmp/home/jordi
cp README.md /tmp/home/admin

chown -R pere.users /tmp/home/pere
chown -R pau.users /tmp/home/pau
chown -R anna.alumnes /tmp/home/anna
chown -R marta.alumnes /tmp/home/marta
chown -R jordi.users /tmp/home/jordi
chown -R admin.wheel /tmp/home/admin

#-------xixa para public -------
mkdir /var/lib/samba/public
chmod 777 /var/lib/samba/public
cp /opt/docker/* /var/lib/samba/public/.


# users nomes de samba 
useradd patipla
useradd lila
useradd roc
useradd pla

echo -e "patipla\npatipla" | smbpasswd -a patipla
echo -e "lila\nlila" | smbpasswd -a lila
echo -e "roc\nroc" | smbpasswd -a roc
echo -e "pla\npla" | smbpasswd -a pla


# getent para comprova que funciona !!
getent passwd 


# instalacion de smbldap.conf para  el backend

cp /opt/docker/smbldap.conf /etc/smbldap-tools/.
cp /opt/docker/smbldap_bind.conf /etc/smbldap-tools/.
smbpasswd -w secret
net getlocalsid
net getdomainsid

echo -e "jupiter\njupiter" | smbldap-populate
pdbedit -L

# users ldap 

echo -e "pere\npere" | smbpasswd -a pere
echo -e "pau\npau" | smbpasswd -a pau
echo -e "anna\nanna" | smbpasswd -a anna
echo -e "marta\nmarta" | smbpasswd -a marta
echo -e "jordi\njordi" | smbpasswd -a jordi
echo -e "admin\nadmin" | smbpasswd -a admin





