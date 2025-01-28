use @execvpe[I32](path: Pointer[U8] tag, argp: Pointer[Pointer[U8] tag] tag,
  envp: Pointer[Pointer[U8] tag] tag)

primitive StartContainer
  fun apply(devenv: Environment) =>
    let path = "docker"
    let args: Array[String] val = recover val
      let mounts: Array[String] = []
      for m in devenv.mounts.values() do
        mounts.push("--mount")
        mounts.push("src=" + m.source + ",target=" + m.target + ",type=" + m.mtype)
      end

      let workspace_mount = recover val "src=" + devenv.workspace + ",target=" + devenv.workdir + ",type=bind" end

      let args1: Array[String] =
        [
        "docker"
        "run"
        "--user"
        devenv.user
        "--name"
        devenv.name
        "-w"
        devenv.workdir
        "--mount"
        workspace_mount
        ]

      let args2: Array[String] =
        [
        "--rm"
        "-i"
        "-t"
        devenv.image
        devenv.shell
        ]

      args1.>append(mounts).>append(args2)
    end

    let vars: Array[String] val = []
    let argsp = MakeArgv(args)
    let varsp = MakeArgv(vars)
    @execvpe(path.cstring(), argsp.cpointer(), varsp.cpointer())

primitive OpenShell
  fun apply(devenv: Environment) =>
    let path = "docker"
    let args: Array[String] val =
      [
        "docker"
        "exec"
        "-it"
        devenv.name
        devenv.shell
      ]

    let vars: Array[String] val = []
    let argsp = MakeArgv(args)
    let varsp = MakeArgv(vars)
    @execvpe(path.cstring(), argsp.cpointer(), varsp.cpointer())

primitive MakeArgv
  fun apply(args: Array[String] box): Array[Pointer[U8] tag] =>
    """
    Convert an array of String parameters into an array of
    C pointers to same strings.
    """
    let argv = Array[Pointer[U8] tag](args.size() + 1)
    for s in args.values() do
      argv.push(s.cstring())
    end
    argv.push(Pointer[U8]) // nullpointer to terminate list of args
    argv
