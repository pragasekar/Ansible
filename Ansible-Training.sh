Ansible galaxy - hub of packages 
sccm - widows configuration managemen tool

https://github.com/yogeshraheja

==============
######################## SETUP #########################################
########################################################################
########################################################################
linux cmds

hostnamectl set-hostname <new hostname> ## set host name
systemctl restart <servicename> ## start service
systemctl status <servicename> ## status service
find \-name index.html ## find the file by name
id username ## check the user details
rpm -ql <package name> | grep -i index.html ## search with in index




## Register the host name to resolve ip and making network connection
## do this in both master and client
ip addr
vi /ect/hosts/
ip master-hostname
ip client-hostname 

## List all the repo
yum repolist

## List only the ansible repo
yum list | grep -i ansible

## Check the os release
cat /etc/*release

## find the mapping repo url from document install the repo as per the product version
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

## To refresh the repo list
yum repolist

## Install ansible
yum install ansible

## Create ansible cluste
Add the client name in /etc/ansible/host name

## ping to client from master
ansible "client" -m ping --ask-pass

## To disable the fingerprint check disable the property in /etc/ansible/ansible.cfg property file
host_key_checking = False

## generate key pair
ssh-keygen 
## copy the public key from master and register the public in client machine
In master
Key source will be shown at the time of ssh-keygen

In client machine
/root/.ssh/authorized_keys
add the public key in authorized_keys

or  

ssh-copy-id client > to copy the public key to client machine

## Allow key based authentication on client
/etc/ssh/sshd_config = config to allow the key based authentication
PubkeyAuthentication yes

systemctl restart sshd -> restart the ssh service

=============================================================================================
## Ad-hoc commands
ansible <client-name> -m <module-name>  -a "<attributes like a1=value, a2=value>" 

## to get the modules 
ansible-doc -l | grep -i <search string>


ansible-doc -l | grep user | more

## command is the default module. This is defined ansible.cfg file. 


ansible "client" -m command -a "uptime"
ansible "client" -m command -a "cat /etc/os-release"  or ansible "client" -m shell -a "cat /etc/*release"
ansible "client" -m yum -a "name=telnet state=present"
ansible "client" -m user -a "name=pragathees uid=9999 state=present"
ansible "client" -m group -a "name=thinknyxtest gid=8888 state=present"
ansible "client" -m file -a "path=/tmp/myfile state=touch owner=root group=root mode=0777"
ansible "client" -m copy -a "dest=/tmp src=/var/log/messages"

ansible "client" -m file -a "path=/var/tmp/mytestdir state=directory owner=pragathees group=thinknyxtest mode=0777"
ansible "client" -m copy -a "dest=/tmp/myfile content='Hello this is my first file'" or 
ansible "client" -m lineinfile -a "path=/tmp/myfile2 line='Hello this is my first file' create=yes"
ansible "client" -m fetch -a "src=/tmp/myfile dest=/tmp/client/myfile"
ansible "client" -m user -a "name=yougeshtest uid=7777 state=present groups=thinknyxtest"
ansible "client" -m script -a /var/tmp/test.sh ## Script name passed as Free form attributes

test.sh
{
#!/bin/sh
useradd testuser
touch /tmp/testfile
mkdir /tmp/testdir
echo "mytestoutput"
}

ansible all -i localhost, -m debug -a "msg={{ 'Thinknyx' | password_hash('sha512', 'mysecretsalt') }}"

ansible "client" -m user -a "name=pragatheestest uid=5555 state=present password=$6$mysecretsalt$qJbapG68nyRab3gxvKWPUcs2g3t0oMHSHMnSKecYNpSi3CuZm.GbBqXO8BE6EI6P1JUefhA0qvD7b5LSh./PU1"

##################################################################################################################################
##################################################################################################################################
##################################################################################################################################
##################################################################################################################################

## Playbooks
# General structure
  {
   GeneralInfo
   
   Task
   
   Handlers
  
  }
  

name is the key word to describe the details
ignore_errors: yes - key work at task level


ansible-playbook filename --syntax-check ## To check the syntax
ansible-playbook filename --check ## Dry run
ansible-playbook filename ## run 
ansible-playbook filename --tags=tagname ## run 

gateher_facts: no ## to disable the gathering part to avoid the network loading. In this case we can't use the default variables



################################################################################################
################################################################################################
################################################################################################

ansible client -m setup | grep -i ansible_

################################################################################################
################################################################################################
################################################################################################
## structured and shareable format of playbooks
ansible-galaxy role -h 
ansible-galaxy role init

## Galaxy - collection of role. https://galaxy.ansible.com/
ansible-galaxy role search keytosearch
ansible-galaxy role install authername.rolename ## install the role from web
ansible-galaxy role install authername.rolename  --role-path=/etc/cutomefolder to download the ansible roles from web

################################################################################
################################################################################
Ansible vault - password protection of ansible files

ansible-vault create filename.yaml

## to run this file as playbook, need to pass --ask-vault-pass
ansible-playbook filename.yml --ask-vault-pass

###########
awx - UI tower like application to manage from UI
