primitive Rego
  """
  """
  fun set_log_level(level: LogLevel) =>
    """
    Sets the level of logging.

    This setting controls the amount of logging that will be output to stdout.
    The default level is `NoneLevel`.
    """
    _RegoFFI.set_log_level(level)
