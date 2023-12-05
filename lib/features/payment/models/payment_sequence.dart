enum SequenceType {
  oneOff,
  recurring;

  String toDto() {
    switch (this) {
      case oneOff:
        return 'oneoff';
      case recurring:
        return 'recurring ';
    }
  }
}
