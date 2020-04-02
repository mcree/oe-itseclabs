#!/bin/sh
test -f /etc/ssh/ssh_host_rsa_key || ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
test -f /etc/ssh/ssh_host_ecdsa_key || ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa
/usr/sbin/sshd -D -e
