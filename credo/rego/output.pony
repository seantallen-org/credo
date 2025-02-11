class val Output
  let _output: RegoOutput

  new val _create(output: RegoOutput) =>
    _output = output

  fun _final() =>
    _RegoFFI.free_output(_output)

  fun ok(): Bool =>
    """
    Returns whether the output is ok.

    If the output resulted in a valid query result, then this function will
    return true. Otherwise, it will return false, indicating that the
    output contains an error sequence.
    """
    _RegoFFI.output_ok(_output)

  fun size(): RegoSize =>
    """
    Returns the number of results in the output.

    Each query can potentially generate multiple results. This function
    returns the number of results in the output.
    """
    _RegoFFI.output_size(_output)

  fun expressions_at_index(index: RegoSize): Node ? =>
    """
    Returns a node containing a list of terms resulting from the query at
    the specified index.
    """
    let ptr = _RegoFFI.output_expressions_at_index(_output, index)
    Node._create(ptr()?)

  fun expressions(): Node ? =>
    """
    Returns a node containing a list of terms resulting from the query
    at the default index.
    """
    let ptr = _RegoFFI.output_expressions(_output)
    Node._create(ptr()?)

  fun node(): Node =>
    """
    Returns the node containing the output of the query.

    This will either be a node which contains one or more results,
    or an error sequence.
    """
    Node._create(_RegoFFI.output_node(_output))

  fun binding_at_index(index: RegoSize, name: String): Node ? =>
    """
    Returns the bound value for a given variable name.
    """
    let ptr = _RegoFFI.output_binding_at_index(_output, index, name)
    Node._create(ptr()?)

  fun binding(name: String): Node ? =>
    """
    Returns the bound value for a given variable name at the first index.
    """
    let ptr = _RegoFFI.output_binding(_output, name)
    Node._create(ptr()?)

  fun json_size(): RegoSize =>
    """
    Returns the number of bytes needed to store a 0-terminated string
    representing the output as a human-readable string.

    The value returned by this function can be used to allocate a buffer to
    pass to `json`.
    """
    _RegoFFI.output_json_size(_output)

  fun json(): Array[U8] iso =>
    """
    Populate a buffer with the output represented as a human-readable string.

    The buffer must be large enough to hold the value. The size needed for
    the buffer can be determined by calling `json_size`.
    """
    let required = _RegoFFI.output_json_size(_output).usize()
    let buffer = recover iso Array[U8](required) end
    _RegoFFI.output_json(_output, buffer.cpointer(), buffer.size().u32())
    consume buffer

  fun string(): String =>
    """
    Returns the output represented as a human-readable string.
    """
    _RegoFFI.output_string(_output)
