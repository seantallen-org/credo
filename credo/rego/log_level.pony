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
