class val Environment
  let name: String
  let user: String
  let image: String
  let shell: String
  let workdir: String
  let workspace: String
  let mounts: Array[Mount] val

  new val create(name': String,
    user': String,
    image': String,
    shell': String,
    workdir': String,
    workspace': String,
    mounts': Array[Mount] val)
  =>
    name = name'
    user = user'
    image = image'
    shell = shell'
    workdir = workdir'
    workspace = workspace'
    mounts = mounts'

class val Mount
  let source: String
  let target: String
  let mtype: String

  new val create(source': String,
    target': String,
    mtype': String)
  =>
    source = source'
    target = target'
    mtype = mtype'
