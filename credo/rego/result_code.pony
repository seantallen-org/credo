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

primitive BufferTooSmall
  """
  This should never happen based on our usage of the FFI.
  If it does, it's a bug and we panic.
  """
primitive ResultOkOrBufferTooSmallParser
  // Based on our usage, we should never actually get
  // a BufferTooSmall result from the FFI.
  fun apply(i: RegoEnum): (Ok | BufferTooSmall) =>
    match i
    | 0 => Ok
    | 2 =>
      BadBufferUsage()
      BufferTooSmall
    else
      Unreachable()
      BufferTooSmall
    end

type OkOrInvalidLogLevel is (Ok | InvalidLogLevel)
primitive InvalidLogLevel

primitive ResultOkOrInvalidLogLevelParser
  fun apply(i: RegoEnum): OkOrInvalidLogLevel =>
    match i
    | 0 => Ok
    | 3 => InvalidLogLevel
    else
      Unreachable()
      InvalidLogLevel
    end
