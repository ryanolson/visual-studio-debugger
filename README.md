Templated Dockerfile extension for Visual Studio debugging

```
luda -p 2222:22 visual-studio sudo /usr/sbin/sshd -D`
```

From your machine, connect:
```
ssh -p 2222 <hostname-or-ip-of-host-running-the-container>
```
