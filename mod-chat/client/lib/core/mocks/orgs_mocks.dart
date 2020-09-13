class Org {
  final String name;

  static List<Org> orgsMock = [
    "London Tax Strike",
    "Shut Down Hambach Coal Mine",
    "Stop LNG Gas Export Depot"
  ].map((e) => Org(e)).toList();

  Org(this.name);
}
