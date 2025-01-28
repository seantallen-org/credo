use "cli"

primitive CLI
  fun parse(
    args: Array[String] box,
    envs: (Array[String] box | None))
    : (Command | (U8, String))
  =>
    try
      match CommandParser(spec()?).parse(args, envs)
      | let c: Command => c
      | let h: CommandHelp => (0, h.help_string())
      | let e: SyntaxError => (1, e.string())
      end
    else
      (2, "Internal error: invalid command spec")
    end

  fun help(): String =>
    try Help.general(spec()?).help_string() else "" end

  fun spec(): CommandSpec ?
  =>
    CommandSpec.parent(
      "credo",
      "",
      [],
      [
        CommandSpec.leaf(
          "start",
          "Starts a development environment",
          Array[OptionSpec](),
          [
            ArgSpec.string("name", "Name of the environment to start")
          ])?
        CommandSpec.leaf(
          "shell",
          "Opens a new shell in a development environment",
          Array[OptionSpec](),
          [
            ArgSpec.string("name", "Name of the environment to open a shell in")
          ])?
      ])?
      .> add_help()?
