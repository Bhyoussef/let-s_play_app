enum PublicPrivateType {
  public,
  private;

  @override
  String toString() => name.toLowerCase();
}

formatPublicPrivate(map) {
  switch (map.toString().toLowerCase()) {
    case 'public':
      return PublicPrivateType.public;
    case 'private':
      return PublicPrivateType.private;
  }
  return PublicPrivateType.public;
}
