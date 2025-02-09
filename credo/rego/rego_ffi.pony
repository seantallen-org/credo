use "lib:rego-standalone"

use @regoBuildInfo[RegoString]()
use @regoVersion[RegoString]()
use @regoSetLogLevel[RegoEnum](level: RegoEnum)
use @regoNew[RegoInterpreterPtr tag]()
use @regoFree[None](rego: RegoInterpreterPtr tag)
use @regoAddModuleFile[RegoEnum](rego: RegoInterpreterPtr tag,
  path: RegoString tag)
use @regoAddModule[RegoEnum](rego: RegoInterpreterPtr tag,
  name: RegoString tag,
  contents: RegoString tag)
use @regoAddDataJSONFile[RegoEnum](rego: RegoInterpreterPtr tag,
  path: RegoString tag)
use @regoAddDataJSON[RegoEnum](rego: RegoInterpreterPtr tag,
  contents: RegoString tag)
use @regoSetInputJSONFile[RegoEnum](rego: RegoInterpreterPtr tag,
  path: RegoString tag)
use @regoSetInputJSON[RegoEnum](rego: RegoInterpreterPtr tag,
  contents: RegoString tag)
use @regoSetInputTerm[RegoEnum](rego: RegoInterpreterPtr tag,
  contents: RegoString tag)
use @regoSetDebugEnabled[RegoEnum](rego: RegoInterpreterPtr tag,
  enabled: RegoBool)
use @regoGetDebugEnabled[RegoBool](rego: RegoInterpreterPtr tag)
use @regoSetDebugPath[RegoEnum](rego: RegoInterpreterPtr tag,
  path: RegoString tag)
use @regoSetWellFormedChecksEnabled[RegoEnum](rego: RegoInterpreterPtr tag,
  enabled: RegoBool)
use @regoGetWellFormedChecksEnabled[RegoBool](rego: RegoInterpreterPtr tag)

type RegoEnum is U32
type RegoString is Pointer[U8]
type RegoInterpreterPtr is Pointer[RegoInterpreter]
type RegoBool is U8
type RegoOutputPtr is Pointer[RegoOutput]
type RegoNodePtr is Pointer[RegoNode]

struct RegoInterpreter
struct RegoOutput
struct RegoNode

primitive RegoFFI
  fun build_info(): String =>
    recover val String.from_cstring(@regoBuildInfo()) end

  fun version(): String =>
    recover val String.from_cstring(@regoVersion()) end

  fun set_log_level(level: LogLevel): ResultCode =>
    ResultCodeParser(@regoSetLogLevel(level()))

  fun interpreter(): RegoInterpreterPtr tag =>
    @regoNew()

  fun free(rego: RegoInterpreterPtr tag) =>
    @regoFree(rego)

  fun add_module_file(rego: RegoInterpreterPtr tag,
    path: String): ResultCode
  =>
    ResultCodeParser(@regoAddModuleFile(rego, path.cstring()))

  fun add_module(rego: RegoInterpreterPtr tag,
    name: String,
    contents: String): ResultCode
  =>
    ResultCodeParser(
      @regoAddModule(rego, name.cstring(), contents.cstring()))

  fun add_data_json_file(rego: RegoInterpreterPtr tag,
    path: String): ResultCode
  =>
    ResultCodeParser(@regoAddDataJSONFile(rego, path.cstring()))

  fun add_data_json(rego: RegoInterpreterPtr tag,
    contents: String): ResultCode
  =>
    ResultCodeParser(@regoAddDataJSONFile(rego, contents.cstring()))

  fun set_input_json_file(rego: RegoInterpreterPtr tag,
    path: String): ResultCode
  =>
    ResultCodeParser(@regoSetInputJSONFile(rego, path.cstring()))

  fun set_input_json(rego: RegoInterpreterPtr tag,
    contents: String): ResultCode
  =>
    ResultCodeParser(@regoSetInputJSONFile(rego, contents.cstring()))

  fun set_input_term(rego: RegoInterpreterPtr tag,
    contents: String): ResultCode
  =>
    ResultCodeParser(@regoSetInputJSONFile(rego, contents.cstring()))

  fun set_debug_enabled(rego: RegoInterpreterPtr tag,
    enabled: Bool): ResultCode
  =>
    let e: RegoBool = if enabled then 1 else 0 end

    ResultCodeParser(@regoSetDebugEnabled(rego, e))

  fun get_debug_enabled(rego: RegoInterpreterPtr tag): Bool =>
    @regoGetDebugEnabled(rego) == 1

  fun set_debug_path(rego: RegoInterpreterPtr tag,
    path: String): ResultCode
  =>
    ResultCodeParser(@regoSetDebugPath(rego, path.cstring()))

  fun set_well_formed_checks_enabled(rego: RegoInterpreterPtr tag,
    enabled: Bool): ResultCode
  =>
    let e: RegoBool = if enabled then 1 else 0 end

    ResultCodeParser(@regoSetWellFormedChecksEnabled(rego, e))

  fun get_well_formed_checks_enabled(rego: RegoInterpreterPtr tag): Bool =>
    @regoGetWellFormedChecksEnabled(rego) == 1

