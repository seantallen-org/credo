primitive RegoCPP
  """
  Information about the rego-cpp library.
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
