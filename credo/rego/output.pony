class val Output
  let _output: RegoOutputPtr tag

  new val _create(output: RegoOutputPtr tag) =>
    _output = output

  fun _final() =>
    // TODO free the output
    None
