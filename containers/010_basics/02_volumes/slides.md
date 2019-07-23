## Non-persistent data

```
$ docker run -it ubuntu
root@12345678# touch /file.txt
root@12345678# ls -l /
root@12345678# exit
$ docker run -it ubuntu
```

--

### Locally persistent storage

```
$ docker run -it -v /source:/source ubuntu
root@12345678# touch /file
root@12345678# ls –l /
root@12345678# exit
$ docker run -it -v /source:/source ubuntu
root@12345678# ls –l /
```