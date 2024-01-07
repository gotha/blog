---
title: "Controlling Snapmaker 3D printer with Luban over web interface"
date: "2022-02-08"
categories: 
  - "gadgets"
  - "howto"
  - "oss"
---

I am using Snapmaker A250 which is pretty nice machine - 3D printer, CNC and laser cutter in one.  
By default it comes with a desktop software for Windows, Mac and Linux, but I needed something more.

## The problem

Sometimes 3D prints just fail for various reasons and if you are not around or you do not pay attention, the machine can be damaged.  
I learned this the hard way (nothing fatal, just a lot of cleaning, replacing the nozzle, etc).

It is generally recommended to take a look at the print every 15 or so minutes, but sometimes I print stuff that take many hours and I cannot be tied home all day.  
What I needed was a way to remotely monitor the machine and stop it in case things are going south.

Here is the plan:

1. Get old PC, install Linux and Snapmaker Luban (did I mention everything we'll talk about is open source)
2. Configure Snapmaker Luban to run as a service with systemd inside fake X
3. Setup USB driver and connect PC to the printer
4. Setup webcam streaming software
5. Configure network tunneling

## Install Linux

I installed [ArchLinux](https://archlinux.org/) because that's why !  
Seriously, I like the distro and it already has [Luban in AUR](https://aur.archlinux.org/packages/snapmaker-luban) give it a try.  
You can install it on any other supported OS or distribution by downloading the software from the [luban.xyz/](https://luban.xyz/), but ..

on Arch with `yay` all you need to do is:

```
yay -S snapmaker-luban
```

and you are done.

## Snapmaker Luban as a web service

Snapmaker Luban is Electron app, which means that it requires graphical interface to start, but we are going to trick it (just a little bit).

Install xvfb (X virtual framebuffer):

```
sudo pacman -S xorg-server-xvfb
```

By default on Arch, Luban is installed under `/opt/Snapmaker Luban`.

Lets create a file called `/opt/snapmaker-luban-headless.sh` that would look like this:

```
#!/usr/bin/env bash
export DISPLAY=:1
Xvfb $DISPLAY -screen 0 1024x768x16 & \
    /opt/Snapmaker\ Luban/snapmaker-luban \
            --port 8082  \
                --host 0.0.0.0 \
                --allow-remote-access
```

and make it executable:

```
sudo chmod +x /opt/snapmaker-luban-headless.sh
```

Create the service file `/etc/systemd/system/luban.service` that looks like this:

```
[Unit]
Description=Luban 3d
After=network.target

[Service]
User=fero
ExecStart=/opt/snapmaker-luban-headless.sh

[Install]
WantedBy=multi-user.target
```

and enable the service:

```
sudo systemctl enable luban
```

When you restart the computer, Luban will start and the web interface will be accessible on port 8082.

## Setup USB driver and connect PC to the printer

In my case I had to install additional driver, after several failed attempts I found that the patched version by [github.com/juliagoda/CH341SER](https://github.com/juliagoda/CH341SER) works for me.

If you don't have your Linux header files, you'll have to also install them:

```
sudo pacman -S linux-headers
```

then clone the repo

```
git clone https://github.com/juliagoda/CH341SER.git
```

and follow the instructions.  
In the most straight forward case it should look like this:

```
sudo pacman -S arduino arduino-docs avr-binutils avr-gcc avr-libc avrdude
cd CH341SER
make
sudo make load
find . -name *.ko | xargs gzip
sudo cp ch34x.ko.gz /usr/lib/modules/$(uname -r)/kernel/drivers/usb/serial
```

I would suggest to read the whole README file anyway.

Restart the computer, open a browser at `http://address:8082`, go to `3D printing` -> `Workspace`, select `/dev/ttyUSB0` and click `Connect`.  
If everything goes according to plan you are going to get successful connection, which means you can start controlling your printer remotely.

## Setup webcam streaming software

The simplest way to get this going is with [motion](https://motion-project.github.io/).

On Arch you can install it via:

```
sudo pacman -S motion
```

and enable the service:

```
sudo systemctl enable motion
```

the config file is at `/etc/motion/motion.conf`.

Most webcams will run out of the box.

You don't have to, but if you need you can play a little bit with the configuration.

I personally increased the stream refresh rate by adding this to the file:

```
stream_maxrate 90
```

so the picture is not that choppy. This of course increases the generated network traffic.

## Configure tunneling

This is optional, if you are going to use the web interface only on your WiFi, you don't need it.

To make things accessible from anywhere I configured the machine to ssh tunnel the ports to a proper server that I have in data center.

It it quite easy with [autossh](https://wiki.archlinux.org/title/OpenSSH#Autossh_-_automatically_restarts_SSH_sessions_and_tunnels).

Create a file `/etc/systemd/system/autossh-motion.service` containing:

```
[Unit]
Description=Tunnel webcam port to X
After=network.target

[Service]
Environment="AUTOSSH_GATETIME=0"
ExecStart=/usr/bin/autossh -M 0 -NR 8081:localhost:8081 -o TCPKeepAlive=yes example.com

[Install]
WantedBy=multi-user.target
```

and `/etc/systemd/system/autossh-luban.service` with:

```
[Unit]
Description=Tunnel Snapmaker Luban port to X
After=network.target luban.service

[Service]
Environment="AUTOSSH_GATETIME=0"
ExecStart=/usr/bin/autossh -M 0 -NR 8082:localhost:8082 -o TCPKeepAlive=yes example.com

[Install]
WantedBy=multi-user.target
```

Notice that the tunnel will wait until Luban service starts

then just enable the services:

```
sudo systemctl enable autossh-motion
sudo systemctl enable autossh-luban
```

## Result

I am quite happy with the result, even if the power goes out, the machine will boot, connect to the remote server and allow me to monitor and control the printer in real time.
