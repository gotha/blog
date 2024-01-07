---
title: "Запазване на пароли под Linux, Windows и Mac"
date: "2016-05-20"
categories: 
  - "howto"
  - "oss"
---

Много харесвам Keychain-a на Mac, но той си има своите ограничения - измежду които основното, че не можеш да го ползваш на други операционни системи.

Оказа се, че може би единствения мултиплатформен начин да направите това с KeePass. Има много начини и комбинации от софтуер, с които да имплементирате нещо такова, но ето какво аз съм намерил за най-доброто.

Под Debian KeePass2 присъства сред пакетите, така че можем да го инсталираме лесно

apt-get install keepass2

Следва да сложим plugin на Firefox, аз лично предпочитам [PassIFox](https://addons.mozilla.org/en-us/firefox/addon/passifox/). Този плъгин изисква [KeePassHttp](https://github.com/pfn/keepasshttp/) за да работи, а на плъгина му трябва mono-complete.

apt-get install mono-complete

След като инсталирате mono-complete, изтегляте KeePassHttp.plgx , слагате го  в /usr/lib/keepass2 и да рестартирате keepass.

На този етап паролите ви от Firefox се пазят в KeePass. Черешката на тортата е да сложите kdbx файла в OwnCloud за да имате синхронизация между всичите си устройства.

 

За Max Os въпреки че не е много стабилен препоръчвам  [MacPass](https://github.com/mstarke/MacPass).

За Android също има owncloud и можете да ползвате [KeePassDroid](https://play.google.com/store/apps/details?id=com.android.keepass&hl=en).

Дори iOS феновете ще останат приятно изненадани от комбинацията ownCloud + [KeePass Touch](https://itunes.apple.com/us/app/keepass-touch/id966759076?mt=8).  За Windows мисля няма нужда да обяснявам.

 

Като цяло имате password management за поне 5 операционни системи, напълно безплатен и чрез ownCloud синхронизиран онлайн, най-близкото което можете да получите до Mac Keychain с бонуса, че работи на (почти) всички устройства, които вероятно притежавате.

 

 

Edit: November 2018

За Firefox Quantum PassIFox не работи. Вместо това можете да ползвате [Kee](https://addons.mozilla.org/bg/firefox/addon/keefox/) заедно с [KeePassRPC](https://github.com/kee-org/keepassrpc/releases/tag/v1.7.3.1)
