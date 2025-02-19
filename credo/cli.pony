use "cli"

type CommandParseResult is (Command | (U8, String))

primitive CLI
  fun parse(
    args: Array[String] val,
    envs: Array[String] val)
    : CommandParseResult
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
      "A containerized development environment runner",
      [
        OptionSpec.string("config", "Path to the configuration file.", None, "")
      ],
      [
        CommandSpec.leaf(
          "start",
          "Starts a development environment",
          [
            OptionSpec.string("as", "Name to assign to the running environment. Default is the name of environment.", None, "")
          ],
          [
            ArgSpec.string("name", "Name of the environment to start")
          ])?
        CommandSpec.leaf(
          "shell",
          "Opens a new shell in a development environment",
          [
            OptionSpec.string("as", "Name of the running environment. Default is the name of environment.", None, "")
          ],
          [
            ArgSpec.string("name", "Name of the environment to open a shell in")
          ])?
        CommandSpec.leaf(
          "version",
          "Display the credo version and exit")?
      ])?
      .> add_help()?
