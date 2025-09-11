# SSH Multiplexing in WSL – Complete Step-by-Step Guide

This guide explains how to set up SSH multiplexing in WSL, including handling jump hosts, so you can open multiple SSH terminals **without re-entering your password**.

---

## Step 1: Prepare the Socket Directory

SSH multiplexing requires a directory to store control sockets. Create it and set proper permissions:

```bash
mkdir -p ~/.ssh/sockets
chmod 700 ~/.ssh/sockets

## Step 2:
Add to ~/.ssh/config
```
# Jump host
Host <Jump Host name>
    HostName myhost.myddns.me
    User <username>
    Port 8080
    ControlMaster auto
    ControlPath ~/.ssh/sockets/%r@%h-%p
    ControlPersist 10m

# Target host via jump host
Host <Target Name>
    HostName 192.168.68.123
    User <username>
    ProxyJump <Jump Host name>
    ControlMaster auto
    ControlPath ~/.ssh/sockets/%r@%h-%p
    ControlPersist 10m
```

## Step 3:
ssh normally with login and password
e.g. `ssh -J <username>@myhost.ddns.me:8080 <username>@192.168.68.123`

## Step 4:
ssh multiplex without password
`ssh <Target Name>`
e.g. `ssh 192.168.68.123` 
