trait val TermNodeType
  fun apply(): RegoEnum

primitive BindingNode is TermNodeType
  fun apply(): RegoEnum => 1000

primitive VarNode is TermNodeType
  fun apply(): RegoEnum => 1001

primitive TermNode is TermNodeType
  fun apply(): RegoEnum => 1002

primitive ScalarNode is TermNodeType
  fun apply(): RegoEnum => 1003

primitive ArrayNode is TermNodeType
  fun apply(): RegoEnum => 1004

primitive SetNode is TermNodeType
  fun apply(): RegoEnum => 1005

primitive ObjectNode is TermNodeType
  fun apply(): RegoEnum => 1006

primitive ObjectItemNode is TermNodeType
  fun apply(): RegoEnum => 1007

primitive IntNode is TermNodeType
  fun apply(): RegoEnum => 1008

primitive FloatNode is TermNodeType
  fun apply(): RegoEnum => 1009

primitive StringNode is TermNodeType
  fun apply(): RegoEnum => 1010

primitive TrueNode is TermNodeType
  fun apply(): RegoEnum => 1011

primitive FalseNode is TermNodeType
  fun apply(): RegoEnum => 1012

primitive NullNode is TermNodeType
  fun apply(): RegoEnum => 1013

primitive UndefinedNode is TermNodeType
  fun apply(): RegoEnum => 1014

primitive TermsNode is TermNodeType
  fun apply(): RegoEnum => 1015

primitive BindingsNode is TermNodeType
  fun apply(): RegoEnum => 1016

primitive ResultsNode is TermNodeType
  fun apply(): RegoEnum => 1017

primitive ResultNode is TermNodeType
  fun apply(): RegoEnum => 1018

primitive ErrorNode is TermNodeType
  fun apply(): RegoEnum => 1800

primitive ErrorMessageNode is TermNodeType
  fun apply(): RegoEnum => 1801

primitive ErrorAstNode is TermNodeType
  fun apply(): RegoEnum => 1802

primitive ErrorCodeNode is TermNodeType
  fun apply(): RegoEnum => 1803

primitive ErrorSeqNode is TermNodeType
  fun apply(): RegoEnum => 1804

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
