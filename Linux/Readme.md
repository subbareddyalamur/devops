# Linux

## Working with Hardware

## uname -r
   prints kernel version

    bob@caleston-lp10:~$ uname -r
    4.15.0-101-generic
    bob@caleston-lp10:~$ uname
    Linux

## dmesg

    # used to display messages from an area of the Kernel called Ring Buffer.
     dmesg | grep -i usb
      [    0.089982] ACPI: bus type USB registered
      [    0.089982] usbcore: registered new interface driver usbfs
      [    0.089982] usbcore: registered new interface driver hub
      [    0.089982] usbcore: registered new device driver usb
      [    0.643529] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
      [    0.643544] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
      [    0.643555] uhci_hcd: USB Universal Host Controller Interface driver
      
## udevadm
    # management utility is a management tool for udev. udevadm info queries the udev db for device information
    
    udevadm info --query=path --name=/dev/sda5
    
## udevadm monitor
    # used to monitor events in hardware changes.
    
## lspci
    # lists PCI components on a system.
    bob@caleston-lp10:~$ lspci
    00:00.0 Host bridge: Intel Corporation 440FX - 82441FX PMC [Natoma] (rev 02)
    00:01.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II]
    00:01.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
    00:01.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 03)
    00:02.0 VGA compatible controller: Device 1234:1111 (rev 02)
    00:03.0 Ethernet controller: Red Hat, Inc. Virtio network device
    00:04.0 Unclassified device [00ff]: Red Hat, Inc. Virtio RNG
    00:05.0 SCSI storage controller: Red Hat, Inc. Virtio block device
    00:06.0 SCSI storage controller: Red Hat, Inc. Virtio block device
    00:07.0 SCSI storage controller: Red Hat, Inc. Virtio block device
    00:08.0 SCSI storage controller: Red Hat, Inc. Virtio block device
    
## lsblk
   lists information about block devices
    
    bob@caleston-lp10:~$ lsblk
    bob@caleston-lp10:~$ lsblk
    NAME                  MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
    fd0                     2:0    1     4K  0 disk 
    sr0                    11:0    1  1024M  0 rom  
    vda                   252:0    0   294G  0 disk 
    `-vda1                252:1    0   293G  0 part 
      |-host01--vg-root   253:0    0 194.4G  0 lvm  /etc/hosts
      `-host01--vg-swap_1 253:1    0   980M  0 lvm  [SWAP]
    vdb                   252:16   0    20G  0 disk 
    vdc                   252:32   0    20G  0 disk 
    vdd                   252:48   0    20G  0 disk 
    
  sda is a physical disk, sda1, sda2 ... sdan are partitions
  type DISK refers to whole physical disk
  type part refers to a reusable disk space carved out of physical disk

  MAj - major identifies the type of device driver associated with the device. the number 8 refers to a block scsi disk device
  MIN - minor used to differentiate amongst devices that are similar and share the same major number 

  Major number            -          Device Type
      1                   -             RAM
      3                   -           Hard Disk or CD ROM
      6                   -          Parallel Printers
      8                   -          SCSI Disk
          
## lscpu
   lists cpu information
   
     bob@caleston-lp10:~$ lscpu
      Architecture:        x86_64
      CPU op-mode(s):      32-bit, 64-bit
      Byte Order:          Little Endian
      CPU(s):              2
      On-line CPU(s) list: 0,1
      Thread(s) per core:  1
      Core(s) per socket:  1
      Socket(s):           2
      NUMA node(s):        1
      Vendor ID:           GenuineIntel
      CPU family:          6
      Model:               63
      Model name:          Intel(R) Xeon(R) CPU E5-1650 v3 @ 3.50GHz
      Stepping:            2
      CPU MHz:             3491.912
      BogoMIPS:            6983.82
      Hypervisor vendor:   KVM
      Virtualization type: full
      L1d cache:           32K
      L1i cache:           32K
      L2 cache:            4096K
      L3 cache:            16384K
      NUMA node0 CPU(s):   0,1
      Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon rep_good nopl xtopology cpuid tsc_known_freq pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm cpuid_fault invpcid_single pti ssbd ibrs ibpb stibp fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt arat md_clear
## lsmem
   lists memory info
   
    bob@caleston-lp10:~$ lsmem 
    RANGE                                  SIZE  STATE REMOVABLE BLOCK
    0x0000000000000000-0x0000000007ffffff  128M online        no     0
    0x0000000008000000-0x000000002fffffff  640M online       yes   1-5
    0x0000000030000000-0x0000000037ffffff  128M online        no     6
    0x0000000038000000-0x000000006fffffff  896M online       yes  7-13
    0x0000000070000000-0x000000007fffffff  256M online        no 14-15
    0x0000000080000000-0x000000009fffffff  512M online       yes 16-19
    0x00000000a0000000-0x00000000bfffffff  512M online        no 20-23
    0x0000000100000000-0x0000000107ffffff  128M online       yes    32
    0x0000000108000000-0x000000010fffffff  128M online        no    33
    0x0000000110000000-0x000000011fffffff  256M online       yes 34-35
    0x0000000120000000-0x0000000127ffffff  128M online        no    36
    0x0000000128000000-0x000000012fffffff  128M online       yes    37
    0x0000000130000000-0x000000013fffffff  256M online        no 38-39
    Memory block size:       128M
    Total online memory:       4G
    Total offline memory:      0B
    bob@caleston-lp10:~$ lsmem --summary
    Memory block size:       128M
    Total online memory:       4G
    Total offline memory:      0B
    
## free -m
   lists total, used and free memory 
   -m in mega
   -g in giga
   
    bob@caleston-lp10:~$ free -m
                  total        used        free      shared  buff/cache   available
    Mem:           3944         512        2606           9         826        3195
    Swap:           979           0         979
    
## lshw
   detailed configuration of the machine.
   
    bob@caleston-lp10:~$ lshw
    WARNING: you should run this program as super-user.
    caleston-lp10               
        description: Computer
        width: 64 bits
        capabilities: smp vsyscall32
      *-core
           description: Motherboard
           physical id: 0
         *-memory
              description: System memory
              physical id: 0
              size: 3944MiB
         *-cpu:0
              product: Intel(R) Xeon(R) CPU E5-1650 v3 @ 3.50GHz
              vendor: Intel Corp.
              physical id: 1
              bus info: cpu@0
              width: 64 bits
              capabilities: fpu fpu_exception wp
              
 ## Boot Sequence :
     1. BIOS POST - power-on self test - loads and execute boot code from boot device located in the first sector of the hard disk. in linux boot file is on /boot
     2. GRUB2 - grand unified bootloader version 2 - provides user with boot screen often with multiple options to boot into such as Microsoft windows, Ubuntu etc when dual boot is configured. Once selection is made, boot loader loads Kernel into memory supplied with some parameters and hands over the control to the Kernel.
     3. Kernel - Kernel gets decompressed and get loaded into memory and start executing. During this phase kernel carries out tasks such as initializing hardware and memory management tasks. Once it is completely operational, Kernel looks for INIT process to run which sets up the user space and the processes need for the user ennironment. INIT function then calls the systemd daemon which is reponsible for bringing the linux host to usable state. 
     4. INIT Process (Systemd) - responsible for mounting the file systems, starting and managing system services. To check the init system used, run "ls -l /sbin/init"
     root@51087e04132a:/home# ls -l /sbin/init
      lrwxrwxrwx 1 root root 20 May 27 22:16 /sbin/init -> /lib/systemd/systemd
      
## Runlevels - systemd targets:
    During boot, INIT process checks the runlevel. It makes sure that all programs need to get the system operational in that mode or started. In systemd, runlevels are called targets.
    
    Runlevel   -     systemd targets      -     Function
       5       -     graphical.target     -     Boots into GUI
       3       -     multiuser.target     -     boots into CLI
    
    Viewing and changing systemd targets:
      root@51087e04132a:/home# systemctl get-default
      graphical.target
      
      above command looks up to info from file located at 
      ls -ltr /etc/systemd/system/default.target
      /etc/systemd/system/default.target -> /lib/systemd/system/graphical.target
      
      change default from graphical to multi-user.
      [~]$ systemctl set-default multi-user.target
      Created symlink /etc/systemd/system/default.target → /lib/systemd/system/multi-user.target
     
## File types:

   **Everything is a file in linux**
   
    1. Regular file
    2. Directory
    3. Special files
      . Character files - represent devices under /dev file system 
      . Block files - represent block devices also located under /dev (ex: see lsblk output). block device reads from and writes to a device in blocks or a chunk of data. (ex. HDD, RAM)
      . Link files - Hard links (same block of data however they bahave independent) and soft links (shortcut to a file)
      . Socket files - enables comms between processes.
      . Named pipes - allows connecting one process as input to another process. data flow is unidirectional from 1st process to 2nd.
      
   **Identifying file types:**
   
      | File Type       | Identifier |
      | :-------:       | :--------: |
      | DIRECTORY       |     d      |
      | REGULAR FILE    |     -      |
      | CHARACTER DEVICE|     c      |
      | LINK            |     l      |
      | SOCKET FILE     |     s      |
      | PIPE            |     p      |
      | BLOCK DEVICE    |     b      |

## File system:

  **df -hP**
  
      root@51087e04132a:/home# df -hP
      Filesystem      Size  Used Avail Use% Mounted on
      overlay         251G  1.8G  237G   1% /
      tmpfs            64M     0   64M   0% /dev
      tmpfs           6.2G     0  6.2G   0% /sys/fs/cgroup
      shm              64M     0   64M   0% /dev/shm
      E:\             364G   56G  308G  16% /home/tf
      /dev/sdc        251G  1.8G  237G   1% /etc/hosts
      tmpfs           6.2G     0  6.2G   0% /proc/acpi
      tmpfs           6.2G     0  6.2G   0% /sys/firmware
   
**File system hierarchy:**

 - /home - home directories for all users except for root user. Root user's home directory is /root
 - /opt  - if we want to install any 3rd party softwares, we put them in /opt filesystem. 
 - /mnt  - is used to mount file systems temporarily in the system.
 - /tmp  - is used to store temp data.
 - /media - all external media is mounted under /media file system.

       df -hP  - # prints information about all mounted file systems.

 - /dev  - contains special block and character device files. contains files for devices such as external harddisks and mouse, keyboards.
 - /bin  - basic programs in binary such as cp, mv, date, mkdir are located here.
 - /etc  - very imp dir. used to store most of the config files in linux
 - /lib and /lib64  - place to look for shared libraries to be imported into programs
 - /user  - in older system this is used for user home directories. in modern systems, it is location where all user land applications and their data reside. ex: thunderbird email client, firefox, vi editor.
 - /var  - directory to which system writes data such as logs and cached data. 
  
## Package Management:

   A package manager is a software in a Linux system that provides a consistent and automated process of installing, upgrading, configuring and removing packages from the operating system. Some of the essential functions of a package manager are ensuring the intergrity and authenticity of the package by verifying thier digital certificates and checksums, simplifying the entire package management process, grouping packages by function to reduce user confusion, managing dependencies to ensure a package is installed with all packages it requires this avoiding what is commonly known as dependency hell.

   **Types:**

 - dpkg    : base package manager for debian based distributions.
 - apt     : a newer front end for the dpkg system.
 - apt-get : traditional front end for the dpkg system.
 - rpm     : base package manager for Red hat based distributions.
 - yum     : a front end for the rpm system.
 - dnf     : a more feature rich front end for rpm system.
  
## RPM

   **RPM Modes:**

   RPM database stores information about all RPM packages installed in the system. It is stored in /var/lib/rpm directory. It is used to query what packages are installed, what versions each package is, and any changes to any files in the package since installation.

   - Installing    : rpm -ivh telnet.rpm
   - Uninstalling  : rpm -e telnet.rpm
   - Upgrade       : rpm -Uvh telnet.rpm
   - Query         : rpm -q telnet.rpm
   - Verify        : rpm -Vf <path to file>

   #### RPM does not resolve package dependencies on its own, that's why we make use of a higher level package manager called YUM.
   #### YUM stands for Yellowdog Updater Modified.
   #### YUM works with software repositories and provides package dependency management. The repository information is stored in /etc/yum.repos.d and the repository files have a .repo extension.
   #### It acts as a high level package manager, but under the hood, it still depends on RPM to manager packages in Linux system. Unlike RPM, YUM handles packages dependencies very well. Its able to install any dependent packages to get the base package installed on the system. 

**Sequence of steps involved in package installation:**
   
   - Once a YUM install command is issued, YUM first runs a transaction check if the package is not installed in the system. YUM checks the configured repositories under repos.d directory for the availability of the requested package. It also check if the dependent packages are already installed in the system or if it needs to be upgraded. 
   - Next, a transaction summary is displayed on the screen for the user to review. If we wish to proceed with the install enter the Y button. YUM will download and install the necessary RPMs to the system.
   
**Common YUM commands**
   
   - yum repolist    : show all the repos added to the system.
   - yum provides    : if you want to check which package should be installed for a specific command to work, use this command with the command name as argument
                        ex: "yum provides scp" 
   - yum install     : to install a package
   - yum remove      : to remove a package
   - yum update <packagename>      : to update a single package.
   - yum update      : to update all the packages in the system.
   
## DPKG - Debian Package Manager
   
   **DPKG Modes**
   
   - Intall/upgrade    : dpkg -i telnet.deb
   - uninstall         : dpkg -r telnet.deb
   - list              : dpkg -l telnet.deb
   - status            : dpkg -s telnet.deb
   - verify            : dpkg -p <path to file>
   
   ## apt (advanced package managers) / apt-get
      
      - apt update         : refresh the repository. it downloads package information from all available sources.
      - apt upgrade        : used to install available upgrades of all packages currently installed on the system.
      - apt edit-sources   : opens up /etc/apt/sources.list file. used to update repositories.
      - apt search         : to search a package in repository. ex: "apt search telnet"
      - apt install        : install packages
      - apt remove         : removes packages
      - apt list           : list all available packages. ex: " apt list | grep telnet"
   
   apt is advanced compare to apt-get.
   
## File Compression and Archival
   
    du -sk <file name>  # shows the size of the file in KBs.
    du -sh <file name>  # prints size of file in human readable format.
    ls -lh <file name>  # also prints size of file along with permissions. 
   
    # Archive multiple files in single file
    # tar = Tape Archive. Files created with tar are often called tarballs.
    tar -cf test.tar file1 file2 file3
    
    - -c   : used to create an archive
    - -f   : used to specify the name of tar file to be created.
    - -tf  : used to see the contents of tar file.
    - -xf  : used to extract contents from tarball.
    - -zcf : also used to archive files. this reduces the size of tar file.
 
 **Compressing files**
   
    bzip2 test.img --> test.img.bz2
    gzip test.img --> test.img.gz
    xz test.img --> test.img.xz
   
 **Uncompressing files**
   
    bunzip2 test.img.bz2 --> test.img
    gunzip test.img.gz --> test.img
    unxz test.img.xz --> test.img
    
 **Searching for Files and Directories**
   
    # locate command returns all paths matching the pattern of file name. This used mlocate.db database so in order for locate command to return correct data, mlocate.db should be updated with "updatedb" command and then run locate command to yield correct results. works only with root user or sudo.
    locate <file name>
   
    # find command 
    find <directory> -name <filename>
    eg: find /home/bob -name city.txt
   
    # grep - to search within files and command output. It prints lines of a file mathcing a pattern.
    grep <pattern> <filename>
    eg: grep resource main.tf
   
    grep --> case sensitive.
    grep -i --> case insensitive.
    grep -r --> search for a pattern recursively within a directory.
    eg: grep -r "third line" /home/bob
    grep -v --> prints line that don't match the pattern.
    grep -w --> to search for whole word. doesn't print other lines which contains the pattern as substring in a string.
    grep -A1 --> prints a line containing pattern along with a line below the matching line. 1 refers to n-th number from matching line.
    grep -B1 --> prints a line containing pattern along with a line before the matching line.
   
    zcat is used to read files in archive.
    zcat /usr/share/man/man1/tail.1.gz | tee /home/bob/pipes
   
   
**IO Redirection**
   
    >   :  redirects command output to a file. also overwrites contents if used mutiple times on a single file.
    eg: echo $SHELL > shell.txt
   
    >>  : redirects command output to a file. appends to file content if used multiple times.
    eg: echo $SHELL >> shell.txt
    
    2>  : redirects only error messages from stdout to a file.
    eg: cat missing_file 2> error.txt
   
    2>> : append error to exiting file
    eg: cat missing_file 2>> error.txt
   
    If you want your command to execute and not print error messages on screen, even if it generates a standard error, you can redirect to /dev/null.
    eg: cat missing_file 2> /dev/null      # /dev/null is a place where you dump anything you don't want.
   
**Command Line pipes**
   
  #### Pipe
   
    They allow linking of multiple commands. Pipes allow the first command's standard output to be used as the standard input for the second command. Pipes can be used as many times as needed as long as the command are used with correct syntax.
    eg: cat /etc/os-release | grep NAME
    
  #### tee
   
    tee command is used to print standard output before redirecting to a file.
    eg: echo $SHELL | tee shell.txt
          /bin/bash
    
    tee -a  : to append the file
    eg: echo $SHELL | tee -a shell.txt
    
## vi editor
   
 - command mode  : when you open a file with vi, file opens in command mode by default. you can issue copy, past, delete a word/line in this mode.
   
    - yy  : to copy a line in command mode, place the cursor on the line and issue "y" 2 times.
    - p   : to paste a line in command mode, move the cursor above the line where you want to paste and issue "p".
    - ZZ  : to save the file, use upper case "Z" 2 times.
    - X   : to delete a letter, move the cursor to the intended position and press X.
    - dd  : to delete a line, move the cursor to the intended line and press "d" 2 times.
    - u   : to undo previous change
    - r   : to redo the change again
    - / or ? : to find a string use "/" followed by the pattern you want to search. to find next occurence press "n", to find previous occurence press "N". "?" will act viceversa i.e search starts from bottom to top. "n" upwards and "N" downwards.

 - insert mode   : press "i" 

 - last line mode: from command mode press ":" to go to last line mode. In this mode you can choose to save changes to the file or discord or save and exit.
   
    - :w     :  to save
    - :q     :  to quit
    - :wq    : save and quit
    - :q!    : quit without confirmation
   
## Security and File permissions
   
   **Linux Security**
   
 - Access Controls   : make use of user and password based authentication to determine who can access the systems.
 - PAM               : Pluggable Authentication Model, used to authenticate users to programs and services in linux.
 - Network Security  : used to restrict or allow access to services listening on linux server by making use of tools such as IPTables and Firewalld.
 - SSH Hardening     : Secure Shell, used for remote access to a server over an unsecured network. SSH hardening can help make sure only the authorized users gain access to server. 
 - SELinux           : makes use of security policies for isolating applications running on the same system from each other to protect the server.
 - many more
   
 **Linux Accounts**
  
    To check user id and group id of a particular user
    $ id <username>

    subbu@subbu:~$ id subbu
    uid=1000(subbu) gid=1000(subbu) groups=1000(subbu),4(adm),20(dialout),24(cdrom),25(floppy),27(sudo),29(audio),30(dip),44(video),46(plugdev),117(netdev)

    To check the home directory path and the dafault shell assigned to the user
    subbu@subbu:~$ grep -i subbu /etc/passwd
    subbu:x:1000:1000:,,,:/home/subbu:/bin/bash
   
    id   : gives info about specific user. eg: id <username>
    who  :  To see the list of users currently logged in
    last : to display all logged in users.
    su - : to switch to other user in the system.
    sudo : sudo offers another approach to giving users administrative access. Default configuration for sudo is defined under /etc/sudoers file. This file defines the policies applied by the sudo command and can be updated using the "visudo" command. Only users listed in the /etc/sudoers file can make use of sudo command for privilege escalation. 
    
    ex: sudoers file
    # Allow bob to run any command
    bob ALL=(ALL:ALL) ALL
    %admin ALL=(ALL) ALL
    # Allow Sarah to reboot the system
    sarah localhost=/user/bin/shutdown -r now
    # No login shell for root user. No one can login with root user and password directly.
    /root:x:0:0:root:/root:/usr/sbin/nologin
   
    # Sudo without password
    echo 'your_user_name_here ALL=(ALL) NOPASSWD: ALL'  >> /etc/sudoers
   
    % = groups begin with % symbol.
   
     | Field | File Type     | Identifier                 |
     |:-----:| :-----------: | :-----------------------:  |
     |   1   | User or Group | bob, %sudo (gruoup)        |
     |   2   |    Hosts      | localhost,ALL(default)     |
     |   3   |    User       | ALL(default)               |
     |   4   |  Command      | /bin/ls, ALL(unrestricted) |   
         
 **Account Types**
   
      - User Account  
      - Superuser Account  :  ex: root. UID = 0
      - System Accounts    :  ex: mail, ssh. UID < 100 or between 500-1000
      - Service Accounts   :  similar to system accounts and created when services are installed in linux. ex: nginx make use of service account called nginx.

**Managing Users**

   ## useradd                                                   
                                                      
    root@acf94a04e711:/# useradd bob
                                                      
    root@acf94a04e711:/# grep -i bob /etc/passwd
    bob:x:1000:1000::/home/bob:/bin/sh
                                                      
    root@acf94a04e711:/# grep -i bob /etc/shadow
    bob:!:18836:0:99999:7:::
                                                      
    root@acf94a04e711:/# passwd bob
    New password:
    Retype new password:
    passwd: password updated successfully
                                                      
    # Add user with home directory
    useradd -m -d /PATH/TO/FOLDER USERNAME
                                                      
    useradd -u 1009 -g 1009 -d /home/rebert -s /bin/bash -c "ASR Project Member" bob
         -c    : Custom Comments
         -d    : custom home directory
         -e    : expiry data
         -g    : specific GID
         -G    : create user with multiple secondary groups
         -s    : specify login shells
         -u    : specific UID
                                                      
  ## userdel
                                                      
    userdel bob
                                                      
  ## groupadd
                                                      
    eg: groupadd -g 1919 avenger 
    root@acf94a04e711:/# grep -i avenger /etc/group
    avenger:x:1919:                                                  
         
  ## groupadel
    eg: groupdel avenger
                                                      
**Access Control Files** 
                                                      
      root@acf94a04e711:/# grep -i bob /etc/passwd
      bob:x:1000:1000::/home/bob:/bin/sh
      
      username:Password:UID:GID:GECOS(CSV format of user info about location, full name etc):home directory:default shell                                                
                                                                                                            
      # User passwords are stored in /etc/shadow and are hashed.                                                
      root@acf94a04e711:/# grep -i ^bob /etc/shadow
      bob:$6$TVLnMGzKU9h1rB5C$FePh1mo4js6Bbx9yDJZrnok8AN3K.imJ.xnd2Sa0bZVHuWUhx1U5b1liLphdSMFLG8aDEInCvwgq2lG4Kv4db.:18836:0:99999:7:::
       
      USERNAME:PASSWORD:LASTCHANGE:MINAGE:MAXAGE:WARN:INACTIVE:EXPDATE                                                
                                                      
      root@acf94a04e711:/# grep -i ^bob /etc/group
      bob:x:1000:
      root@acf94a04e711:/#    
                                                      
      GROUPNAME:PASSWORD:GID:MEMBERS
                                                      
**File Permissions and Ownership**
                                                      
      # Linux file permissions
       - rwx rwx r_x
       
       "-" refers to file type
       first "rwx" refers to permissions for owner (u)
       second "rwx" refers to permissions for group (g)
       third "r_x" refers to permissions for others (o)
                                                      
       chmod 777 filename     # applies all permissions for all
       chmod u+rwxg+rwx0+x-rw  filename  # applies all permissions to owners and groups and execute permission to others and removed write and read permissions to others.
       
       chwon owner:group file       # change ownership of a file or dir
       chown bob:developer test-file   
       chown bob test-file
       chgrp admin test-file     # change group of a file or dir                     
                                                      
**SSH and SCP**
                        
   ## SSH Keys
                                                      
   SSH keys are used for passwordless authentication to remote linux servers. A private and public key (Key pair)are generated on the client machine using ssh-keygen command.
   Key Pair = Private key + Public key
   
   - Private key is the only key client (you) will have and not shared with anyone else.
   - Public key can be shared with others ex: remote servers
   
   When the public key is intalled on the remote server, you can unlock by connecting to it with the client that already has the private key.
   
   ## Generate SSH keys on client or (laptop)

      $ ssh-keygen -t rsa
      Generating public/private rsa key pair.
      Enter file in which to save the key (/c/Users/subba/.ssh/id_rsa):
      Created directory '/c/Users/subba/.ssh'.
      Enter passphrase (empty for no passphrase):
      Enter same passphrase again:
      Your identification has been saved in /c/Users/subba/.ssh/id_rsa
      Your public key has been saved in /c/Users/subba/.ssh/id_rsa.pub
      The key fingerprint is:
      SHA256:pqsBVGkOJWBCBF+LZALiWptmSaQh5MYPUmdB4biAz80 subba@DESKTOP-NJU6VGR
      The key's randomart image is:
      +---[RSA 3072]----+
      |/**oX+           |
      |XX.Xo.           |
      |=*B+o            |
      |+BoB.            |
      |. @.E   S        |
      | o .   o         |
      |    . .          |
      |     . .         |
      |    ...          |
      +----[SHA256]-----+
            
   Private key is saved in /c/Users/subba/.ssh/id_rsa
   Public key is saved in /c/Users/subba/.ssh/id_rsa.pub

   Copy publick key to remote server. On remote server keys are stored at /home/<username>/.ssh/authorized_keys

      ssh-copy-id bob@remoteserver

   Enter password for bob of the remote server. Once copied try logging into the server with command

      ssh bob@remoteserver
   
   ## SCP

   To copy files to remote server.

      scp <sourcefile> <remoteserver>:<destination>

      eg: scp /home/subbu/testfile.zip remotehost:/home/subbu
          scp /home/subbu/testfile.zip subbu@remotehost:/home/subbu

   To copy directories to remote server.

      scp -r /home/subbu subbu@remotehost:/home/subbu 

      # to preserve ownership information of source file use option -p

      scp -pr /home/subbu subbu@remotehost:/home/subbu 

  **Network Security - IP TABLES**

    Prerequisites to connect to remote server from client
    - Should have valid authentication mechanisms such as username and password or SSH Keys.
    - Network connection must be opened for port 22 from the client to the remote server.
    
    on Centos/RedHat linux, iptables is installed by default however its not installed on ubuntu linux. To install iptables on ubuntu, run

      sudo apt install iptables

   To list default rules or chains

      sudo iptables -L

   Rule or Chain can have multiple rules within them (chain of rules). Each rule perfroms a check and accepts or drops packet based on the condition.
   We have 3 types of rules or chains configured by default, INPUT, FORWARD and OUTPUT.
   - INPUT is applicable to network traffic comming into the system.
     ex: to allow ssh connection from the client
   - OUTPUT is responsible for connections initiated by the server to other servers.
     ex: when application server connects to Database server to write/query data.
   - FORWARD is used in network routers where the data is forwarded to other devices in the network. Not commonly a in linux server

   Allowing a source IP to listen on port 22.

      iptables -A INPUT -p tcp -s <source IP> --dport 22 -j ACCEPT
      iptables -A INPUT -p tcp -j DROP  # reject all incoming traffic.
      iptables -A OUTPUT -p  tcp -j DROP #reject all outgoing traffic.

       -A : Add Rule
       -p : Protocol
       -s : Source
       -d : Destination
       -j : Accept or Drop
       --dport : Destination port
       -I : Inserts the rule at the top of the chain. 
       -D : To delete a rule

       iptables -D INPUT/OUTPUT <line number>

       ex: iptables -D INPUT 2

  ## Cron Jobs

   Used to run scheduled jobs.

      for example, required to check system uptime every day at 9 AM by running "uptime >> /tmp/system-report.txt"

      m h  dom mon dow   command
      minute hour day month weekday  command

      4  11 *  *  *  uptime >> /tmp/system-report.txt

  ## Networking

   **DNS**
      #system local DNS - /etc/hosts
      
      root@acf94a04e711:/# cat /etc/hosts
      127.0.0.1       localhost

    When the environment grows, /etc/hosts will be filled with too many entries and needs to be updated in all other servers. So managing these becomes too hard. If one the server's IP changed, you would need to modify the entries in all of the hosts. Hence we have solution called DNS, which can be used to centrally manage in a single server. We point all hosts to lookup that server if they need to resolve a hostname to an IP address instead of its own /etc/hosts file.

   **/etc/resolv.conf**
    
    Every host has a DNS resolution configuration file at /etc/resolv.conf, we add an entry into this file specifying the DNS server to point to as below in all hosts.

      subbu@DESKTOP-NJU6VGR:~$ cat /etc/resolv.conf
      search google.com  # search domain used to resolve any subdomain. eg: ping mail will lookup, mail.google.com
      nameserver 192.168.1.95

    Once its configured, everytime a host comes across a hostname that it does not know about, it looks it up from the DNS server. If IP of any of the hosts is changed, simply update the entry in DNS server and all hosts should resolve the new IP address going forward.

   **/et/nsswitch.conf**

    local /etc/hosts file will take precedence and then the DNS by default. This can be changed in /etc/nsswitch.conf file.

      subbu@DESKTOP-NJU6VGR:~$ cat /etc/nsswitch.conf | grep hosts
      hosts:          files dns

    Edit the file and update dns first and then files.

   **nslookup**

    use NSLOOKUP to verify dns resolution if ping is not available. 

      subbu@DESKTOP-NJU6VGR:~$ nslookup www.google.com
      Server:         192.168.1.95
      Address:        192.168.1.95#53

      Non-authoritative answer:
      Name:   www.google.com
      Address: 216.58.196.164
      Name:   www.google.com
      Address: 2404:6800:4007:819::2004
   
   **dig** 

    Another tool to test dns name resolution.

      subbu@DESKTOP-NJU6VGR:~$ dig www.google.com

      ; <<>> DiG 9.16.1-Ubuntu <<>> www.google.com
      ;; global options: +cmd
      ;; Got answer:
      ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 23650
      ;; flags: qr rd ra ad; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0

      ;; QUESTION SECTION:
      ;www.google.com.                        IN      A

      ;; ANSWER SECTION:
      www.google.com.         60      IN      A       216.58.196.164

      ;; Query time: 5 msec
      ;; SERVER: 192.168.1.95#53(192.168.1.95)
      ;; WHEN: Thu Jul 29 17:00:07 IST 2021
      ;; MSG SIZE  rcvd: 48

   **Switching**

    A switch creates a network containing two or more systems. To connect a server to switch, we need an interface on each server physical or virtual. To see the interfaces for the host we use th e "ip link" command.

      subbu@DESKTOP-NJU6VGR:~$ ip link
      18: eth0: <> mtu 1500 group default qlen 1
         link/ether 9c:b6:d0:f7:f2:10
   
   ![image](https://user-images.githubusercontent.com/35358560/127599056-095ded03-a3bd-4f57-bcae-846c27ad2903.png)

   **Routing**

   ![image](https://user-images.githubusercontent.com/35358560/127599359-b1b4534f-186a-45f7-8cd9-eb83d88b46d3.png)

    If a network is a room, gateway is the door to outside world.
   
   **Gateway**
   
   ![image](https://user-images.githubusercontent.com/35358560/127599857-2d1099e2-f7ba-46a3-992f-f1401b7a4e37.png)
   
   Adding a route to internet via gateway.

   ![image](https://user-images.githubusercontent.com/35358560/127599951-f62d762f-2347-46d1-a65c-5afef7ea02dd.png)
   
   Add routes via default gateway.
   
   ![image](https://user-images.githubusercontent.com/35358560/127600105-7f7f269e-261c-4e84-9248-a8e345bb4ffe.png)
   
      - ip link      :  list and modify interfaces on the host.
      - ip link set dev eth0 up : to bring up the interface.
      - ip addr      :  to see the ip addresses assigned to the interfaces.
      - ip addr add  :  used to add IP addresses on the interfaces.
         eg: ip addr add 192.168.1.10/24 dev eth0
   
   Changes made using these commands are only valid till a system restart. If you want to persist these changes you must set them in the /etc/networks/interfaces file.
   
      - ip route/route     :  used to see the routing table.
      - ip route add       :  used to add entries to the routing table.
         eg: ip route add 192.168.1.0/24 via 192.168..2.1

   **Troubleshooting Network**
    
    - Connection Timeout Error: 
         - Could be an issue with local interface not being connected to the network.
         - Could be a server not resolving the IP address of the hostname you are trying to connect to.
         - Could be an issue with the route to the server.
         - Could be an issue with the server itself. May be the server itself has connectivity issue.
         - Software that hosts the service is not functioning correctly.

    Steps:

      - Start with hosts IP connectivity. check local interface by running "ip link" and ensure primary interface is up.
      - Check if you can resolve a hostname to an IP address. Run nslookup against a hostname and make sure it is resolving to a valid IP.
      - Try to ping the remote server to check if we get a response. Ping is not a best tool to check connectivity as many networks would have disabled it.
      - To troubleshoot an issue with route, run the traceroute, which will show number of hops/devices between the source and destination. It will also show if there is a problem with any of the devices in the network route. 
      - On the other end (server hosting the service), check if the http process is running on specified port.
         eg: netstat -an | grep 80 | grep -i LISTEN
         netstat can be used to print the information of network connections, routing tables and several other network statistics.
      
## Storage

 To see the list of block devices on a server, run "lsblk" command.

 ![image](https://user-images.githubusercontent.com/35358560/127671207-dde6e1a6-705f-4adb-9311-5a88aa8ca0fc.png)

 ![image](https://user-images.githubusercontent.com/35358560/127671424-fc67cefc-d3f6-43fa-957f-f550cc25de65.png)
   
To print the partition table, use "fdisk" command.

 ![image](https://user-images.githubusercontent.com/35358560/127674237-b0b673ad-2ec2-4f27-8c2c-c08b176a1aae.png)

**Partition Types**

 - Primary     : used to boot an operating system.
 - Extended    : cannot be used on its own but can host logical partitions.
 - Logical     : are created within an extended partition.

**Partition Scheme**
 
 How a disk is partitioned is defined by a partitioning scheme also know as partition table. 

 - MBR : Master Boot Record. There can only be 4 primary partitions in MBR. The maximum size per partition is 2 TB. If we want more partitions, we would need to create the 4th partition as an extended partition and carve out logical partitions within it. 

 - GPT : GUID Partition Table. created to address the limitations in MBR. It can have unlimited primary partitions. No max size per partition. 
 
![image](https://user-images.githubusercontent.com/35358560/127958698-e1bb2640-1f68-4270-ba79-9a670eb36487.png)

**Creating Partitions**
 
 ![image](https://user-images.githubusercontent.com/35358560/127958981-8bd6ae3d-a670-4f45-a591-117384c4bf7b.png)
  
 ![image](https://user-images.githubusercontent.com/35358560/127959234-c7a1f991-d143-425e-81d1-b13b118b7466.png)
   
## File Systems 

 Partitioning alone does not make a disk usable in the OS. The disk in the partitions are seen by the kernel as a raw disk. To write to a disk or a partition we must first create a file system which defines how data is stored on a disk. After creating a file system we must mount it to a directory, that's when we can read or write data to it. 
  
![image](https://user-images.githubusercontent.com/35358560/127961797-ad778a86-b1db-4635-afca-540d20f4e7d0.png)

![image](https://user-images.githubusercontent.com/35358560/127961930-27a7321e-2e2e-4186-aaff-0fa170f1d823.png)
   
**fstab**

 To make this mount be available after the system reboots, add an entry to the /etc/fstab file. 

      echo "/dev/sdb1 /mnt/ext4 ext4 rw 0 0" >> /etc/fstab

   1. File system
   2. Mountpoint
   3. Type
   4. Options Such as RW=read-write, RO=read-only
   5. Dump 0 = ignore, 1 = take backup
   6. Pass o = ignore, 1 or 2 = FSCK filesystem check enforced.

## Usefull Commands

  **iNode**
   
   It's a data structure which stores the file/directory information. iNode address is fixed.

    ls -li
    281474976712015 drwxrwxrwx 1 root root 4096 Sep  7 10:58 file1
    281474976712018 drwxrwxrwx 1 root root 4096 Sep  7 10:58 dir1
    281474976712686 drwxrwxrwx 1 root root 4096 Sep  7 10:58 file2

  **Commands**

   cd ~  : to go to user's home directory

   cd    : to go to user's home directory

   cd -  : to go to previous working directory

   cd .. : to go to one directory backwards

   file filename : gives the type of filename

   wc    : gives number of lines, words and characters in a file. options to use wc -l, wc -w, wc -c.

   sort  : sorts text in a file in ascending order. sort -r for descending order.

   tr    : translate text ex: lower case to upper case. tr [a-z] [A-Z]

   who   : [ec2-user@ip-172-31-38-11 ~]$ who \n
            ec2-user pts/0        2021-09-12 16:25 (160.238.74.205)

   who -H : [ec2-user@ip-172-31-38-11 ~]$ who -H \n
            NAME     LINE         TIME             COMMENT
            ec2-user pts/0        2021-09-12 16:25 (160.238.74.205)

   uptime : [ec2-user@ip-172-31-38-11 ~]$ uptime \n
            16:28:15 up 3 min,  1 user,  load average: 0.04, 0.03, 0.00

   users  : [ec2-user@ip-172-31-38-11 ~]$ users \n
            ec2-user

   whereis : [ec2-user@ip-172-31-38-11 ~]$ whereis sudo \n
             sudo: /usr/bin/sudo /etc/sudo.conf /usr/libexec/sudo /usr/share/man/man8/sudo.8.gz

   df -h   : [ec2-user@ip-172-31-38-11 ~]$ df -h \n
                Filesystem      Size  Used Avail Use% Mounted on \n
                devtmpfs        482M     0  482M   0% /dev \n
                tmpfs           492M     0  492M   0% /dev/shm \n
                tmpfs           492M  400K  492M   1% /run \n
                tmpfs           492M     0  492M   0% /sys/fs/cgroup \n
                /dev/xvda1      8.0G  1.5G  6.6G  19% / \n
                tmpfs            99M     0   99M   0% /run/user/1000 \n

   du -h   : [ec2-user@ip-172-31-38-11 home]$ du -Sh \n
                4.0K    ./ec2-user/.ssh \n
                12K     ./ec2-user \n
                0       .

   du -sh  : [ec2-user@ip-172-31-38-11 home]$ du -sh ~ \n
                16K     /home/ec2-user
   