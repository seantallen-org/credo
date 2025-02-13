## Set Meaningful Hostname on Container Startup

When starting a container, we now pass the `--hostname` option to Docker. This sets the hostname to something meaningful to the user rather than the default Docker container ID.

The hostname will use the name of the development environment or the name from the Credo `--as` option if provided.
