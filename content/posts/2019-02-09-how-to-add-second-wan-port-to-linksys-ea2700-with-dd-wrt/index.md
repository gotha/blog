---
title: "How to add second WAN port to Linksys EA2700 with dd-wrt"
date: "2019-02-09"
categories: 
  - "gadgets"
  - "howto"
---

First of all terrible router, don't buy it, this is only if you already have it and you need to squeeze the last drops of life from it.

Why would you want second WAN port ? In my case, it was because the one that I already had stopped working, so I was wondering if there is a way to use one of the other 4 as WAN. There is.

 

There is a already very good article about [DD-WRT on Linksys EA27600](https://haeberling.blogspot.com/2014/11/installing-dd-wrt-on-linksys-ea2700.html?m=1)  by Sacha Häberling, I am not going to repeat everything, I'll just add some details.

1. First you need to get rid of the ridiculous modern UI that Linksys ship with the router and switch back to Linksys Classic UI. I made the mistake to assume that since I already have it, I may skip this step - no, do it even if you already reverted to the old firmware.
2. Do 30-30-30- reset (30 seconds holding reset with power on, unplug the power cable for 30 seconds, plug again and hold for another 30 seconds. Reset button is pressed the whole time)
3. Download the latest firmware you think might work  from [DD-WRT FTP server](ftp://ftp.dd-wrt.com/betas/). I haven't had time to experiment with a lot of them to see if the latest works reliably. The original article recommends [r30471](ftp://ftp.dd-wrt.com/betas/2014/12-11-2014-r25628/linksys-ea2700/) , the latest someone confirmed still works good is [r30805](ftp://ftp.dd-wrt.com/betas/2016/10-27-2016-r30805/linksys-ea2700/), so I installed this one. If you have time - check the latest one. Install it from the firmware update menu in the web interface.
4. Log in the new interface, go to DD-WRT administration panel > commands and execute
    
    nvram set partialboots=0
    nvram commit
    
5. Do another 30-30-30 reset and this should be it. Then configure your router as usual.

 

So far so good, now I want to make port 4 as it is labeled on the box (actually port 3) to be another WAN port. If you need to know more about what is going on, I strongly advise you to check dd-wrt's explanation about [how ports and vlans work](https://wiki.dd-wrt.com/wiki/index.php/Switched_Ports).

Long story short, you have 5 LAN ports, they are usually split in 2 virtual LAN groups, one for WAN (or "the Internet") and the other is for your local LAN network. The fact that we can move physical LAN port to another virtual LAN make this whole thing possible.

For EA2700 there are 3 virtual groups, I am no really sure, but I suspect this is because of the dual band or guest network or something.

Login via telnet or ssh in the router and execute:

root@DD-WRT:/# nvram show | grep vlan.\*ports | sort
size: 28628 bytes (233516 left)
vlan0ports=1 2 3 4 5\*
vlan1ports=0 1 2 3 8\*
vlan2ports=4 8

What this means is: - 5 and 8 are so called processor ports, so we don't care about them for now. - the asterisk after 5 and 8 in the first two vlans indicates these are the local virtual LANs, meaning that they are supposed to receive internet from the outside. - port 4 is the WAN port (we count from 0) Guides recommend to save your initial configuration somewhere in case you need to restore it.

Lets move port 3 (4 on the box) out of vlan 0 and 1 and move it to 2.

nvram set vlan0ports="1 2 4 5\*"
nvram set vlan1ports="0 1 2 8\*"
nvram set vlan2ports="3 4 8"

Then we can check the port/vlans:

root@DD-WRT:/# nvram show | grep port.\*vlans | sort
port0vlans=1
port1vlans=0
port2vlans=0
port3vlans=0
port4vlans=0
port5vlans=0 1 16

The first number after portXvlans indicates the vlan for the port, the rest are attributes, 16 means "tagged" and there is some kind of convention to always tag the CPU port. Now we want to make port 3 another WAN port:

nvram set port3vlans="1 18 19 21"

and finish by committing our changes and restart

nvram commit 
reboot

Plug the cable from your ISP in the fourth port and you should have still working old router even if it tries to get rid of you.
