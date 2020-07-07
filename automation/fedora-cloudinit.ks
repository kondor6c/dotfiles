#version=DEVEL
ignoredisk --only-use=nvme0n1
autopart --type=lvm
# Partition clearing information
clearpart --all --initlabel --drives=nvme0n1
# Use graphical install
text
# Keyboard layouts
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8

# Network information
network  --hostname=template.localnet
# Root password
rootpw --iscrypted $6$PmSrWdnKWwbmOuKU$l.gW4aT5WRzy1Q9Zl6hVrIs6vRf1BSeQeIJrfATiDqQNZiHoHDna37ATD4gGoqDy2Iu3/cMQ2v9pFWzV2WTDp/
# Run the Setup Agent on first boot
firstboot --enable
# System services
services --enabled="chronyd"
# System timezone
timezone America/New_York --isUtc
user --groups=wheel --name=kondor6c --password=$6$KL3kgNPEx9hClOBJ$kR4ZlLM6o9dmxt13mL7zNP1KpiiSzWptpmKPy0oiy9kbOqiW07pHJHwRlQ9hnLimOaSrIiP0Go6fab82PnwhG1 --iscrypted --gecos="kondor6c"

%packages
@^kde-desktop-environment
@firefox

%end

%addon com_redhat_kdump --disable --reserve-mb='128'

%end

%anaconda
pwpolicy root --minlen=6 --minquality=1 --notstrict --nochanges --notempty
pwpolicy user --minlen=6 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy luks --minlen=6 --minquality=1 --notstrict --nochanges --notempty
%end
