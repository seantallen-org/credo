## Allow debuggers to run in containerized environments

We've added `--cap-add=SYS_PTRACE --security-opt seccomp=unconfined` as part of container startup. Debuggers like LLDB can now run in environments that Credo starts.
