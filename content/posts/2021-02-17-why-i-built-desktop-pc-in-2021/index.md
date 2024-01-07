---
title: "Why I built desktop PC in 2021"
date: "2021-02-17"
categories: 
  - "mac"
  - "misc"
---

The switch happened overnight for me,  at my first job I was working on a desktop PC, but since then every single workspace I have been in ultimately used laptops.

Somehow big ugly boxes went out of favor with the rise of tablets, [eeePCs](https://en.wikipedia.org/wiki/Asus_Eee_PC) (do you remember these) and MacBook Airs coming out of mail envelopes. 

Maybe if you are working in a big company and you have to go a lot of meetings you really need a portable device, but to be honest in 2013 I was attending stand-ups and such taking notes on my iPad. If you are appalled by the idea of typing by tapping on a screen, I know it is less than ideal, but come on we grew up typing SMS-es on 9 key keyboards and we were pretty good at it. 

#### Background

I was working on 2017 MacBook Pro with core i5 and 16gb of RAM. I really do not recommend you to buy such a machine. MacBooks were never really that heat efficient, but this is just another beast. The moment you go to Hangouts meeting and you share your screen, you can barely use or even touch the computer. 

At some point I realized that the Core i5 processor I have in my Dell PC from 2012 delivers the same performance as the one in my laptop (for the price of power consumption, but nobody thinks about that in desktops). The only problem was that the old desktop had only 8GB of RAM, but considering the fact that running Linux you do not have to run Docker in VM (constantly reserving 4GB RAM for itself) it turns out it is quite viable alternative.

So I gave it a try. ArchLinux is better than ever. Even with less RAM I was managing to do my daily job. I started using the Macbook as AV machine - just for attending online meetings and doing the coding on the PC (I know, such a waste). I never really had decent PC, so I decided that I finally deserve something more powerful.

Finally, let's not forget what year is it. Because of the pandemic I haven't attended a meeting in person for almost a year. The reasons to keep a mobile machine as your primary working device kept disappearing.

#### Why not 

OK, lets discuss why you would not want PC. 

Linux is an awesome OS, but let's be honest - sometimes the big corporations overlook software support for it. For example my VPN client was terrible under Linux and it was constantly disconnecting. Of course if it was opensource someone would have fixed the problem a long time ago, but as Cait used to say - we live in an imperfect world. 

Windows ? No. Sorry. Maybe I'll install Windows some day if I want to play some games, but this is not a priority for me right now. Last time I tried working under Windows the only thing that made this OS bearable for me was WSL, but if that's the case why not just use Linux instead. 

What about buying iMac or Mac Pro. Both are very expensive machines. Mac Pro for me was completely out of the question because I could not justify the price. 

The iMac is an incredibly beautiful machine, but I am not sure how future proof it is, considering the fact that a lot of people expect drastic changes in that line of products. Also, I was wondering how good the cooling would be and I did not want to risk it. In my head I was picturing horrific scenarios where I have shoveled a huge amount of money just to discover that the CPU is throttled most of the time to prevent overheating.

Unless you go for the iMac option you will inevitably end up with ... lets call it - less-than-elegant box next to your desk, so don't underestimate this. Maybe you insist on beautiful design, maybe you don't have the space. I personally think I can live with it. Nowadays PC cases are not what they used to be, but lets face it - it is still a box.

#### Lets build

I was not very picky about the parts, but wanted to be able to achieve something specific (and may be not legal).   
What I ended up with is something that is powerful enough without spending a fortune on the build:

- AMD Radeon RX 580
- Gigabyte Z490 Vision G (which is the cheaper version of Vision D, but I think I am fine missing on the extra features)
- Intel Core i7-10700K (I am not sure if I would ever overclock it, but it's good to know that this feature is present)
- Noctua NH-D15 cooler (that thing is HUGE, but amazingly quiet)
- 500GB Samsung 860 EVO SSD
- 2x32GB DDR4 Patriot Viper Steel RAM (maybe a bit of a stretch)
- Cooler Master MWE 750 power supply
- NZXT H710 Matte Black case 

A lot of things changed since the last time I did this. I don't remember PC cases to cost as much. Also, I don't remember cable management to be that good. I was expecting to have an ugly box filled with messy cables. I couldn't have been more wrong. The case is clean and nice to look at, the cables are hidden in a way that it looks like carefully designed machine, not something assembled in someones garage. The design is simple and clean, there are no RGB lights, I repeat, no RGB lights. Why do most PC case manufacturers assume we are all a bunch of 14-year-olds.

The price is half of what I would have paid for iMac with similar specs.   
Of course the iMac comes with magnificent display, so if you factor the price of nice 4K display - it is not that cheaper.   
Another big advantage of the iMac is that it can run OS X, but guess what, this desktop build is very much hackintoshable. 

#### The state of Hackintosh

Putting aside the legality and morality of running OS X on non-Apple hardware it is quite interesting topic from a technical point of view.

Last time I tried to something like this, it was 2013 and I barely succeeded in turning my Acer laptop into fully working Hackintosh after a week, but it was absolute mayhem. Hackintoshing computer back then was black magic. Not just for me, but for most people. Most of us (who are not kext developers and do not have intimate knowledge of how OSX works) just tried random stuff until it worked.   
There were some sparse online guides, but at the end of the day you just poke in the dark until you figure out the exact combination of hacked kernel extensions that work in your specific case.

Everything is amazingly different now. [OpenCore](https://dortania.github.io/OpenCore-Install-Guide/) is bootloader written by people who really know what they are doing and nowadays you can follow generic structured guide and have much more scientific approach to building Hackintosh. 

This hardware is specifically chosen to be close to what Apple sell, so it is relatively easy to install OSX on it.  
Actually I found a guy that has done this for [similar configuration](https://github.com/rursache/Hackintosh-i9-10900k-Z490-Vision-G) and just by slightly adapting his configuration, I managed to do my own quite fast.   
Surprisingly it was harder to install all the right drivers for Windows (operating system that is supposed to run on this hardware) compared to OSX (an OS that was never meant to run here).

What still does not work is Wi-Fi and Bluetooth, but this was expected, it was almost never possible and I was expecting to have to buy a separate supported Wi-Fi chip. It is desktop after all, mine is 15 cm away from the router and I prefer cable connection, but my I really want to be able to use my Bluetooth headphones. This is something I haven't fixed yet, but it is definitely doable, so it is just a matter of time.

#### Verdict

I think I have built a pretty decent machine. Most importantly it is capable of running OSX (I am currently on Big Sur), Linux and Windows, so if at some point in the future I decide that I want to become a professional StarCraft player I can dual boot.  

Actually I played StarCraft II and Civilization 6 (under OSX) and they work perfectly. 

Some people say that this is result of the virus, you are probably not going on vacation this year so why not spend some money on toys.   
I am not sure if this is the reason, but nevertheless I think Desktop PC in 2021 is good idea (even if you plan to run Windows and play games on it).
