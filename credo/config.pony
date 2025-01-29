use "files"
use "json"

primitive NoConfigFile
primitive ConfigParseError

type ConfigLoadResult is (Array[Environment] val | NoConfigFile | ConfigParseError)

primitive Config
  fun load(auth: FileAuth, config: String): ConfigLoadResult =>
    let caps = recover val FileCaps.>set(FileRead).>set(FileStat) end

    try
      with file = OpenFile(
        FilePath(auth, config, caps)) as File
      do
        try
          let json = _get_json_config(file)?
          ConfigParser(json)?
        else
          ConfigParseError
        end
      end
    else
      NoConfigFile
    end

  fun _get_json_config(file: File): JsonType val ? =>
    let config = file.read_string(file.size())
    let doc = recover val JsonDoc.>parse(consume config)? end
    doc.data

primitive ConfigParser
  fun apply(json: JsonType val): Array[Environment] val ? =>
    recover val
      let envs = JsonExtractor(json)("environments")?.as_array()?
      let result: Array[Environment] = Array[Environment]
      for e in envs.values() do
        let obj = JsonExtractor(e).as_object()?
        let name = JsonExtractor(obj("name")?).as_string()?
        let user = JsonExtractor(obj("user")?).as_string()?
        let image = JsonExtractor(obj("image")?).as_string()?
        let shell = JsonExtractor(obj("shell")?).as_string()?
        let workdir = JsonExtractor(obj("workdir")?).as_string()?
        let workspace = JsonExtractor(obj("workspace")?).as_string()?
        let mounts = recover trn Array[Mount] end
        for i in JsonExtractor(obj("mounts")?).as_array()?.values() do
          let m = MountParser(i)?
          mounts.push(m)
        end

        let environment = Environment(name, user, image, shell, workdir, workspace, consume mounts)
        result.push(environment)
      end
      result
    end

primitive MountParser
  fun apply(json: JsonType val): Mount ? =>
    let obj = JsonExtractor(json).as_object()?
    let source = JsonExtractor(obj("source")?).as_string()?
    let target = JsonExtractor(obj("target")?).as_string()?
    let mtype = JsonExtractor(obj("type")?).as_string()?

    Mount(source, target, mtype)
