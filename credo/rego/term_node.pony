trait val TermNodeType

primitive BindingNode is TermNodeType
  """
  A binding. Will have two children, a `VarNode` and a `TermNode`.
  """

primitive VarNode is TermNodeType
  """
  A variable name.
  """

primitive TermNode is TermNodeType
  """
  A term. Will have one child of:

  - `ScalarNode`
  - `ArrayNode`
  - `SetNode`
  - `ObjectNode`
  """

primitive ScalarNode is TermNodeType
  """
  A scalar value. Will have one child of:

  - `IntNode`
  - `FloatNode`
  - `StringNode`
  - `TrueNode`
  - `FalseNode`
  - `NullNode`
  - `UndefinedNode`
  """

primitive ArrayNode is TermNodeType
  """
  An array. Will have one or more children of:

  - `TermNode`
  """

primitive SetNode is TermNodeType
  """
  A set. Will have one or more children of:

  - `TermNode`
  """

primitive ObjectNode is TermNodeType
  """
  An object. Will have one or more children of:

  - `ObjectItemNode`
  """

primitive ObjectItemNode is TermNodeType
  """
  An object item. Will have two children:

  - a `TermNode` (the key)
  - a `TermNode` (the value)
  """

primitive IntNode is TermNodeType
  """
  An integer value.
  """

primitive FloatNode is TermNodeType
  """
  A floating point value.
  """

primitive StringNode is TermNodeType
  """
  A string value.
  """

primitive TrueNode is TermNodeType
  """
  The boolean value `true`.
  """

primitive FalseNode is TermNodeType
  """
  The boolean value `false`.
  """

primitive NullNode is TermNodeType
  """
  A null value.
  """

primitive UndefinedNode is TermNodeType
  """
  An undefined value.
  """

primitive TermsNode is TermNodeType

primitive BindingsNode is TermNodeType

primitive ResultsNode is TermNodeType

primitive ResultNode is TermNodeType

primitive ErrorNode is TermNodeType
  """
  An error. Will have three children:

  - `ErrorMessageNode`
  - `ErrorAstNode`
  - `ErrorCodeNode`
  """

primitive ErrorMessageNode is TermNodeType
  """
  An error message.
  """

primitive ErrorAstNode is TermNodeType
  """
  An error AST.
  """

primitive ErrorCodeNode is TermNodeType
  """
  An error code.
  """

primitive ErrorSeqNode is TermNodeType
  """
  A sequence of errors. Will have one or more children of:

  - `ErrorNode`
  """

primitive InternalNode is TermNodeType
  """
  An internal node. Use `node_type_bame` to get the full value.
  """

primitive UnknownNode is TermNodeType
  fun apply(): RegoEnum => RegoEnum.max_value()

primitive TermNodeParser
  fun apply(i: RegoEnum): TermNodeType =>
    match i
    | 1000 => BindingNode
    | 1001 => VarNode
    | 1002 => TermNode
    | 1003 => ScalarNode
    | 1004 => ArrayNode
    | 1005 => SetNode
    | 1006 => ObjectNode
    | 1007 => ObjectItemNode
    | 1008 => IntNode
    | 1009 => FloatNode
    | 1010 => StringNode
    | 1011 => TrueNode
    | 1012 => FalseNode
    | 1013 => NullNode
    | 1014 => UndefinedNode
    | 1015 => TermsNode
    | 1016 => BindingsNode
    | 1017 => ResultsNode
    | 1018 => ResultNode
    | 1800 => ErrorNode
    | 1801 => ErrorMessageNode
    | 1802 => ErrorAstNode
    | 1803 => ErrorCodeNode
    | 1804 => ErrorSeqNode
    else
      Unreachable()
      UnknownNode
    end
