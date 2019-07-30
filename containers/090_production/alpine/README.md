# alpine

Tools behave differently

Scripts may break

Using alpine requires migration

```bash
$ docker run --rm alpine ps
PID   USER     TIME  COMMAND
    1 root      0:00 ps
$ docker run --rm ubuntu ps
  PID TTY          TIME CMD
    1 ?        00:00:00 ps
```