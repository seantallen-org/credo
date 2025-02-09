trait val LogLevel
  fun apply(): RegoEnum

primitive NoneLevel is LogLevel
  fun apply(): RegoEnum => 0

primitive ErrorLevel is LogLevel
  fun apply(): RegoEnum => 1

primitive OutputLevel is LogLevel
  fun apply(): RegoEnum => 2

primitive WarnLevel is LogLevel
  fun apply(): RegoEnum => 3

primitive InfoLevel is LogLevel
  fun apply(): RegoEnum => 4

primitive DebugLevel is LogLevel
  fun apply(): RegoEnum => 5

primitive TraceLevel is LogLevel
  fun apply(): RegoEnum => 6

primitive UnknownLevel is LogLevel
  fun apply(): RegoEnum => RegoEnum.max_value()

primitive LogLevelParser
  fun apply(i: RegoEnum): LogLevel =>
    match i
    | 0 => NoneLevel
    | 1 => ErrorLevel
    | 2 => OutputLevel
    | 3 => WarnLevel
    | 4 => InfoLevel
    | 5 => DebugLevel
    | 6 => TraceLevel
    else
      Unreachable()
      UnknownLevel
    end
