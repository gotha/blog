---
title: "Инсталиране на MiniDLNA под FreeBSD 10"
date: "2014-09-19"
categories: 
  - "howto"
  - "oss"
tags: 
  - "dlna"
  - "freebsd"
  - "minidlna"
---

Ако предпочитате да си компилирате всичко, порта се намира в net/minidlna. Тоест нещо от типа на:

cd /usr/ports/net/minidlna
make config-recursive
make install clean

Ако сте по-мързеливи винаги може да инсталирате с

pkg install minidlna

Конфигурационния файл се намира в /usr/local/etc/minidlna.conf и нещата, които трябва да промените или разкоментирате  са:

port=8200
user=root
network\_interface=re0
media\_dir=/opt
friendly\_name=FreeBSD DLNA Server
db\_dir=/var/db/minidlna
log\_dir=/var/db/minidlna

Разбира се, направете нужните корекции за вашата система. Ако нямате папката може би е добра идея да я създадете:

mkdir /var/db/minidlna

По подразбиране папката където се намират мултимедийните файлове е в /opt. Трябва да създадете папката ако не съществува при вас. Опитах да използвам папка от типа /home/user/Video, но има проблеми с правата, които така и не разреших за това предпочетох да използвам симлинкове.

mkdir /opt 
cd /opt 
ln -s /home/user/Video .

Ако всичко ви изглежда ок можем да стартираме услугата.

/usr/local/etc/rc.d/minidlna onestart

За да проверите дали всичко е ок можете да проверите log файла:

 tail -f /var/db/minidlna/minidlna.log

Ако няма грешки можете да проверите дали всичко работи през вашия телевизор или VLC.

За финал добавете minidlna към услугите, които да се стартират при пускане на машината като добавите към /etc/rc.conf

minidlna\_enable="YES"

Накратко това е.  Доста подобно на това как се инсталира MiniDLNA под Mac OS X (за което писах преди), но с особеностите на freebsd.
