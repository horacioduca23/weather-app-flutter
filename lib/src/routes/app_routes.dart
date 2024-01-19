enum AppRoutes {
  home('/'),
  details('details');

  const AppRoutes(
    this.path,
  );

  final String path;
}
