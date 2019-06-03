## SSH Remoting

### Features

- `docker -H ssh://[<user>@]<host> version`
- SSH agent should be used for authentication

### Support

- Added in Docker 18.09
- Required on server and client

### Alternative

- Create remote Docker socket
- `ssh -fNL $HOME/.docker.sock:/var/run/docker.sock user@host`
- `docker -H unix://$HOME/.docker.sock version`