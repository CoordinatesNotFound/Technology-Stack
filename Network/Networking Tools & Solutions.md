# Networking Tools & Solutions





## 1 Basic Networking Tools



### 1.1 Network analysis

| Tool       | Usage                                                        | Doc                |
| ---------- | ------------------------------------------------------------ | ------------------ |
| ip         | Configures and displays network interface parameters         | `man 1 ip`         |
| arp        | Shows or manipulates the IP-to-MAC address translation tables | `man 8 arp`        |
| dig        | Queries DNS name servers for DNS-related information         | `man 1 dig`        |
| ping       | Tests connectivity between two nodes by sending ICMP echo requests | `man 8 ping`       |
| traceroute | Traces the route packets take to reach a destination         | `man 1 traceroute` |
| mtr        | Combines ping and traceroute functionalities for network diagnostics | `man 8 traceroute` |
| nmap       | Scans networks for discovering hosts and services running on them | `man 1 nmap`       |
| nc         | A versatile networking tool for reading/writing data across connections | `man 1 nc`         |
| tcpdump    | Captures and analyzes network packets flowing through a network interface | `man 1 tcodump`    |





### 1.2 Network retrieving

| Tool | Usage                                                        | Doc          |
| ---- | ------------------------------------------------------------ | ------------ |
| curl | Transfers data with support for various protocols like HTTP, HTTPS, FTP, etc | `man 1 curl` |
| wget | Downloading files from web servers                           | `man 1 wget` |
| lynx | Browsing web pages                                           | `man 1 lynx` |



### 1.3 SSH

[OpenSSH: Manual Pages](https://www.openssh.com/manual.html)

[What is the Secure Shell (SSH) Protocol? | SSH Academy](https://www.ssh.com/academy/ssh/protocol)



## 2 Email Server



### 2.1 Email delivery architecture

UA = User Agent, MSA = Mail Submission Agent, MTA = Mail Transfer Agent, MDA = Mail Delivery Agent, AA = Access Agent

- UA-to-MSA or -MTA as a message is injected into the mail system
- MSA-to-MTA as the message starts its delivery journey
- MTA- or MSA-to-antivirus or -antispam scanning programs 
- MTA-to-MTA as a message is forwarded from one site to another 
- MTA-to-MDA as a message is delivered to the local message store



### 2.2 Email delivery tools

| Tool         | Usage                                              | Doc                                                          |
| ------------ | -------------------------------------------------- | ------------------------------------------------------------ |
| postfix      | MTA,  routing and delivering emails                | `man 5 postconf`                                             |
| exim4        | MTA,  routing and delivering emails                | `man 8 dpkg-reconfigure`                                     |
| procmail     | MDA, used for sorting emails into users' mailboxes | `man 5 procmailrc`                                           |
| spamassassin | A tool used for spam detection                     | [SpamAssassin: Documentation](https://spamassassin.apache.org/doc.html) |
| mail         | Sending mails                                      | `man 1 mail`                                                 |





## 3 Web Server



### 3.1 Web server solutions

| Solution | Doc                                                          |
| -------- | ------------------------------------------------------------ |
| Apache   | [Apache module index](https://httpd.apache.org/docs/current/mod/) |
| Nginx    | [NGINX Documentation](https://docs.nginx.com/)               |
| Node.js  | [Node.js Documentation](https://nodejs.org/docs/latest/api/) |





## 4 IPv6



### 4.1 IPv6 addressing

[Unicast Addresses > IPv6 Address Representation and Address Types | Cisco Press](https://www.ciscopress.com/articles/article.asp?p=2803866&seqNum=4)

[RFC 4291- IP Version 6 Addressing Architecture](http://ftp.funet.fi/rfc/rfc4291.txt)



### 4.2 IPv6 over IPv4

| Solution | Usage                     | Doc                                                          |
| -------- | ------------------------- | ------------------------------------------------------------ |
| 6RD      | IPv6 over IPv4 connection | [Linux 6RD HOWTO](http://www.litech.org/6rd/)                |
| ip4ip6   | IPv4 in IPv6              | [Chapter 10. Configuring IPv4-in-IPv6 tunnels](https://tldp.org/HOWTO/Linux+IPv6-HOWTO/ch10.html) |



## 5 DNS



### 5.1 DNS server

[BIND 9 Administrator Reference Manual — BIND 9 9.18.24 documentation](https://bind9.readthedocs.io/en/v9.18.24/)

[DNS for Rocket Scientists - Contents](https://www.zytrax.com/books/dns/)



### 5.2 DNSSEC

[The Basics of DNSSEC - O'Reilly Media](https://web.archive.org/web/20160221185439/http:/www.onlamp.com/pub/a/onlamp/2004/10/14/dnssec.html)



### 5.3 Pi-hole DNS sinkhole

[Overview of Pi-hole - Pi-hole documentation](https://docs.pi-hole.net/)
