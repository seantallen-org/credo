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

type OkOrBufferTooSmall is (Ok | BufferTooSmall)
primitive BufferTooSmall

primitive ResultOkOrBufferTooSmallParser
  fun apply(i: RegoEnum): OkOrBufferTooSmall =>
    match i
    | 0 => Ok
    | 2 => BufferTooSmall
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
