trait val ResultCode
  fun apply(): RegoEnum

primitive Ok is ResultCode
  fun apply(): RegoEnum => 0

primitive Error is ResultCode
  fun apply(): RegoEnum => 1

primitive BufferTooSmall is ResultCode
  fun apply(): RegoEnum => 2

primitive InvalidLogLevel is ResultCode
  fun apply(): RegoEnum => 3

primitive UnknownResultCode is ResultCode
  fun apply(): RegoEnum => RegoEnum.max_value()

primitive ResultCodeParser
  fun apply(i: RegoEnum): ResultCode =>
    match i
    | 0 => Ok
    | 1 => Error
    | 2 => BufferTooSmall
    | 3 => InvalidLogLevel
    else
      Unreachable()
      UnknownResultCode
    end


