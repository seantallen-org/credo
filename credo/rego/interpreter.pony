class val Interpreter
  let _interpreter: RegoInterpreterPtr tag

  new val create() =>
    _interpreter = _RegoFFI.interpreter()

  fun _final() =>
    _RegoFFI.free(_interpreter)

  // TODO change to something higher level than a string
  fun add_module_file(path: String): OkOrError =>
    """
    Adds a module (e.g. virtual document) from the file at the specified path.

    If an error code is returned, more error information can be obtained by
    calling `get_error`.
    """
    _RegoFFI.add_module_file(_interpreter, path)

  fun add_module(name: String, contents: String): OkOrError =>
    """
    Adds a module (e.g. virtual document) from the file at the specified string.

    If an error code is returned, more error information can be obtained by
    calling `get_error`.
    """
    _RegoFFI.add_module(_interpreter, name, contents)

  // TODO change to something higher level than a string
  fun add_data_json_file(path: String): OkOrError =>
    """
    Adds a base document from the file at the specified path.

    The file should contain a single JSON object. The object will be
    parsed and merged with the interpreter's base document.

    If an error code is returned, more error information can be
    obtained by calling `get_error`.
    """
    _RegoFFI.add_data_json_file(_interpreter, path)

  fun add_data_json(contents: String): OkOrError =>
    """
    Adds a base document from the file at the specified string.

    The file should contain a single JSON object. The object will be
    parsed and merged with the interpreter's base document.

    If an error code is returned, more error information can be
    obtained by calling `get_error`.
    """
    _RegoFFI.add_data_json(_interpreter, contents)

  fun set_input_json_file(path: String): OkOrError =>
    """
    Sets the current input document from the file at the specified path.

    The file should contain a single JSON value. The value will be
    parsed and set as the interpreter's input document.

    If an error code is returned, more error information can be
    obtained by calling `get_error`.
    """
    _RegoFFI.set_input_json_file(_interpreter, path)

  fun set_input_term(contents: String): OkOrError =>
    """
    Sets the current input document from the specified string.

    The string should contain a single Rego data term. The value will be
    parsed and set as the interpreter's input document.

    If an error code is returned, more error information can be
    obtained by calling `get_error`.
    """
    _RegoFFI.set_input_term(_interpreter, contents)

  fun set_debug_enabled(enabled: Bool) =>
    """
    Sets the debug mode of the interpreter.

    When debug mode is enabled, the interpreter will output intermediary
    ASTs after each compiler pass to the debug directory and output pass
    information to stdout. This is mostly useful for creating reports for
    compiler issues, but can also be of use in understanding why a policy is
    invalid or is behaving unexpectedly.
    """
    _RegoFFI.set_debug_enabled(_interpreter, enabled)

  fun get_debug_enabled(): Bool =>
    """
    Gets the debug mode of the interpreter.
    """
    _RegoFFI.get_debug_enabled(_interpreter)

  // TODO change to something higher level than a string
  fun set_debug_path(path: String): OkOrError =>
    """
    Sets the path to the debug directory.

    If set, then (when in debug mode) the interpreter will output intermediary
    ASTs after each compiler pass to the debug directory. If the directory does
    not exist, it will be created.

    If an error code is returned, more error information can be
    obtained by calling `get_error`.
    """
    _RegoFFI.set_debug_path(_interpreter, path)

  fun set_well_formed_checks_enabled(enabled: Bool) =>
    """
    Sets whether to perform well-formed checks after each compiler pass.

    The interpreter has a set of well-formness definitions which indicate the
    expected form of the AST before and after each compiler pass. This setting
    determines whether the interpreter will perform these intermediary
    checks.
    """
    _RegoFFI.set_well_formed_checks_enabled(_interpreter, enabled)

  fun get_well_formed_checks_enabled(): Bool =>
    """
    Gets whether well-formed checks are enabled.
    """
    _RegoFFI.get_well_formed_checks_enabled(_interpreter)

  fun query(query_expr: String): Output =>
    """
    Performs a query against the current base and virtual documents.

    The query expression should be a Rego query.
    """
    Output._create(_RegoFFI.query(_interpreter, query_expr))

  fun set_strict_builtin_errors(enabled: Bool) =>
    """
    Sets whether the built-ins should throw errors.

    When strict built-in errors are enabled, built-in functions will throw
    errors when they encounter invalid input. When disabled, built-in
    functions will return undefined when they encounter invalid input.
    """
    _RegoFFI.set_strict_builtin_errors(_interpreter, enabled)

  fun get_strict_builtin_errors(): Bool =>
    """
    Gets whether strict built-in errors are enabled.
    """
    _RegoFFI.get_strict_builtin_errors(_interpreter)

  fun is_builtin(name: String): Bool =>
    """
    Returns whether the specified name corresponds to an available built-in in
    the interpreter.
    """
    _RegoFFI.is_builtin(_interpreter, name)

  fun get_error(): String =>
    """
    Returns the most recently thrown error.

    If an error code is returned from an interface function, more error
    information can be obtained by calling this function.
    """
    _RegoFFI.get_error(_interpreter)
