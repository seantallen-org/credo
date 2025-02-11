type OkOrError is (Ok | Error)
type OkOrBufferTooSmall is (Ok | BufferTooSmall)
type OkOrInvalidLogLevel is (Ok | InvalidLogLevel)

primitive Ok

primitive Error

primitive BufferTooSmall

primitive InvalidLogLevel

primitive ResultOkOrErrorParser
  fun apply(i: RegoEnum): OkOrError =>
    match i
    | 0 => Ok
    | 1 => Error
    else
      Unreachable()
      Error
    end

primitive ResultOkOrBufferTooSmallParser
  fun apply(i: RegoEnum): OkOrBufferTooSmall =>
    match i
    | 0 => Ok
    | 2 => BufferTooSmall
    else
      Unreachable()
      BufferTooSmall
    end

primitive ResultOkOrInvalidLogLevelParser
  fun apply(i: RegoEnum): OkOrInvalidLogLevel =>
    match i
    | 0 => Ok
    | 3 => InvalidLogLevel
    else
      Unreachable()
      InvalidLogLevel
    end
