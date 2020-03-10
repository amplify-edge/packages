import 'package:meta/meta.dart';

class Campaign {
  // final Id<Campaign> id;

  final String id;

  final String campaignName;

  final String logoUrl;

  final String goal;

  final List<String> crgQuantityMany;

  final List<String> crgIdsMany;

  final String alreadyPledged;

  final DateTime actionTime;

  final String actionLocation;

  final String campaignStill;

  final String minPioneers;

  final String minRebelsForMedia;

  final String minRebelsToWin;

  final String actionLength;

  final String actionType;

  final List<String> backingOrg;

  final String category;

  final String contact;

  final String histPrecedents;

  final String organization;

  final String strategy;

  final List<String> videoURL;

  final String uom;

  const Campaign({
    @required this.actionLength,
    @required this.actionType,
    @required this.alreadyPledged,
    @required this.backingOrg,
    @required this.campaignName,
    @required this.campaignStill,
    @required this.category,
    @required this.contact,
    @required this.crgIdsMany,
    @required this.crgQuantityMany,
    @required this.goal,
    @required this.histPrecedents,
    @required this.id,
    @required this.logoUrl,
    @required this.minPioneers,
    @required this.minRebelsForMedia,
    @required this.minRebelsToWin,
    @required this.organization,
    @required this.strategy,
    @required this.uom,
    @required this.videoURL,
    @required this.actionTime,
    @required this.actionLocation,
  })  : assert(id != null),
        assert(campaignName != null),
        assert(minPioneers != null),
        assert(minRebelsForMedia != null),
        assert(minRebelsToWin != null),
        assert(actionTime != null),
        assert(actionLocation != null),
        assert(alreadyPledged != null),
        assert(logoUrl != null),
        assert(crgQuantityMany != null),
        assert(actionLength != null),
        assert(actionType != null),
        assert(backingOrg != null),
        assert(category != null),
        assert(contact != null),
        assert(goal != null),
        assert(histPrecedents != null),
        assert(organization != null),
        assert(strategy != null),
        assert(videoURL != null),
        assert(uom != null),
        assert(crgIdsMany != null);
}

List<Campaign> mockCampaigns = [
  Campaign(
    actionLength: "1",
    actionType: "NVDA",
    alreadyPledged: "29738",
    backingOrg: [
      "Org 1",
      "Org 2",
      "Org 3",

    ],
    campaignName: "NY State Pipeline Shutdown",
    campaignStill: "NY State Pipeline Shutdown",
    category: "Climate",
    contact: "climate@xr.org",
    crgIdsMany: [],
    crgQuantityMany: [],
    goal: "We will state a peaceful NVDA at the NYC Pipeline with the demand to have it shut down.",
    histPrecedents: "TBA",
    id: "1",
    logoUrl: "https://images.fastcompany.net/image/upload/w_596,c_limit,q_auto:best,f_auto/wp-cms/uploads/2019/10/i-2-90414932-extinction-rebellion-symbol.jpg",
    minPioneers: "50",
    minRebelsForMedia: "5000",
    minRebelsToWin: "50,000",
    organization: "Extinction Rebellion XR",
    strategy: "TBA",
    uom: "uom",
    videoURL: [
   
    ],
    actionLocation: "NYC Pipeline, NY, USA",
    actionTime: DateTime(2020,4,4,11,04),
  ),
];
