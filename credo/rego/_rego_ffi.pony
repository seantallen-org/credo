use "lib:rego-standalone"

// Interpreter functions
use @regoBuildInfo[_RegoString]()
use @regoVersion[_RegoString]()
use @regoSetLogLevel[RegoEnum](level: RegoEnum)
use @regoNewV1[_RegoInterpreter]()
use @regoFree[None](rego: _RegoInterpreter)
use @regoAddModuleFile[RegoEnum](rego: _RegoInterpreter, path: _RegoString tag)
use @regoAddModule[RegoEnum](rego: _RegoInterpreter,
  name: _RegoString tag,
  contents: _RegoString tag)
use @regoAddDataJSONFile[RegoEnum](rego: _RegoInterpreter, path: _RegoString tag)
use @regoAddDataJSON[RegoEnum](rego: _RegoInterpreter, contents: _RegoString tag)
use @regoSetInputJSONFile[RegoEnum](rego: _RegoInterpreter, path: _RegoString tag)
use @regoSetInputTerm[RegoEnum](rego: _RegoInterpreter, contents: _RegoString tag)
use @regoSetDebugEnabled[None](rego: _RegoInterpreter, enabled: _RegoBool)
use @regoGetDebugEnabled[_RegoBool](rego: _RegoInterpreter)
use @regoSetDebugPath[RegoEnum](rego: _RegoInterpreter, path: _RegoString tag)
use @regoSetWellFormedChecksEnabled[None](rego: _RegoInterpreter,
  enabled: _RegoBool)
use @regoGetWellFormedChecksEnabled[_RegoBool](rego: _RegoInterpreter)
use @regoQuery[_RegoOutput](rego: _RegoInterpreter,
  query_expr: _RegoString tag)
use @regoSetStrictBuiltInErrors[None](rego: _RegoInterpreter, enabled: _RegoBool)
use @regoGetStrictBuiltInErrors[_RegoBool](rego: _RegoInterpreter)
use @regoIsBuiltIn[_RegoBool](rego: _RegoInterpreter, name: _RegoString tag)
use @regoGetError[_RegoString](rego: _RegoInterpreter)
// Output functions
use @regoOutputOk[_RegoBool](output: _RegoOutput)
use @regoOutputSize[RegoSize](output: _RegoOutput)
use @regoOutputExpressionsAtIndex[_NullableRegoNodePtr val](
  output: _RegoOutput,
  index: RegoSize)
use @regoOutputExpressions[_NullableRegoNodePtr val](output: _RegoOutput)
use @regoOutputNode[_RegoNode](output: _RegoOutput)
use @regoOutputBindingAtIndex[_NullableRegoNodePtr val](output: _RegoOutput,
  index: RegoSize,
  name: _RegoString tag)
use @regoOutputBinding[_NullableRegoNodePtr val](output: _RegoOutput,
  name: _RegoString tag)
use @regoOutputJSONSize[RegoSize](output: _RegoOutput)
use @regoOutputJSON[RegoEnum](output: _RegoOutput,
  buffer: _RegoApiBuffer tag,
  size: RegoSize)
use @regoOutputString[_RegoString](output: _RegoOutput)
use @regoFreeOutput[None](output: _RegoOutput)
// Node functions
use @regoNodeType[RegoEnum](node: _RegoNode)
use @regoNodeTypeName[_RegoString](node: _RegoNode)
use @regoNodeValueSize[RegoSize](node: _RegoNode)
use @regoNodeValue[RegoEnum](node: _RegoNode, buffer: _RegoApiBuffer tag,
  size: RegoSize)
use @regoNodeSize[RegoSize](node: _RegoNode)
use @regoNodeGet[_NullableRegoNodePtr val](node: _RegoNode, index: RegoSize)
use @regoNodeJSONSize[RegoSize](node: _RegoNode)
use @regoNodeJSON[RegoEnum](node: _RegoNode, buffer: _RegoApiBuffer tag,
  size: RegoSize)

// Type aliases
type RegoEnum is U32
type RegoSize is U32
type _NullableRegoNodePtr is NullablePointer[_RegoNode]
type _RegoApiBuffer is Pointer[U8]
type _RegoBool is U8
type _RegoString is Pointer[U8]

// Types for the various void* pointers that the rego-cpp C-API exposes
struct tag _RegoInterpreter
struct tag _RegoOutput
struct tag _RegoNode

primitive _RegoFFI
  """
  Wrapper module for all rego-cpp C-API functions
  """

  //
  // Interpreter functions
  //

  fun build_info(): String =>
    """
    Returns a string of the form
    "VERSION (BUILD_NAME, BUILD_DATE) BUILD_TOOLCHAIN on PLATFORM"
    """
    recover val String.copy_cstring(@regoBuildInfo()) end

  fun version(): String =>
    """
    Returns the version of the Rego library.
    """
    recover val String.copy_cstring(@regoVersion()) end

  fun set_log_level(level: LogLevel) =>
    """
    Sets the level of logging.

    This setting controls the amount of logging that will be output to stdout.
    The default level is `NoneLevel`.
    """
    _ResultOkOrInvalidLogLevelParser(@regoSetLogLevel(level()))

  fun interpreter(): _RegoInterpreter =>
    """
    Allocates and initializes a new Rego interpreter.

    The caller is responsible for freeing the interpreter with `free`.
    """
    @regoNewV1()

  fun free(rego: _RegoInterpreter) =>
    """
    Frees a Rego interpreter.

    The pointer must have been allocated with `interpreter`.
    """
    @regoFree(rego)

  fun add_module_file(rego: _RegoInterpreter, path: String): InterpreterResult =>
    """
    Adds a module (e.g. virtual document) from the file at the specified path.

    If an error code is returned, more error information can be obtained by
    calling `get_error`.
    """
    _InterpreterResultParser(@regoAddModuleFile(rego, path.cstring()), rego)

  fun add_module(rego: _RegoInterpreter,
    name: String,
    contents: String): InterpreterResult
  =>
    """
    Adds a module (e.g. virtual document) from the file at the specified string.

    If an error code is returned, more error information can be obtained by
    calling `get_error`.
    """
    _InterpreterResultParser(
      @regoAddModule(rego, name.cstring(), contents.cstring()), rego)

  fun add_data_json_file(rego: _RegoInterpreter,
    path: String): InterpreterResult
  =>
    """
    Adds a base document from the file at the specified path.

    The file should contain a single JSON object. The object will be
    parsed and merged with the interpreter's base document.

    If an error code is returned, more error information can be
    obtained by calling `get_error`.
    """
    _InterpreterResultParser(@regoAddDataJSONFile(rego, path.cstring()), rego)

  fun add_data_json(rego: _RegoInterpreter,
    contents: String): InterpreterResult
  =>
    """
    Adds a base document from the file at the specified string.

    The file should contain a single JSON object. The object will be
    parsed and merged with the interpreter's base document.

    If an error code is returned, more error information can be
    obtained by calling `get_error`.
    """
    _InterpreterResultParser(
      @regoAddDataJSONFile(rego, contents.cstring()), rego)

  fun set_input_json_file(rego: _RegoInterpreter,
    path: String): InterpreterResult
  =>
    """
    Sets the current input document from the file at the specified path.

    The file should contain a single JSON value. The value will be
    parsed and set as the interpreter's input document.

    If an error code is returned, more error information can be
    obtained by calling `get_error`.
    """
    _InterpreterResultParser(@regoSetInputJSONFile(rego, path.cstring()), rego)

  fun set_input_term(rego: _RegoInterpreter,
    contents: String): InterpreterResult
  =>
    """
    Sets the current input document from the specified string.

    The string should contain a single Rego data term. The value will be
    parsed and set as the interpreter's input document.

    If an error code is returned, more error information can be
    obtained by calling `get_error`.
    """
    _InterpreterResultParser(
      @regoSetInputJSONFile(rego, contents.cstring()), rego)

  fun set_debug_enabled(rego: _RegoInterpreter, enabled: Bool) =>
    """
    Sets the debug mode of the interpreter.

    When debug mode is enabled, the interpreter will output intermediary
    ASTs after each compiler pass to the debug directory and output pass
    information to stdout. This is mostly useful for creating reports for
    compiler issues, but can also be of use in understanding why a policy is
    invalid or is behaving unexpectedly.
    """
    let e: _RegoBool = if enabled then 1 else 0 end

    @regoSetDebugEnabled(rego, e)

  fun get_debug_enabled(rego: _RegoInterpreter): Bool =>
    """
    Gets the debug mode of the interpreter.
    """
    @regoGetDebugEnabled(rego) == 1

  fun set_debug_path(rego: _RegoInterpreter, path: String): InterpreterResult =>
    """
    Sets the path to the debug directory.

    If set, then (when in debug mode) the interpreter will output intermediary
    ASTs after each compiler pass to the debug directory. If the directory does
    not exist, it will be created.

    If an error code is returned, more error information can be
    obtained by calling `get_error`.
    """
    _InterpreterResultParser(@regoSetDebugPath(rego, path.cstring()), rego)

  fun set_well_formed_checks_enabled(rego: _RegoInterpreter, enabled: Bool) =>
    """
    Sets whether to perform well-formed checks after each compiler pass.

    The interpreter has a set of well-formness definitions which indicate the
    expected form of the AST before and after each compiler pass. This setting
    determines whether the interpreter will perform these intermediary
    checks.
    """
    let e: _RegoBool = if enabled then 1 else 0 end

    @regoSetWellFormedChecksEnabled(rego, e)

  fun get_well_formed_checks_enabled(rego: _RegoInterpreter): Bool =>
    """
    Gets whether well-formed checks are enabled.
    """
    @regoGetWellFormedChecksEnabled(rego) == 1

  fun query(rego: _RegoInterpreter, query_expr: String): _RegoOutput =>
    """
    Performs a query against the current base and virtual documents.

    The query expression should be a Rego query. The output of the query
    will be returned as a _RegoOutput. The caller is responsible for
    freeing the output object with `free_output`.
    """
    @regoQuery(rego, query_expr.cstring())

  fun set_strict_builtin_errors(rego: _RegoInterpreter, enabled: Bool) =>
    """
    Sets whether the built-ins should throw errors.

    When strict built-in errors are enabled, built-in functions will throw
    errors when they encounter invalid input. When disabled, built-in
    functions will return undefined when they encounter invalid input.
    """
    let e: _RegoBool = if enabled then 1 else 0 end

    @regoSetStrictBuiltInErrors(rego, e)

  fun get_strict_builtin_errors(rego: _RegoInterpreter): Bool =>
    """
    Gets whether strict built-in errors are enabled.
    """
    @regoGetStrictBuiltInErrors(rego) == 1

  fun is_builtin(rego: _RegoInterpreter, name: String): Bool =>
    """
    Returns whether the specified name corresponds to an available built-in in
    the interpreter.
    """
    @regoIsBuiltIn(rego, name.cstring()) == 1

  fun get_error(rego: _RegoInterpreter): String =>
    """
    Returns the most recently thrown error.

    If an error code is returned from an interface function, more error
    information can be obtained by calling this function.
    """
    recover val String.copy_cstring(@regoGetError(rego)) end

  //
  // Output functions
  //

  fun output_ok(output: _RegoOutput): Bool =>
    """
    Returns whether the output is ok.

    If the output resulted in a valid query result, then this function will
    return true. Otherwise, it will return false, indicating that the
    output contains an error sequence.
    """
    @regoOutputOk(output) == 1

  fun output_size(output: _RegoOutput): RegoSize =>
    """
    Returns the number of results in the output.

    Each query can potentially generate multiple results. This function
    returns the number of results in the output.
    """
    @regoOutputSize(output)

  fun output_expressions_at_index(output: _RegoOutput,
    index: RegoSize): _NullableRegoNodePtr val
  =>
    """
    Returns a node containing a list of terms resulting from the query at
    the specified index.
    """
    @regoOutputExpressionsAtIndex(output, index)

  fun output_expressions(output: _RegoOutput): _NullableRegoNodePtr val =>
    """
    Returns a node containing a list of terms resulting from the query
    at the default index.
    """
    @regoOutputExpressions(output)

  fun output_node(output: _RegoOutput): _RegoNode =>
    """
    Returns the node containing the output of the query.

    This will either be a node which contains one or more results,
    or an error sequence.
    """
    @regoOutputNode(output)

  fun output_binding_at_index(output: _RegoOutput,
    index: RegoSize, name: String): _NullableRegoNodePtr val
  =>
    """
    Returns the bound value for a given variable name.

    If the variable is not bound, then this function will return NULL.
    """
    @regoOutputBindingAtIndex(output, index, name.cstring())

  fun output_binding(output: _RegoOutput,
    name: String): _NullableRegoNodePtr val
  =>
    """
    Returns the bound value for a given variable name at the first index.

    If the variable is not bound, then this function will return NULL.
    """
    @regoOutputBinding(output, name.cstring())

  fun output_json_size(output: _RegoOutput): RegoSize =>
    """
    Returns the number of bytes needed to store a 0-terminated string
    representing the output as a human-readable string.

    The value returned by this function can be used to allocate a buffer to
    pass to `output_json`.
    """
    @regoOutputJSONSize(output)

  fun output_json(output: _RegoOutput,
    buffer: _RegoApiBuffer tag,
    size: RegoSize)
  =>
    """
    Populate a buffer with the output represented as a human-readable string.

    The buffer must be large enough to hold the value. The size of the buffer
    can be determined by calling `output_json_size`.
    """
    _ResultOkOrBufferTooSmallParser(@regoOutputJSON(output, buffer, size))

  fun output_string(output: _RegoOutput): String =>
    """
    Returns the output represented as a human-readable string.
    """
    recover val String.copy_cstring(@regoOutputString(output)) end

  fun free_output(output: _RegoOutput) =>
    """
    Frees a `_RegoOutput`.

    This pointer must have been allocated with `query`.
    """
    @regoFreeOutput(output)

  //
  // Node functions
  //

  fun node_type(node: _RegoNode): TermNodeType =>
    """
    Returns the node's type.
    """
    TermNodeParser(@regoNodeType(node))

  fun node_type_name(node: _RegoNode): String =>
    """
    Returns the name of the node type as a human-readable string.

    This function supports arbitrary nodes (i.e. it will always produce a
    value) including internal nodes which appear in error messages.
    """
    recover val String.copy_cstring(@regoNodeTypeName(node)) end

  fun node_value_size(node: _RegoNode): RegoSize =>
    """
    Returns the number of bytes needed to store a 0-terminated string
    representing the text value of the node.

    The value returned by this function can be used to allocate a buffer to
    pass to `node_value`.
    """
    @regoNodeValueSize(node)

  fun node_value(node: _RegoNode, buffer: _RegoApiBuffer tag,
    size: RegoSize)
  =>
    """
    Populate a buffer with the node value.

    The buffer must be large enough to hold the value. The size of the buffer
    can be determined by calling `node_value_size`.
    """
    _ResultOkOrBufferTooSmallParser(@regoNodeValue(node, buffer, size))

  fun node_size(node: _RegoNode): RegoSize =>
    """
    Returns the number of children of the node.
    """
    @regoNodeSize(node)

  fun node_get(node: _RegoNode, index: RegoSize): _NullableRegoNodePtr val =>
    """
    Returns the child node at the specified index.

    If there is no chold node that the specified index, then this function will return NULL.
    """
    @regoNodeGet(node, index)

  fun node_json_size(node: _RegoNode): RegoSize =>
    """
    Returns the number of bytes needed to store a 0-terminated string
    representing the JSON representation of the node.

    The value returned by this function can be used to allocate a buffer to
    pass to `node_json`.
    """
    @regoNodeJSONSize(node)

  fun node_json(node: _RegoNode,
    buffer: _RegoApiBuffer tag,
    size: RegoSize)
  =>
    """
    Populate a buffer with the JSON representation of the node.

    The buffer must be large enough to hold the value. The size of the buffer
    can be determined by calling `node_json_size`.
    """
    _ResultOkOrBufferTooSmallParser(@regoNodeJSON(node, buffer, size))
