# samba_roberto

> Execució

docker network create sambanet

* en mi caso 172.18.0.1

docker run --rm --name ldap -h ldap --net sambanet -d robert72004/ldapserver_18roberto

docker run --rm --name samba -h samba --net sambanet --privileged -it robert72004/hostpam:18homesamba

docker run --rm --name host -h host --net sambanet --privileged -it robert72004/samba:18sambaldap 





