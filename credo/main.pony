use "cli"
use "files"
use "appdirs"

actor Main
  new create(env: Env) =>
    let cmd =
      match recover val CLI.parse(env.args, env.vars) end
      | let c: Command => c
      | (let exit_code: U8, let msg: String) =>
        if exit_code == 0 then
          env.out.print(msg)
        else
          env.err.print(msg)
          env.out.print(CLI.help())
          env.exitcode(exit_code.i32())
        end
        return
      end

    try
      let config_dir = AppDirs(env.vars, "credo").user_config_dir()?
      let config = Config.load(FileAuth(env.root), config_dir)
      match config
      | let devenvs: Array[Environment] val =>
        match cmd.fullname()
        | "credo/start" =>
          let env_name = cmd.arg("name").string()
          for d in devenvs.values() do
            if d.name == env_name then
              StartContainer(d)
              return
            end
          end
          env.err.print("Error: No environment " + env_name + " found")
        | "credo/shell" =>
          let env_name = cmd.arg("name").string()
          for d in devenvs.values() do
            if d.name == env_name then
              OpenShell(d)
              return
            end
          end
          env.err.print("Error: No environment " + env_name + " found")
        end
      | NoConfigFile =>
        env.err.print("Error: No config file found")
      | ConfigParseError =>
        env.err.print("Error: Unable to parse config file")
      end
    else
      env.err.print("Error: Unable to get config directory location")
    end

