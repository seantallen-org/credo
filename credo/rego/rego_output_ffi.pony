use @regoOutputOk[RegoBool](output: RegoOutputPtr tag)
use @regoOutputSize[RegoSize](output: RegoOutputPtr tag)
use @regoOutputExpressionsAtIndex[RegoNodePtr](output: RegoOutputPtr tag,
  index: RegoSize)
use @regoOutputExpressions[RegoNodePtr](output: RegoOutputPtr tag)
use @regoNode[RegoNodePtr](output: RegoOutputPtr tag)
use @regoOutputBindingAtIndex[RegoNodePtr](output: RegoOutputPtr tag,
  index: RegoSize,
  name: RegoString tag)
use @regoOutputBinding[RegoNodePtr](output: RegoOutputPtr tag,
  name: RegoString tag)
use @regoOutputJSONSize[RegoSize](output: RegoOutputPtr tag)
use @regoOutputJSON[RegoEnum](output: RegoOutputPtr tag,
  buffer: RegoApiBuffer tag,
  size: RegoSize)
use @regoOutputString[RegoString](output: RegoOutputPtr tag)
use @regoFreeOutput[None](output: RegoOutputPtr tag)

primitive RegoOutputFFI
  fun output_ok(output: RegoOutputPtr tag): Bool =>
    @regoOutputOk(output) == 1

  fun output_size(output: RegoOutputPtr tag): RegoSize =>
    @regoOutputSize(output)

  fun output_expressions_at_index(output: RegoOutputPtr tag,
    index: RegoSize): RegoNodePtr
  =>
    @regoOutputExpressionsAtIndex(output, index)

  fun output_expressions(output: RegoOutputPtr tag): RegoNodePtr =>
    @regoOutputExpressions(output)

  fun node(output: RegoOutputPtr tag): RegoNodePtr =>
    @regoNode(output)

  fun output_binding_at_index(output: RegoOutputPtr tag,
    index: RegoSize, name: String): RegoNodePtr
  =>
    @regoOutputBindingAtIndex(output, index, name.cstring())

  fun output_binding(output: RegoOutputPtr tag,
    name: String): RegoNodePtr
  =>
    @regoOutputBinding(output, name.cstring())

  fun output_json_size(output: RegoOutputPtr tag): RegoSize =>
    @regoOutputJSONSize(output)

  fun output_json(output: RegoOutputPtr tag,
    buffer: Array[U8] iso,
    size: RegoSize): ResultCode
  =>
    ResultCodeParser(@regoOutputJSON(output, buffer.cpointer(), size))

  fun output_string(output: RegoOutputPtr): String =>
    recover val String.from_cstring(@regoOutputString(output)) end

  fun free_output(output: RegoOutputPtr tag) =>
    @regoFreeOutput(output)
