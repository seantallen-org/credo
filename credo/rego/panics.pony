use @exit[None](status: U8)
use @fprintf[I32](stream: Pointer[U8] tag, fmt: Pointer[U8] tag, ...)
use @pony_os_stderr[Pointer[U8]]()

primitive BadBufferUsage
  """
  Panic if we hit a bad buffer usage in our library code.
  """
  fun apply(loc: SourceLoc = __loc) =>
    @fprintf(
      @pony_os_stderr(),
      ("We hit a bad buffer usage in %s at line %s\n" +
       "This shouldn't be possible unless a really bad bug has been introduced\n" +
       "Please open an issue at https://github.com/seantallen-org/credo/issues")
       .cstring(),
      loc.file().cstring(),
      loc.line().string().cstring())
    @exit(1)

primitive BadLogLevel
  """
  Panic is the log level API is being used incorrectly by our library code.
  """
  fun apply(loc: SourceLoc = __loc) =>
    @fprintf(
      @pony_os_stderr(),
      ("We hit a bad log level usage in %s at line %s\n" +
       "This shouldn't be possible unless a really bad bug has been introduced\n" +
       "Please open an issue at https://github.com/seantallen-org/credo/issues")
       .cstring(),
      loc.file().cstring(),
      loc.line().string().cstring())
    @exit(1)

primitive Unreachable
  """
  To be used in places that the compiler can't prove is unreachable but we are
  certain is unreachable and if we reach it, we'd be silently hiding a bug.
  """
  fun apply(loc: SourceLoc = __loc) =>
    @fprintf(
      @pony_os_stderr(),
      ("The unreachable was reached in %s at line %s\n" +
       "Please open an issue at https://github.com/seantallen-org/credo/issues")
       .cstring(),
      loc.file().cstring(),
      loc.line().string().cstring())
    @exit(1)
