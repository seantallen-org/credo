class val Node
  let _node: RegoNode val

  new val _create(node: RegoNode val) =>
    _node = node

  fun node_type(): TermNodeType =>
    """
    Returns the node's type.
    """
    _RegoFFI.node_type(_node)

  fun type_name(): String =>
    """
    Returns the name of the node type as a human-readable string.

    This function supports arbitrary nodes (i.e. it will always produce a
    value) including internal nodes which appear in error messages.
    """
    _RegoFFI.node_type_name(_node)

  fun value_size(): RegoSize =>
    """
    Returns the number of bytes needed to store a 0-terminated string
    representing the text value of the node.

    The value returned by this function can be used to allocate a buffer to
    pass to `value`.
    """
    _RegoFFI.node_value_size(_node)

  // TODO
  fun value(buffer: Array[U8] iso): OkOrBufferTooSmall =>
    """
    Populate a buffer with the node value.

    The buffer must be large enough to hold the value. The size of the buffer
    can be determined by calling `value_size`.
    """
    _RegoFFI.node_value(_node, buffer.cpointer(), buffer.size().u32())

  fun size(): RegoSize =>
    """
    Returns the number of children of the node.
    """
    _RegoFFI.node_size(_node)

  fun get(index: RegoSize): Node ?=>
    """
    Returns the child node at the specified index.
    """
    let ptr = _RegoFFI.node_get(_node, index)
    Node._create(ptr()?)

  fun json_size(): RegoSize =>
    """
    Returns the number of bytes needed to store a 0-terminated string
    representing the JSON representation of the node.

    The value returned by this function can be used to allocate a buffer to
    pass to `json`.
    """
    _RegoFFI.node_json_size(_node)

  // TODO
  fun json(buffer: Array[U8] iso): OkOrBufferTooSmall =>
    """
    Populate a buffer with the JSON representation of the node.

    The buffer must be large enough to hold the value. The size of the buffer
    can be determined by calling `json_size`.
    """
    _RegoFFI.node_json(_node, buffer.cpointer(), buffer.size().u32())

