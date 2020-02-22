[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/mcree/oe-itseclabs/master?urlpath=lab)

# IT Security labs at Óbuda University

This repository contains practice materials and setup 
files for the virtual environments used during lab sessions.

The repo aims to be bilingual (primary language is hungarian,
but most things are also present in english)

## Preliminary topics
1. Introduction, getting to know the environment
2. User awareness I. (web, e-mail, social media)
3. User awareness II. (public networks, malware, device security)
4. Cryptography I. (basic symmetric ciphers)
5. Cryptography II. (RSA, diffie-hellman)
6. Password management
7. Lab exam I.
8. Windows hardening
9. Linux hardening
10. Firewalls
11. Endpoint security, tracing malware
12. PGP, e-mail security
13. SSL, web security
14. Lab exam II.

## Usage

### Populating a virtual machine (tested with Ubuntu 18.04 LTS)

```sudo add-apt-repository -y ppa:ansible/ansible && sudo apt-get -y install ansible && sudo ansible-pull --url=https://github.com/mcree/oe-itseclabs.git --inventory=localhost, --tags=invm .build/playbook.yml```

This will include GUI components. Default username and password is: hallgato / hallgato

### Using Docker

Tested with [repo2docker](https://repo2docker.readthedocs.io/en/latest/) for
running on [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/mcree/oe-itseclabs/master?urlpath=lab)
