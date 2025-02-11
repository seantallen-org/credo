class val Node
  let _node: RegoNode

  new val _create(node: RegoNode) =>
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

  fun value(): Array[U8] iso =>
    """
    Get node value
    """
    let required = _RegoFFI.node_value_size(_node).usize()
    let buffer = recover iso Array[U8](required) end
    _RegoFFI.node_value(_node, buffer.cpointer(), buffer.size().u32())
    consume buffer

  fun size(): RegoSize =>
    """
    Returns the number of children of the node.
    """
    _RegoFFI.node_size(_node)

  fun child_at(index: RegoSize): Node ?=>
    """
    Returns the child node at the specified index.
    """
    let ptr = _RegoFFI.node_get(_node, index)
    Node._create(ptr()?)

  fun json(): Array[U8] iso =>
    """
    Get the JSON representation of the node.
    """
    let required = _RegoFFI.node_json_size(_node).usize()
    let buffer = recover iso Array[U8](required) end
    _RegoFFI.node_json(_node, buffer.cpointer(), buffer.size().u32())
    consume buffer
