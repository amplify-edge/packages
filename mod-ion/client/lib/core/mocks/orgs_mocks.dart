class Org {
  final String name;

  static List<Org> orgsMock = [
    "London Tax Strike",
    "Shutdown Hambach Coal Mine",
    "Stop LNG Gas Export Depot"
  ].map((e) => Org(e)).toList();

  Org(this.name);
}
