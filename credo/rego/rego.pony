primitive Rego
  """
  """

  fun build_info(): String =>
    """
    Returns a string of the form
    "VERSION (BUILD_NAME, BUILD_DATE) BUILD_TOOLCHAIN on PLATFORM"
    """
    _RegoFFI.build_info()

  fun version(): String =>
    """
    Returns the version of the Rego library.
    """
    _RegoFFI.version()

  fun set_log_level(level: LogLevel): OkOrInvalidLogLevel =>
    """
    Sets the level of logging.

    This setting controls the amount of logging that will be output to stdout.
    The default level is `NoneLevel`.
    """
    _RegoFFI.set_log_level(level)
