primitive Ok

type InterpreterResult is (Ok | InterpreterError)

class val InterpreterError
  """
  Message carrier for an interpreter error.
  """
  let message: String

  new val create(message': String) =>
    message = message'

primitive InterpreterResultParser
  fun apply(i: RegoEnum, interpreter: RegoInterpreter): InterpreterResult =>
    match i
    | 0 => Ok
    | 1 => InterpreterError(_RegoFFI.get_error(interpreter))
    else
      Unreachable()
      InterpreterError(_RegoFFI.get_error(interpreter))
    end

primitive _BufferTooSmall
  """
  This should never happen based on our usage of the FFI.
  If it does, it's a bug and we panic.
  """

primitive _ResultOkOrBufferTooSmallParser
  // Based on our usage, we should never actually get
  // a _BufferTooSmall result from the FFI.
  fun apply(i: RegoEnum): (Ok | _BufferTooSmall) =>
    match i
    | 0 => Ok
    | 2 =>
      BadBufferUsage()
      _BufferTooSmall
    else
      Unreachable()
      _BufferTooSmall
    end

primitive _InvalidLogLevel
  """
  This should never happen based on our usage of the FFI.
  If it does, it's a bug and we panic.
  """

primitive _ResultOkOrInvalidLogLevelParser
  fun apply(i: RegoEnum): (Ok | _InvalidLogLevel) =>
    match i
    | 0 => Ok
    | 3 =>
      BadLogLevel()
      _InvalidLogLevel
    else
      Unreachable()
      _InvalidLogLevel
    end
