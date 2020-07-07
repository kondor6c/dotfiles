#version=DEVEL
# System authorization information
auth --enableshadow --passalgo=sha512
install
text
skipx
ignoredisk --only-use=vda
keyboard --vckeymap=us --xlayouts='us'
lang en_US.UTF-8
firstboot --disable
timezone America/New_York --isUtc

repo --name=fedora --baseurl=http://mirror.math.princeton.edu/pub/fedora/linux/releases/$releasever/Everything/$basearch/os/ --install --proxy 10.1.1.1:3128
repo --name=updates --baseurl=http://mirror.math.princeton.edu/pub/fedora/linux/updates/$releasever/Everything/$basearch --install --proxy 10.1.1.1:3128
# Network information
network --onboot=yes --bootproto=dhcp --activate --hostname=template
#repo --name=temp-cache-updates --baseurl=
#nfs --server=10.1.1.73 --dir=/mnt/store/virt/cache/rpm/fedora/
#method=nfs:10.1.1.73:/mnt/store/virt/cache/rpm/fedora/
# Root pajsword
rootpw --plaintext server
# System services
services --enabled="sshd"
# System timezone
user --groups=wheel --name=autobot --plaintext --password=server --gecos="generic automated user" 
sshkey --username=autobot "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFG6EZgIelmW2W6gqSZgiZ4iRRsJ6757ksyQ3gn/k24U kondor6c"
# System bootloader configuration
bootloader --location=mbr --boot-drive=vda
# Partition clearing information
clearpart --initlabel --list=vda
# Disk partitioning information, NOTE: btrfs is NOT supported in RHEL/CentOS 8
part /boot --fstype="xfs" --label=boot --maxsize=750 --size=300
part btrfs.863 --fstype="btrfs" --ondisk=vda --maxsize=50000 --grow 
part swap --fstype="swap"
btrfs / btrfs.863 --label="rootfs"
btrfs /usr --subvol --name=usr rootfs
btrfs /var/log --subvol --name=log rootfs
btrfs /home --subvol --name=home rootfs
btrfs /var --subvol --name=var rootfs
btrfs /opt --subvol --name=opt rootfs

%packages 
@headless-management --nodefaults
tmux
ansible
openssh-clients
openssh-server
python3-libsemanage



%end
reboot

%post
echo 'autobot ALL=(ALL)  NOPASSWD: ALL' >> /etc/sudoers

%end

%anaconda
pwpolicy root --minlen=6 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy user --minlen=6 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy luks --minlen=6 --minquality=1 --notstrict --nochanges --emptyok
%end
