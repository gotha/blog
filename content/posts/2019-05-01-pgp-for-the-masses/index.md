---
title: "PGP for the masses"
date: "2019-05-01"
categories: 
  - "howto"
  - "mac"
  - "oss"
---

# [](http://localhost:1337/#pgp-gpg-7)

## [](http://localhost:1337/#intro-20)

## Intro

Using PGP is very simple, you need to generate key (it will actually be two keys - public and private). Public key is what you want to give to other people so they can encrypt files for you. Private key is something you do not want to share.  
  
This guide/cheatsheet assumes that you are using osx, but aside from the GUI tools, the rest will be the same for all operating systems

There are 4 things that you need to know:

- how to generate your key
- how to find other people's keys
- how to encrypt
- how to decrypt

### [](http://localhost:1337/#terminology-11)

### Terminology

Some clarifications:

OpenPGP is a standard for encryption

PGP stands for Pretty Good Privacy - this is software that implements the OpenPGP standard

GPG stands for GNU Privacy Guard - open source implementation of OpenPGP (this is what we are going to use)

PHP is something completely different

## [](http://localhost:1337/#install-20)

## Install

Download from [https://gpgtools.org/](https://gpgtools.org/) If you are not planning to use it with Mail App, during installation click `Customise` and deselect `GPG Mail`

## [](http://localhost:1337/#create-new-key-20)

## Create new key

You can just type  
`gpg --full-generate-key`

and answer the questions or via GUI:  
Click `New`, enter your e-mail address and password, wait for key generation to finish. At the end click to upload the key to key server.

If you have already generated key you can upload it by clicking `Key` -> `Send Public Key to Key Server`

Note: By uploading your key it will be uploaded to one of the SKS servers used by OpenPGP and it might take some time until it is visible in all servers.

## [](http://localhost:1337/#retrieving-others-public-keys-20)

## Retrieving other's public keys

If you have tin foil hat, you would prefer to ask someone to send you their PGP key and they can send it to you. Never trust keys that you have not asked for and you are not sure are sent by the person you think sits behind them, somebody may be pretending to be a friend.

If you however think that you know what you are doing, click `Lookup key`, type the e-mail of the person you expect to have published, check if the rest of the data looks credible and import it.  
  
If you do not want to use the GUI app, you can search in websites like [http://keys.gnupg.net](http://keys.gnupg.net)

Note: Some people may have several keys, ask them which one you should use (usually the one that was created most recently would be the one that you want).

Note2: After publishing key it may take some time until it shows up, be patient

## [](http://localhost:1337/#encrypting-files-20)

## Encrypting files

### [](http://localhost:1337/#using-finder-40)

### Using Finder

Go to the folder where the file is, right click on it, select `Services` -> `Open PGP : Encrypt File`, then select the key that you want to be able to decrypt it and click `Encrypt`. If the file is called `file.txt` you will see a new file called `file.txt.gpg`

### [](http://localhost:1337/#using-cli-40)

### Using CLI

```
gpg -e --armor file.txt
```

Enter the e-mail of the recipient/s and hit enter when you are done  
  
or if you want to encrypt some text:

```
echo "text" | gpg -ea
```

## [](http://localhost:1337/#decrypting-files-20)

## Decrypting files

### [](http://localhost:1337/#using-finder-41)

### Using Finder

Go to the folder where the file is, right click on it, select `Services` -> `Open PGP : Encrypt File`, enter your password and decrypted file should show up

### [](http://localhost:1337/#using-cli-41)

### Using CLI

```
gpg -d file.txt.gpg
```

## [](http://localhost:1337/#view-keys-20)

## View Keys

```
gpg -k
```

## [](http://localhost:1337/#adding-pgp-key-in-github-20)

## Adding PGP key in GitHub

Go to [github.com](http://github.com) -> `Settings` -> `SSH and GPG keys` -> `New GPG Key`

Copy your public key

```
gpg --export --armor MYKEYID
```

Paste it in github and click Save.

Then you have to tell `git` to sign your commits

```
git config --global commit.gpgsign true
git config --global user.signingkey MYKEYID
```

If you have created your github account with different e-mail address than the one specified in the PGP file, you can go to `Settings` -> `Emails` and add new e-mail address. Then proceed with the verification clicking the link sent to your inbox.

If you still have problems, check the e-mail specified in your ~/.gitconfig file. It should match the one from the PGP file

## [](http://localhost:1337/#deepish-dive-20)

## Deep(ish) dive

### [](http://localhost:1337/#view-secret-keys-with-their-long-ids-20)

### View secret keys with their long IDs

```
gpg --list-secret-keys --keyid-format LONG
```

### [](http://localhost:1337/#backup-and-restore-secret-keys-20)

### Backup and restore secret keys

#### [](http://localhost:1337/#backup-1)

#### Backup:

```
gpg --export-secret-keys MYKEYID > my-private-key.asc
```

#### [](http://localhost:1337/#import-from-backup-1)

#### Import from backup:

```
gpg --import my-private-key.asc
```

### [](http://localhost:1337/#revocation-20)

### Revocation

If you private key leaks or maybe you do not want to use it anymore you have to send the Key Server revocation certificate. Ideally you would still have the private key and you could generate it at any moment, but sometimes keys get lost, so you may want to generate revocation certificate now and back it up somewhere.

```
gpg --output revocation.crt --gen-revoke myemail@example.com
```

When you decide to revoke the key you have to import it and send it to the Key Server like this:

```
gpg --import revocation.crt
gpg --send-keys KEYID
```

Replace `KEYID` with the ID of your key

### [](http://localhost:1337/#signing-other-peoples-keys-20)

### Signing other people's keys

TLDR: You can sign keys to tell others that this key is good.

If you trust the person you can sign their key and send them back the key and you will be listed as someone who signed the key.

```
gpg --sign-key email@example.com
```

You have to send them the signed key back

```
gpg --output /tmp/signed.key --export --armor email@example.com
```

and they have to import it to benefit from you signing it:

```
gpg --import signed.key
```

If people you trust have signed the key, usually it is a good indicator.
