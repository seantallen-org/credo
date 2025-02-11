use @regoNodeType[RegoEnum](node: RegoNodePtr tag)
use @regoNodeTypeName[RegoString](node: RegoNodePtr tag)
use @regoNodeValueSize[RegoSize](node: RegoNodePtr tag)
use @regoNodeValue[RegoEnum](node: RegoNodePtr tag, buffer: RegoApiBuffer tag,
  size: RegoSize)
use @regoNodeSize[RegoSize](node: RegoNodePtr tag)
use @regoNodeGet[RegoNodePtr](node: RegoNodePtr tag, index: RegoSize)
use @regoNodeJSONSize[RegoSize](node: RegoNodePtr tag)
use @regoNodeJSON[RegoEnum](node: RegoNodePtr tag, buffer: RegoApiBuffer tag,
  size: RegoSize)

primitive RegoNodeFFI
  fun node_type(node: RegoNodePtr tag): TermNodeType =>
    TermNodeParser(@regoNodeType(node))

  fun node_type_name(node: RegoNodePtr tag): String =>
    recover val String.from_cstring(@regoNodeTypeName(node)) end

  fun node_value_size(node: RegoNodePtr tag): RegoSize =>
    @regoNodeValueSize(node)

  fun node_value(node: RegoNodePtr tag, buffer: Array[U8] iso,
    size: RegoSize): ResultCode
  =>
    ResultCodeParser(@regoNodeValue(node, buffer.cpointer(), size))

  fun node_size(node: RegoNodePtr tag): RegoSize =>
    @regoNodeSize(node)

  fun node_get(node: RegoNodePtr tag, index: RegoSize): RegoNodePtr =>
    @regoNodeGet(node, index)

  fun node_json_size(node: RegoNodePtr tag): RegoSize =>
    @regoNodeJSONSize(node)

  fun node_json(node: RegoNodePtr tag, buffer: Array[U8] iso,
    size: RegoSize): ResultCode
  =>
    ResultCodeParser(@regoNodeJSON(node, buffer.cpointer(), size))
