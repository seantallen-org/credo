## Update Docker Image to Be Based on `scratch`

Instead of including a full Alpine 3.20 environment in the Credo Docker image, we now only include the compiled Credo binary and its license file. This should shrink the image size significantly.

## Allow debuggers to run in containerized environments

We've added `--cap-add=SYS_PTRACE --security-opt seccomp=unconfined` as part of container startup. Debuggers like LLDB can now run in environments that Credo starts.

## Always pull image when starting a development environment

When starting a development environment, the image is always pulled from the registry. This ensures that the latest version of the image is used. If the local version of the image  is up-to-date, the image is not pulled again.

