## Docker CLI Plugins

Extend `docker` with new functionality

Located in `~/.docker/cli-plugins`

Executable file called `docker-*` where `*` is the new command

Command line parameters are passed to `docker-*`

Plugin must support parameter `docker_cli_plugin_metadata` and return the following

```json
{
    "SchemaVersion":"0.1.0",
    "Vendor":"Nicholas Dille",
    "Version":"0.0.1",
    "ShortDescription":"Sample metadata",
    "URL":"https://dille.name"
}
```

---

## CLIP

XXX