# Ethical Hacking



> 【Networking Basics】
>
> - [nc](https://linux.die.net/man/1/nc) - TCP and UDP connections and listens
>   - [Using netcat for file transfer](https://nakkaya.com/2009/04/15/using-netcat-for-file-transfers/)
> - [Some common ports](https://web.archive.org/web/20221204205438/https://web.mit.edu/rhel-doc/4/RH-DOCS/rhel-sg-en-4/ch-ports.html)
> - [ip](https://packetpushers.net/linux-ip-command-ostensive-definition/) - View and configure networking
> - [ss](https://www.binarytides.com/linux-ss-command/) - Socket statistics
> - [SSH](https://www.digitalocean.com/community/tutorials/ssh-essentials-working-with-ssh-servers-clients-and-keys#ssh-overview) - Secure shell
>   - [SSH Forwarding](https://www.ssh.com/ssh/tunneling/example) - Have a compromised system relay traffic on your behalf
>   - [SCP](https://net2.com/how-to-use-scp-command-to-transfer-files-securely-using-ssh-on-linux/)  - File copying over SSH
>
> 【Web Basics】
>
> - [curl](https://curl.se/docs/manpage.html) - Web requests from the command line.
> - [wget](https://www.gnu.org/software/wget/manual/wget.html) - Download web content.
> - HTTP basics
>   - [HTTP status codes](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes)
>   - [HTTP methods](https://www.w3schools.com/tags/ref_httpmethods.asp) 
>   - [Python HTTP server](https://www.askpython.com/python-modules/python-httpserver) - quick setup for serving files from your system
> - Frontend basics
>   - [JavaScript basics](https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/JavaScript_basics)
>   - [HTML basics](https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/HTML_basics)
>   - [CSS basics](https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/CSS_basics)
> - [LAMP, MAMP, and WAMP](https://www.geeksforgeeks.org/what-is-the-difference-between-lamp-stack-mamp-stack-and-wamp-stack/)
>
> 【Linux Basics】
>
> - [Linux command line](https://github.com/CoordinatesNotFound/Technology-Stack/blob/main/OS/Linux/Linux%20Command%20Line.md)
> - [FHS](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard) - The filesystem hierarchy standard
> - [Bash shortcuts](https://kapeli.com/cheat_sheets/Bash_Shortcuts.docset/Contents/Resources/Documents/index)
>
> 【Windows Basics】
>
> - [Windows command line (cmd)](https://www.bleepingcomputer.com/tutorials/windows-command-prompt-introduction/)
>   - [cmd for pentesters](https://book.hacktricks.xyz/windows-hardening/basic-cmd-for-pentesters)
> - [The net command](https://www.lifewire.com/net-command-2618094)
> - [File and folder permissions](https://technet.microsoft.com/en-us/library/cc753525(v=ws.11).aspx)
> - [Windows root directory structure](https://en.wikipedia.org/wiki/Directory_structure)



## Intro to Hacking

- Hacking methodology:
  - **Reconnaissance** - Indirect information gathering
  - **Scanning/enumeration** - Direct information gathering
  - **Vulnerability identification**
  - **Exploitation** - The hack itself
  - **Post-exploitation**







## Scanning and Enumerating Networks

- Scanning and enumerating networks
  - What IP addresses or IP ranges do I have to start with?
  - When exploring networks, where are the systems or devices?
    - What are their IP addresses?
  - What kind of systems or devices am I looking at?
  - What kind of services are running on the systems?
    - What are the ports?
    - How can you interact with them?

- Common tools

  - [nmap](https://nmap.org/book/toc.html) - Network scanning and services discovering

    > It does not seem to function properly when granted root privileges in the virtual world. This has the unintuitive effect that scanning works as expected when logged on as an unprivileged user but may fail when logged on as a superuser, e.g., root. To avoid this, either make sure that you scan from an unprivileged account or try also scanning with the following flag when scanning as root: `-sT` (scan ports using TCP connect)

  - [nc](https://linux.die.net/man/1/nc) - Speak to services (or clients) over TCP and UDP, making it useful for banner grabbing, among other things. 



## Password Cracking

- Password cracking
  - When a system or service prompts you to log in, a common weakness is that they allow unlimited or very generous amounts of attempts to guess usernames and passwords. This means we can keep guessing until we get it right and are granted access.
  - Cracking strategy
    - **Brute force cracking**: exploiting unlimited guesses by systematically testing all possible symbol combinations
    - **Dictionary attack**: where we exploit biases in user-created passwords by systematically trying a list of prepared passwords. These password lists, called dictionaries, can consist of common words (password123), convenient key combinations (qwerty), default credentials (admin:admin), and previously leaked passwords,
- Common tools
  -  [THC Hydra](https://github.com/vanhauser-thc/thc-hydra) - Conduct dictionary attacks
  - Good dictionaries
    - [Mirai botnet dictionary](https://github.com/danielmiessler/SecLists/blob/master/Passwords/Malware/mirai-botnet.txt) - Recommended
    - [RockYou dictionary](https://github.com/danielmiessler/SecLists/blob/master/Passwords/Leaked-Databases/rockyou.txt.tar.gz) - A CTF classic, recommended if all others fail
    - [Lists in Kali Linux](https://www.kali.org/tools/wordlists/)





## Hash Cracking

- Hash cracking
  - systems rarely store passwords in plain text. What you will typically find instead are password hashes created by a hash function. Hash functions are one-way functions that take input, such as a password, and produce a string called the hash. For a well-constructed hashing function, it is impossible to compute the password from its hash, hence the term one-way function. 
  - **Rainbow table attack**
    - To pre-compute a lookup table with hash values and corresponding passwords, sidestepping the expensive hash calculation. These pre-computed lists are called rainbow tables.
  - Linux passwords and hashes
    - [/etc/passwd](https://linuxize.com/post/etc-passwd-file/)
    - [/etc/shadow](https://linuxize.com/post/etc-shadow-file/)
  - [Windows password hashes](https://medium.com/@petergombos/lm-ntlm-net-ntlmv2-oh-my-a9b235c58ed4)

- Common tools
  - [John The Ripper](https://www.freecodecamp.org/news/crack-passwords-using-john-the-ripper-pentesting-tutorial/)





## Web Hacking

- Web hacking
  - What software is running on the system?
    - Map and note information such as the web server, database, frameworks, and version numbers.
  - What kind of web pages exist?
    - Are there hidden pages or other invisible content?
  - What is the structure of the application or web site?
  - How does the application seem to function and communicate overall?
  - Are there login forms anywhere?
  - Where can you otherwise interact with the application?
    - forms
    - search bars
    - uploads
    - text fields
    - API endpoints
- Common tools
  -  [GoSpider](https://github.com/jaeles-project/gospider) - Web crawling
  -  [GoBuster](https://github.com/OJ/gobuster) - Content discovery 
  -  [OWASP on SQL injection](https://owasp.org/www-community/attacks/SQL_Injection) - SQL Injection





## Remote Exploitation

- Remote exploitation
  - the remote exploitation of a vulnerability and the subsequent establishment of a remote **reverse shell**, granting the attacker unbounded access to the compromised machine

- Common tools
  - [Metasploit](https://www.metasploit.com/) - The most well-known exploitation framework
    - [Meterpreter](https://www.offsec.com/metasploit-unleashed/meterpreter-basics/) - Malicious shell
    - [Msfconsole](https://www.offsec.com/metasploit-unleashed/msfconsole/) - interface
    - [msfvenom](https://www.offensive-security.com/metasploit-unleashed/msfvenom/) - Bersatile payload generator 
    - [Metasploit exploit database](https://github.com/rapid7/metasploit-framework/tree/master/modules/exploits) - Contains an even more comprehensive collection of exploits.
  - [Reverse Shell Cheat Sheet](https://swisskyrepo.github.io/InternalAllTheThings/cheatsheets/shell-reverse-cheatsheet/#ruby)



## Privilege Escalation

- Privilege escalation
  - Most possible way of post exploitation
  - The umbrella term for all the methods used to go from less control to more control in unintended ways, such as from a regular system user account to an all-powerful system administrator account.
  - Tricks
    - Simply log in as a privileged user, such as by guessing the password.
    - Stealing the credentials for a privileged user account.
    - Create a privileged user account, then log on.
    - Modify or insert new credentials for a privileged user account, then log on.
      - For example, plant your SSH key in the `authorized_keys` for another user, then log on.
    - Run and control an application with elevated privileges.
      - On Linux, remember to check your sudo privileges (`sudo -l`).
    - Directly supply code or commands to a privileged process, thereby taking control.
    - Trick a privileged application or process into executing code on your behalf.
    - Pointing a privileged process towards executing code that you own and control.
    - Plant malicious code in a location, then wait for a privileged process to execute it.
      - *Crontab*
    - Deceive a privileged process (or user) into mistaking your malicious code for benign code.
- Common tools
  - [Cron Jobs for Linux Privilege Escalation](https://juggernaut-sec.com/cron-jobs-lpe/)





## Lateral Movement

- Lateral movement
  - Refers to techniques adversaries use to move deeper into the network.
  - Strategies
    - Credentials reuse
    - Pivoting or Forwarding: using compromised machine as a relay to compromise other machines
- Common tools
  - [Metasploit Pivoting](https://www.offsec.com/metasploit-unleashed/pivoting/)
  - [SSH port forwarding](https://www.ssh.com/ssh/tunneling/example)



##  MITM

- MITM
  - A correctly positioned adversary may act as a "machine in the middle" (MITM) to intercept network traffic or actively hijack traffic. 
  - Passive MITM
    - To insert yourself into the network traffic flow and conduct **traffic interception/network sniffing** to collect and access confidential transmitted information.
  - Positive MITM
    - Change the route of traffic actively, e.g. DNS Hijacking

- Common tools
  - [tcpdump](https://hackertarget.com/tcpdump-examples/) - Capture traffic packages
  - [Wireshark](https://www.wireshark.org/) / [tshark](https://www.wireshark.org/docs/man-pages/tshark.html). - Analyze traffic packages
  - [DNS Hijacking](https://hellfire0x01.medium.com/get-familiar-with-dns-hijacking-2215a0a318d4)



## Buffer Overflow

- Buffer overflow
  - [Buffer Overflow Exploit](https://dhavalkapil.com/blogs/Buffer-Overflow-Exploit/)
  - [Buffer Overflow Example](https://www.cnblogs.com/Hekeats-L/p/17167873.html)
- Common tools
  - [gdb](https://www.tutorialspoint.com/gnu_debugger/index.htm)







## Cloud Hacking

- Cloud hacking
  - Cloud misconfigurations and mistakes are notorious for causing security incidents in practice. The Cloud Security Alliance regularly surveys industry experts about their top cloud security concerns, where the latest installment is the [Pandemic 11Links to an external site.](https://cloudsecurityalliance.org/artifacts/top-threats-to-cloud-computing-pandemic-eleven/). The top five items this time are
    1. Insufficient identity, credentials, access, and key management.
    2. Insecure interfaces and APIs.
    3. Misconfiguration and inadequate change controls.
    4. Lack of cloud security architecture and strategy.
    5. Insecure software development.
  - Breaching clouds often depends on knowing how to use the platform, usually by very carefully reading the documentation. For example, it can be a matter of recognizing overprivileged users and assets. It can also require knowing how to exploit specific privilege combinations or particular API request parameters.

- Common tools (for Google Cloud Hacking)
  - [Enumerating the Google Cloud Platform (GCP)](https://grnbeltwarrior.medium.com/enumerating-the-google-cloud-platform-gcp-a580da510a23)
  - [GCP Pentesting](https://cloud.hacktricks.xyz/pentesting-cloud/gcp-security)
  - [gcp_enum](https://gitlab.com/gitlab-com/gl-security/security-operations/redteam/redteam-public/pocs/gcp_enum/-/tree/master?ref_type=heads)
  - [Tutorial on privilege escalation and post exploitation tactics in Google Cloud Platform environments](https://about.gitlab.com/blog/2020/02/12/plundering-gcp-escalating-privileges-in-google-cloud-platform/)





## WiFi Hacking

- Wifi hacking

  - WiFi networks are quite ubiquitous; rarely passes a day without our devices connecting to one or more wifi networks. Unfortunately, these networks have historically been riddled with security flaws. Early networks were completely unencrypted. They were followed by a very flawed standard called [WEP. Links to an external site.](https://en.wikipedia.org/wiki/Wired_Equivalent_Privacy) After WEP came [WPALinks to an external site.](https://en.wikipedia.org/wiki/Wi-Fi_Protected_Access), then WPA2, which is what we currently use, and recently, WPA3. 
  - WPA2 comes in two flavors, WPA2 Enterprise and WPA2 PSK. Enterprise is more secure, as clients use unique certificates. The security of WPA2 PSK (Wi-Fi Protected Access - Pre-Shared Key mode) is instead based on a shared key.

- Common tools

  - [iw](https://wireless.wiki.kernel.org/en/users/documentation/iw)

  - [aircrack-ng suite](https://www.hackingarticles.in/wireless-penetration-testing-aircrack-ng/)

  - [Put WiFi Interface into Monitor Mode in Linux](https://www.geeksforgeeks.org/how-to-put-wifi-interface-into-monitor-mode-in-linux/)

  - [wpa_supplicant & dhclient](https://www.linuxbabe.com/command-line/ubuntu-server-16-04-wifi-wpa-supplicant)

    