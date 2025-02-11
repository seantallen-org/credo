type OkOrError is (Ok | Error)
primitive Ok
primitive Error

primitive ResultOkOrErrorParser
  fun apply(i: RegoEnum): OkOrError =>
    match i
    | 0 => Ok
    | 1 => Error
    else
      Unreachable()
      Error
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
