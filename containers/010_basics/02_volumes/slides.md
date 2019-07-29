## Storage

By default, processes only get locally persistent storage

Why should containers work differently?

Containers are even worse by default

## Non-persistent data

Enter container:

```bash
docker run -it ubuntu
```

Inside container:

```bash
touch /file.txt
ls -l /
exit
```

XXX look for file in new instance:

```bash
docker run -it ubuntu
```

XXX gone

--

## Locally persistent storage

Enter container with bind mount:

```bash
docker run -it -v /source:/source ubuntu
```

Create file:

```bash
touch /file
ls –l /
exit
```

XXX look for file in new instance:

```bash
docker run -it -v /source:/source ubuntu
```

XXX found

## Persistent storage

XXX hard problem for green field

XXX NFS

XXX Docker storage plugins
