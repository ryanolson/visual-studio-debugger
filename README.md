Templated Dockerfile extension for Visual Studio debugging

From you linux machine, start a container for building/debugging:
```
luda -p 2222:22 visual-studio sudo /usr/sbin/sshd -D
```

From your windows machine, test:
```
ssh -p 2222 <hostname-or-ip-of-host-running-the-container>
```
