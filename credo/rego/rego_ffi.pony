use "lib:rego-standalone"

type RegoEnum is U32
type RegoString is Pointer[U8]
type RegoInterpreterPtr is Pointer[RegoInterpreter]
type RegoBool is U8
type RegoOutputPtr is Pointer[RegoOutput]
type RegoNodePtr is Pointer[RegoNode]
type RegoSize is U32
type RegoApiBuffer is Pointer[U8]

struct RegoInterpreter
struct RegoOutput
struct RegoNode
