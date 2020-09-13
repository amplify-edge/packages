class Document {
  final String name;
  final String content;
  final String id;

  Document(this.id, this.name, this.content);
}

class StubData {
  static List<Document> documents = [
    Document(
      "1",
      "London Tax Strike",
      r'[{"insert":"London Tax Strike"},{"insert":"\n","attributes":{"heading":1}},{"insert":"\n"},{"insert":"Our goal","attributes":{"b":true}},{"insert":" is to force the London City Council to live up to its pledge to tackle the “climate emergency” by immediately ending high-emitting infrastructure projects: Specifically the immediate termination of the development of the Silvertown tunnel in east London, the Bow East concrete plant in Newham, and the Edmonton incinerator in Enfield.\nStrategy"},{"insert":"\n","attributes":{"heading":2}},{"insert":"To get enough London citizens to withhold 22 per cent of their council tax, which is the average proportion that normally goes to the Greater London Authority (GLA). Until the strike succeeds, the proceeds would be funneled to a “tax rebellion fund” aimed at achieving climate-related goals, specifically to fund Extinction Rebellions own London-wide Citizen’s Assembly to design an Emergency London Plan.\n\nLocation: Great London Authority City Hall, London, UK."},{"insert":"\n","attributes":{"block":"ul"}},'
          r'{"insert":"Contact: climate@xr.org"},{"insert":"\n","attributes":{"block":"ul"}},'
          r'{"insert":"Length: Indefinite"},'
          r'{"insert":"\n","attributes":{"block":"ul"}},'
          r'{"insert":"​","attributes":{"embed":{"type":"image","source":"asset://packages/mod_write/assets/london_strike.png"}}},{"insert":"\n"}]',
    ),
    Document(
      "2",
      "Shut Down Hambach Coal Mine",
      r'[{"insert":"Shut Down Hambach Coal Mine"},{"insert":"\n","attributes":{"heading":1}},{"insert":"Goal"},{"insert":"\n","attributes":{"heading":2}},{"insert":"We will strike aganist the proposal to build a new coal mine here in Germany and demand that the government refuse the proposal and divest from fossil fuels.\nStrategy"},{"insert":"\n","attributes":{"heading":2}},{"insert":"TBA\n\nLocation: Hambach Coal Mine, Niederzier, DE."},{"insert":"\n","attributes":{"block":"ul"}},{"insert":"Contact: climate@xr.org"},{"insert":"\n","attributes":{"block":"ul"}},'
          r'{"insert":"Length: 5 Month"},'
          r'{"insert":"\n","attributes":{"block":"ul"}},'
          r'{"insert":"​","attributes":{"embed":{"type":"image","source":"asset://packages/mod_write/assets/hambach.png"}}},{"insert":"\n"}]',
    ),
    Document(
      "3",
      "Stop LNG Gas Export Depot",
      r'[{"insert":"Stop LNG Gas Export Depot"},{"insert":"\n","attributes":{"heading":1}},{"insert":"Goal"},{"insert":"\n","attributes":{"heading":2}},{"insert":"We will state a peaceful NVDA at the Tacoma Pipeline with the demand to have it shut down.\n\nStrategy"},{"insert":"\n","attributes":{"heading":2}},{"insert":"TBA\n\nLocation: Pipeline, Tacoma, USA"},{"insert":"\n","attributes":{"block":"ul"}},{"insert":"Contact: climate@xr.org"},{"insert":"\n","attributes":{"block":"ul"}},'
          r'{"insert":"Length: 8 Weeks"},'
          r'{"insert":"\n","attributes":{"block":"ul"}},'
          r'{"insert":"​","attributes":{"embed":{"type":"image","source":"asset://packages/mod_write/assets/pipeline.png"}}},{"insert":"\n"}]',
    )
  ];
}
