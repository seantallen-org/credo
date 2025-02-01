## Allowing naming of running containers

Prior to this change, you could only ever start a single instance of a development environment. The name given to the running container was the short name from the Credo configuration file. If you tried to start a new instance of an environment while one was already running, you'd get an error.

Both `start` and `shell` now take an optional flag `--as` to give the running container a name other than the short name from the configuration file. This allows you to have multiple instances of an environment running at the same time.

## Allow alternate configuration file locations

Credo now supports an alternate configuration file location. You can specify the location of the configuration file via the `--config` option. If `--config` is not used, Credo will default to `$HOME/.config/credo/config.json`.

