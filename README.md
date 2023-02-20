# pihole-docker-with-filterlists

## Pi-hole - Docker based including automated Filter lists ##

This is a docker setup for pi-hole with ipv4 and ipv6 support, which includes the Python [pihole-unique-filterlist-creator](https://github.com/hendrikreimers/pihole-unique-filterlist-creator) Service for creating categorized and multiple filter lists already on setup.

## Table of contents

- [Features](#features)
- [Requirements](#requirements)
- [How to install](#how-to-install)
  - [Hint (DHCP)](#hint-dhcp)
  - [Important notes](#important-notes)
  - [Installation](#installation)
  - [Testing](#testing)
- [Troubleshooting](#troubleshooting)
  - [Pi-hole doesn't blocking anything](#pi-hole-doesnt-blocking-anything)
  - [Only IPv4 or IPv6 Domains are reachable](#only-ipv4-or-ipv6-domains-are-reachable)
  - [Some browsers didn't block anything](#some-browsers-didnt-block-anything)
  - [Some domains are blocked, some not](#some-domains-are-blocked-some-not)
  - [I forgot my password](#i-forgot-my-password)
- [Configuration Files](#configuration-files)
- [Licencse](#licencse)

## Features

- Multiple Shell-Scripts which setups everything for you, like Docker.
- Initializes and startups the Pi-hole with Docker-Compose
- Setups a new Image "pihole-lists" as service for the "[pihole-unique-filterlist-creator](https://github.com/hendrikreimers/pihole-unique-filterlist-creator)" with lighttpd.
- Automatic updates of the filterlist by multiple cronjobs.
- Script automaticly asks for your personal options, like IP, Password, etc.
- Unique filter lists, much more less duplicated urls than including your own lists.
- Categorized lists, easy to turn on and off.

**See [pihole-unique-filterlist-creator](https://github.com/hendrikreimers/pihole-unique-filterlist-creator) for more details of the Lists which used.**

## Requirements

- Raspberry Pi 3 or higher with minimum 16 GB SD-Card.
  Raspberry Pi 2 works also, but slower on updating the lists and the gravitdy Database.
- Fresh basic RaspbianOS Image put on your SD-Card.

## How to install ##

### Hint (DHCP) ###

This Package will not setup a DHCP Server. For best use-case you can use your DHCP of your Router and setup there an alternate DNS-Server which points to your raspberry pi which will run pi-hole.

### Important notes ###

- **Attention**: Currently this scripts run as root (written with root). It would be much better if you change them to run them with sudo under a different user. Feel free to test it and make some recommendations.
- The script will setup some optimizations to save some energy. I recommend to login to your Pi via SSH, because it will disable the HDMI port!

## Installation ##

1. Login to your PI via SSH.

2. Get root:

       # sudo -s

3. Update the System and Install GIT-Packages:

       # apt update
       # apt install git
       # git checkout https://github.com/hendrikreimers/pihole-docker-with-filterlists.git
4. Change ownership and make Setup Script executable

       # chown -R root:root ./pihole-docker-with-filterlists
       # cd pihole-docker-with-filterlists
       # chown +x ./setup.sh
       
5. Run the Setup script and follow the steps. If something is requested.

       # ./setup.sh

6. Open your pi-hole admin in your browser:

       http://YOUR_PIHOLE_ADDRESS/admin

## Testing ##

You can test the DNS Service by making a DNS lookup, maybe on a different System or on the Pi itself by do a nslookup:

      # nslookup google.com [REPLACE_BY_YOUR_RPI_PIHOLE_IP_ADDRESS]

## Troubleshooting ##

### Pi-hole doesn't blocking anything ###

Have you changed your DNS Server on your system or on your DHCP Server in your Router Configuration?

### Only IPv4 or IPv6 Domains are reachable ###

In some cases when you can only reach Websites which has a IPv6 or only IPv4 maybe you misconfigured the Addresses on the setup. There are multiple possible reasons:

- Have you tried to turn off and on again? ;-)
- Your Pi isn't reachable by the given IP Address (IPv4, IPv6, or both)
- You didn't configured the PiHole for the Pi's IP Addresses as well (the same), so the FTL (DNS Server) of pihole couldn't start.
- You forgot to configure the DNS in your Router or other Systems, like your PC (only if you don't want to use your Routers DHCP for give it a nameserver)
- You didn't set the correct Routers IP at the setup script process.

### Some browsers didn't block anything ###

New Browsers like Chrome use DNS-over-HTTPS by default (like Cloudfare DOH). In that case they won't use the pihole DNS. Turn that off in your browser!

### Some domains are blocked, some not ###

Try to flush your DNS Cache of your device. Keep in mind, even a Browser has it's own DNS cache.

### I forgot my password ###

No worries, edit the **docker-compose.override.yml** to change it. After that restart the Services by the following commands in the docker-pihole folder:

      # ./bin/stop.sh
      # ./bin/start.sh
      
## Configuration Files ##

The Setup Script (and the helper Scripts) setups your System and Docker-Compose. Take a close look to them (***./bin Folder***) for Details.

The main configuration you will need is in the file: ***docker-compose-override.yml***

In the following folders you will find the basic setup and later (after everything is running) the configuration as docker volumes, so any of your settings wont be lost if you stop it.

      etc-dnsmasq.d/
      etc-pihole/

## Licencse ##

Not set yet... use it at your own risk. Recommendations, Optimizations, and everything else are welcome.
