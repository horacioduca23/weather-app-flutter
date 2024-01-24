enum AppRoutes {
  home('/'),
  current('current'),
  details('details');

  const AppRoutes(
    this.path,
  );

  final String path;
}
